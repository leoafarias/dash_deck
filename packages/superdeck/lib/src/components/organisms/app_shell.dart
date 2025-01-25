import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck/src/components/atoms/slide_thumbnail.dart';
import 'package:superdeck/src/components/organisms/thumbnail_panel.dart';
import 'package:superdeck/src/modules/presentation/presentation_controller.dart';

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
    final controller = DeckController.of(context);

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
        meta: true,
      ): controller.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
        meta: true,
      ): controller.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.space,
        meta: true,
      ): controller.nextSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
        meta: true,
      ): controller.previousSlide,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
        meta: true,
      ): controller.previousSlide,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: Scaffold(
        key: kScaffoldKey,
        backgroundColor: const Color.fromARGB(255, 9, 9, 9),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: controller.watch(
          selector: (state) => state.isMenuOpen,
          builder: (context, isMenuOpen) {
            return IconButton(
              onPressed: controller.openMenu,
              icon: const Icon(Icons.menu),
            );
          },
        ),
        body: controller.watch(
            selector: (c) => c.isMenuOpen,
            builder: (context, isMenuOpen) {
              return SplitView(
                isOpen: isMenuOpen,
                sideWidget: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: controller.watch(
                          selector: (c) => (
                                currentSlideIndex: c.currentSlideIndex,
                                slideCount: c.slides.length
                              ),
                          builder: (context, value) {
                            return ThumbnailPanel(
                              onItemTap: controller.goToSlide,
                              activeIndex: value.currentSlideIndex,
                              itemBuilder: (index) => SlideThumbnail(
                                page: index + 1,
                                selected: index == value.currentSlideIndex,
                                slide: controller.getSlideByIndex(index),
                              ),
                              itemCount: value.slideCount,
                            );
                          }),
                    ),
                    IntrinsicHeight(
                      child: controller.watch(
                        selector: (c) => c.currentSlide.comments,
                        builder: (context, comments) {
                          return NotePanel(notes: comments);
                        },
                      ),
                    ),
                  ],
                ),
                child: child,
              );
            }),
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
            bottomNavigationBar: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
              axis: Axis.vertical,
              child: const SdBottomBar(),
            ),
            body: Center(
              child: ScaledWidget(child: widget.child),
            ),
          ),
        )
      ],
    );
  }
}
