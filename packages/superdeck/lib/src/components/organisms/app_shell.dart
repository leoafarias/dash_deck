import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck/src/components/organisms/thumbnail_panel.dart';

import '../../modules/common/helpers/hooks.dart';
import '../../modules/presentation/presentation_hooks.dart';
import '../molecules/bottom_bar.dart';
import '../molecules/scaled_app.dart';
import 'note_panel.dart';

final kScaffoldKey = GlobalKey<ScaffoldState>();

/// Builds the "shell" for the app by building a Scaffold with a
/// BottomNavigationBar, where [child] is placed in the body of the Scaffold.
class AppShell extends HookWidget {
  const AppShell({
    required this.child,
    super.key = const ValueKey<String>('app_shell'),
  });

  /// The navigation shell and container for the branch Navigators.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final actions = useDeck.actions();

    final bindings = {
      const SingleActivator(
        LogicalKeyboardKey.arrowRight,
        meta: true,
      ): actions.nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowDown,
        meta: true,
      ): actions.nextPage,
      const SingleActivator(
        LogicalKeyboardKey.space,
        meta: true,
      ): actions.nextPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowLeft,
        meta: true,
      ): actions.previousPage,
      const SingleActivator(
        LogicalKeyboardKey.arrowUp,
        meta: true,
      ): actions.previousPage,
    };

    return CallbackShortcuts(
      bindings: bindings,
      child: SplitView(
        child: child,
      ),
    );
  }
}

class SplitView extends HookWidget {
  final Widget child;

  const SplitView({
    super.key,
    required this.child,
  });

  final _thumbnailWidth = 300.0;
  final _duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    final isMenuOpen = useDeck.isMenuOpen();
    final actions = useDeck.actions();

    final bottomAnimation = useAnimationController(
      duration: _duration,
      initialValue: isMenuOpen ? 1.0 : 0.0,
    );

    usePostFrameEffect(() {
      if (isMenuOpen) {
        bottomAnimation.forward();
      } else {
        bottomAnimation.reverse();
      }
    }, [isMenuOpen]);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 9, 9),
      key: kScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: !isMenuOpen
          ? IconButton(
              onPressed: actions.openMenu,
              icon: const Icon(Icons.menu),
            )
          : null,
      body: Row(
        children: [
          SizeTransition(
            axis: Axis.horizontal,
            sizeFactor: CurvedAnimation(
              parent: bottomAnimation,
              curve: Curves.easeInOut,
            ),
            child: SizedBox(
              width: _thumbnailWidth,
              child: const Column(
                children: [
                  Expanded(flex: 3, child: ThumbnailPanel()),
                  IntrinsicHeight(
                    child: NotePanel(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Scaffold(
              bottomNavigationBar: SizeTransition(
                sizeFactor: CurvedAnimation(
                  parent: bottomAnimation,
                  curve: Curves.easeInOut,
                ),
                axis: Axis.vertical,
                child: const SdBottomBar(),
              ),
              body: Center(
                child: ScaledWidget(child: child),
              ),
            ),
          )
        ],
      ),
    );
  }
}
