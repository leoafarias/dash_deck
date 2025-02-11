import 'package:flutter/material.dart';
import 'package:superdeck/src/components/atoms/slide_thumbnail.dart';
import 'package:superdeck/src/components/organisms/comments_panel.dart';
import 'package:superdeck/src/components/organisms/thumbnail_panel.dart';
import 'package:superdeck/src/modules/common/helpers/constants.dart';

import '../../modules/deck/deck_controller.dart';
import '../../modules/navigation/navigation_controller.dart';
import '../molecules/bottom_bar.dart';
import '../molecules/scaled_app.dart';
import 'keyboard_shortcuts.dart';

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

    final deckController = DeckController.of(context);

    final currentSlide = navigation.currentSlide;
    final isMenuOpen = navigation.isMenuOpen;
    final isNotesOpen = navigation.isNotesOpen;

    return KeyboardShortcuts(
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
                    slideConfig: deckController.slides[index],
                  );
                },
                itemCount: deckController.slides.length,
              ),
            ),
            isNotesOpen
                ? Expanded(
                    flex: 1,
                    child: CommentsPanel(
                      comments: currentSlide.comments,
                    ),
                  )
                : const SizedBox(),
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
  late final _duration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _duration,
      vsync: this,
      value: widget.isOpen ? 1.0 : 0.0,
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

    final animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: !isMenuOpen
          ? IconButton(
              onPressed: navigation.openMenu,
              icon: const Icon(Icons.menu),
            )
          : null,
      bottomNavigationBar: SizeTransition(
        sizeFactor: animation,
        axis: Axis.vertical,
        child: const DeckBottomBar(),
      ),
      body: Row(
        children: [
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: animation,
            child: SizedBox(
              width: 300,
              child: widget.sideWidget,
            ),
          ),
          Expanded(
            child: Center(
              child: ScaledWidget(
                targetSize: kResolution,
                child: widget.child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
