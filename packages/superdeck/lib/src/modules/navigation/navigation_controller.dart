import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/molecules/slide_screen.dart';
import '../../components/organisms/app_shell.dart';
import '../common/helpers/provider.dart';
import '../deck/slide_configuration.dart';
import '../navigation/routes.dart';

class NavigationController extends ChangeNotifier {
  late final GoRouter _router;

  bool _isMenuOpen = false;
  late SlideConfiguration _currentSlide;
  late List<SlideConfiguration> _slides;
  bool _isNotesVisible = false;
  NavigationController({required List<SlideConfiguration> slides}) {
    _router = _buildRouter(slides);
    _registerListener(_router);
    _currentSlide = slides[0];
    _slides = slides;
  }

  GoRouter get router => _router;

  bool get isMenuOpen => _isMenuOpen;
  bool get isNotesOpen => _isNotesVisible;

  SlideConfiguration get currentSlide => _currentSlide;

  void updateSlides(List<SlideConfiguration> slides) {
    _router.dispose();
    _router = _buildRouter(slides);
    _registerListener(_router);
    notifyListeners();
  }

  void _registerListener(GoRouter router) {
    router.routeInformationProvider.addListener(() {
      final uri = router.routeInformationProvider.value.uri;

      final pathParam = uri.toString().startsWith(SDPaths.slides.path)
          ? uri.pathSegments.last
          : '0';
      final slideIndex = int.tryParse(pathParam) ?? 0;

      if (slideIndex != _currentSlide.slideIndex) {
        _currentSlide = _slides[slideIndex];
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  Widget provide({required Widget child}) {
    return InheritedNotifierData(
      data: this,
      child: child,
    );
  }

  static NavigationController of(BuildContext context) {
    return InheritedNotifierData.of<NavigationController>(context);
  }

  GoRouter _buildRouter(List<SlideConfiguration> slides) {
    return GoRouter(
        initialLocation: SDPaths.slides.goRoute,
        redirect: (context, state) =>
            state.path == SDPaths.root.path ? SDPaths.slides.goRoute : null,
        navigatorKey: _kRootNavigatorKey,
        restorationScopeId: 'root',
        routes: <RouteBase>[
          ShellRoute(
            navigatorKey: _kShellRouteNavigatorKey,
            builder: (context, state, child) => AppShell(child: child),
            routes: [
              GoRoute(
                parentNavigatorKey: _kShellRouteNavigatorKey,
                path: SDPaths.slides.goRoute,
                builder: (context, state) => SlideScreen(slides[0]),
                routes: slides.mapIndexed((index, slide) {
                  return GoRoute(
                    path: index.toString(),
                    pageBuilder: (context, state) {
                      final slideIndex = int.parse(state.path ?? '0');
                      return _getPageTransition(
                        SlideScreen(slides[slideIndex]),
                        state,
                      );
                    },
                  );
                }).toList(),
              )
            ],
          ),
        ]);
  }

  void goToSlide(int index) {
    if (index < 0 || index >= _slides.length) {
      return;
    }
    _router.go(SDPaths.slides.slide.define(index.toString()).path);
  }

  void nextSlide() => goToSlide(_currentSlide.slideIndex + 1);

  void previousSlide() => goToSlide(_currentSlide.slideIndex - 1);

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void closeMenu() {
    _isMenuOpen = false;
    notifyListeners();
  }

  void openMenu() {
    _isMenuOpen = true;
    notifyListeners();
  }

  void toggleNotes() {
    _isNotesVisible = !_isNotesVisible;
    notifyListeners();
  }

  void hideNotes() {
    _isNotesVisible = false;
    notifyListeners();
  }

  void showNotes() {
    _isNotesVisible = true;
    notifyListeners();
  }
}

final _kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _kShellRouteNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

CustomTransitionPage<void> _getPageTransition(
  Widget child,
  GoRouterState state,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    maintainState: true,
    transitionDuration: const Duration(milliseconds: 1000),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
