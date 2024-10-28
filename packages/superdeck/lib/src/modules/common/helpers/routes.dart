import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_paths/go_router_paths.dart';

import '../../../../../superdeck.dart';
import '../../../components/molecules/slide_screen.dart';
import '../../../screens/export_screen.dart';
import 'dialog_page.dart';

class SDPaths {
  static Path get root => Path('/');
  static ExportPath get export => ExportPath();
  // static Param<Param> get slides => Param('slides', 'slideId');
  static SlidesPath get slides => SlidesPath();

  static ChatPath get chat => ChatPath();
}

class ExportPath extends Path<ExportPath> {
  ExportPath() : super('export');
}

class SlidesPath extends Path<SlidesPath> {
  SlidesPath() : super('slides');
  SlidePath get slide => SlidePath(this);
}

class SlidePath extends Param<SlidePath> {
  SlidePath(SlidesPath slidesPath) : super.only('slideId', parent: slidesPath);
}

class ChatPath extends Path<ChatPath> {
  ChatPath() : super('chat');
}

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final goRouterConfig = GoRouter(
  navigatorKey: kRootNavigatorKey,
  initialLocation: SDPaths.slides.goRoute,
  restorationScopeId: 'root',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      restorationScopeId: 'shell1',
      parentNavigatorKey: kRootNavigatorKey,
      builder: (context, state, navigationShell) {
        return AppShell(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: SDPaths.slides.goRoute,
                pageBuilder: (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const SlideScreen(0),
                    ),
                routes: [
                  GoRoute(
                    path: SDPaths.slides.slide.goRoute,
                    pageBuilder: (context, state) {
                      final index = int.parse(
                        state.pathParameters[SDPaths.slides.slide.id] ?? '0',
                      );
                      return _getPageTransition(
                        SlideScreen(index),
                        state,
                      );
                    },
                  ),
                ]),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: SDPaths.export.goRoute,
              pageBuilder: (context, state) {
                return _getDialogPage(const ExportScreen(), state);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

MaterialPage _getPage(Widget child, GoRouterState state,
    {bool isRoot = false}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
    maintainState: true,
    canPop: !isRoot,
  );
}

DialogPage _getDialogPage(Widget child, GoRouterState state) {
  return DialogPage(
    key: state.pageKey,
    builder: (context) => child,
  );
}

CustomTransitionPage<void> _getPageTransition(
  Widget child,
  GoRouterState state,
) {
  final extra = state.extra as Map<String, dynamic>?;
  final isBack = extra?['replace'] as bool? ?? false;
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
