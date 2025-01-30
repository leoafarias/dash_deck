import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck/src/components/atoms/slide_thumbnail.dart';
import 'package:superdeck/src/components/organisms/thumbnail_panel.dart';
import 'package:superdeck/src/modules/common/helpers/constants.dart';

import '../../modules/deck/deck_configuration.dart';
import '../../modules/navigation/navigation_controller.dart';
import '../molecules/bottom_bar.dart';
import '../molecules/scaled_app.dart';
import 'note_panel.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
  });

  /// The navigation shell and container for the branch Navigators.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationController.of(context);

    final slides = DeckController.of(context).slides;

    final currentSlide = navigation.currentSlide;
    final isMenuOpen = navigation.isMenuOpen;

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
        meta: true,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
        meta: true,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
        meta: true,
      ): navigation.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
        meta: true,
      ): navigation.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
        meta: true,
      ): navigation.previousSlide,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: SplitView(
        isOpen: isMenuOpen,
        sideWidget: Column(
          children: [
            Expanded(
              flex: 3,
              child: ThumbnailPanel(
                onItemTap: navigation.goToSlide,
                activeIndex: currentSlide.slideIndex,
                itemBuilder: (index, selected) {
                  return SlideThumbnail(
                    selected: selected,
                    slide: slides[index],
                  );
                },
                itemCount: slides.length,
              ),
            ),
            IntrinsicHeight(
              child: NotePanel(notes: currentSlide.comments),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class SplitView extends StatefulWidget {
  const SplitView({
    super.key,
    required this.isOpen,
    required this.child,
    required this.sideWidget,
  });

  final Widget child;
  final Widget sideWidget;

  final bool isOpen;

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> with TickerProviderStateMixin {
  late final _thumbnailWidth = 300.0;
  late final _duration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _duration,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(SplitView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      if (widget.isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigation = NavigationController.of(context);
    final isMenuOpen = navigation.isMenuOpen;

    return Row(
      children: [
        SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
          child: SizedBox(
            width: _thumbnailWidth,
            child: widget.sideWidget,
          ),
        ),
        Expanded(
          child: Scaffold(
            key: kScaffoldKey,
            backgroundColor: const Color.fromARGB(255, 9, 9, 9),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniEndFloat,
            floatingActionButton: !isMenuOpen
                ? IconButton(
                    onPressed: navigation.openMenu,
                    icon: const Icon(Icons.menu),
                  )
                : null,
            bottomNavigationBar: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
              axis: Axis.vertical,
              child: const SdBottomBar(),
            ),
            body: Center(
              child: ScaledWidget(
                targetSize: kResolution,
                child: widget.child,
              ),
            ),
          ),
        )
      ],
    );
  }
}
