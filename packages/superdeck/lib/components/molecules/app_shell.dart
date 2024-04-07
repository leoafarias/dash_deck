import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watcher/watcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../helpers/constants.dart';
import '../../helpers/json_schema.dart';
import '../../helpers/loader.dart';
import '../../helpers/local_storage.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/asset_model.dart';
import '../../models/options_model.dart';
import '../../models/slide_model.dart';
import '../../superdeck.dart';
import '../../theme.dart';
import 'scaled_app.dart';
import 'slide_view.dart';

class SuperDeckApp extends StatefulWidget {
  const SuperDeckApp({
    super.key,
    this.style,
    this.widgetBuilders,
  });

  static Future<void> initialize() async {
    await _initialize();
  }

  final Style? style;
  final Map<String, WidgetBuilderOptions>? widgetBuilders;

  @override
  // ignore: library_private_types_in_public_api
  _SuperDeckAppState createState() => _SuperDeckAppState();
}

class _SuperDeckAppState extends State<SuperDeckApp> {
  late List<Slide> _slides = [];
  late List<SlideAsset> _assets = [];
  late Config _config = const Config.empty();
  Slide? _errorSlide;
  bool _loading = true;

  List<StreamSubscription<WatchEvent>> _subscriptions = [];

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  void dispose() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  void _setSlides(List<Slide> slides) {
    // only update state if slide optinos are different
    if (!listEquals(slides, _slides)) {
      setState(() {
        _slides = slides;
      });
    }
  }

  void _setAssets(List<SlideAsset> assets) {
    // only update state if assets are different
    if (!listEquals(assets, _assets)) {
      setState(() {
        _assets = assets;
      });
    }
  }

  void _setProjectConfig(Config projectOptions) {
    // only update state if project options are different
    if (projectOptions != _config) {
      setState(() {
        _config = projectOptions;
      });
    }
  }

  Future<void> _loadData() async {
    try {
      await SuperDeckApp.initialize();

      final project = await _loadProjectConfig();
      final (slides, assets) = await SlidesLoader.loadFromStorage();

      setState(() {
        _slides = slides;
        _assets = assets;
        _config = project;
      });
      if (kDebugMode) {
        _subscriptions = _registerLocalListener();
      }
    } catch (e) {
      print('Error loading slides: $e');
      rethrow;
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<Config> _loadProjectConfig() async {
    try {
      final project = await SlidesLoader.loadProjectConfig();
      _errorSlide = null;
      return project;
    } on SchemaValidationException catch (e) {
      _errorSlide = InvalidSlide.projectSchemaError(e.result);

      return const Config.empty();
    } on Exception catch (e) {
      _errorSlide = InvalidSlide.exception(e);

      return const Config.empty();
    }
  }

  StreamSubscription<WatchEvent> _createFileListener(
    File file,
    void Function() callback,
  ) {
    return FileWatcher(file.path).events.listen((event) async {
      if (event.type == ChangeType.MODIFY) {
        callback();
      }
    });
  }

  List<StreamSubscription<WatchEvent>> _registerLocalListener() {
    return [
      _createFileListener(config.slidesMarkdownFile, () async {
        print('Reloading slides');
        final (slides, assets) = await SlidesLoader.load();
        _setSlides(slides);
        _setAssets(assets);
      }),
      _createFileListener(config.projectConfigFile, () async {
        print('Reloading project config');
        _setProjectConfig(await _loadProjectConfig());
      })
    ];
  }

  @override
  Widget build(BuildContext context) {
    final slides = _errorSlide != null ? [_errorSlide!] : _slides;
    return ScaledApp(builder: (context, _) {
      return MaterialApp(
        theme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: MixTheme(
          data: MixThemeData.withMaterial(),
          child: Scaffold(
            body: SuperDeck(
              slides: slides,
              assets: _assets,
              style: defaultStyle.merge(widget.style),
              projectOptions: _config,
              widgetBuilders: widget.widgetBuilders ?? {},
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : const AppShell(),
            ),
          ),
        ),
      );
    });
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _isPaging = Future.value();

  @override
  Widget build(BuildContext context) {
    final slides = SuperDeck.slidesOf(context);
    final style = SuperDeck.styleOf(context);

    Future<void> goToPage(int page) async {
      if (page < 0 || page >= slides.length) return;
      await _isPaging;

      _isPaging = _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      // _pageController.jumpToPage(page);
    }

    void nextPage() => goToPage(_pageController.page!.toInt() + 1);

    void previousPage() => goToPage(_pageController.page!.toInt() - 1);
    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.space,
      ): nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
      ): previousPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
      ): previousPage,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: Pressable(
        onPress: () {},
        child: StyledWidgetBuilder(
            style: style.animate(),
            builder: (mix) {
              final spec = SlideSpec.of(mix);

              return AnimatedMixedBox(
                duration: mix.animation?.duration ?? const Duration(),
                spec: spec.outerContainer,
                child: PageView(
                  // scrollDirection: Axis.vertical,
                  controller: _pageController,
                  children: slides.map(SlideView.new).toList(),
                ),
              );
            }),
      ),
    );
  }
}

Future<void> _initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorage.initialize();
  await SyntaxHighlight.initialize();

  // Return if its web
  if (kIsWeb) return;
  // Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: kResolution,
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    minimumSize: Size(640, 360),
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await windowManager.setAspectRatio(kAspectRatio);
}
