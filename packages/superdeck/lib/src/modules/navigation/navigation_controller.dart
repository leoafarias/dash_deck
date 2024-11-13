import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';

import '../../components/molecules/slide_screen.dart';
import '../../components/organisms/app_shell.dart';
import '../common/helpers/controller.dart';
import '../common/helpers/routes.dart';
import '../slide/slide_configuration.dart';

class NavigationController extends Controller {
  late bool isPresenterMenuOpen;
  late bool showNotes;
  late int currentSlideIndex;

  late final int totalSlides;
  late final GoRouter router;

  NavigationController({
    required List<SlideData> slides,
  }) {
    totalSlides = slides.length;
    router = _buildRouter(slides);
    currentSlideIndex = _get('currentSlideIndex', 0);
    isPresenterMenuOpen = _get('isPresenterMenuOpen', false);
    showNotes = _get('showNotes', false);

    router.routeInformationProvider.addListener(() {
      final uri = router.routeInformationProvider.value.uri;

      final pathParam = uri.queryParameters[SDPaths.slides.slide.id] ?? '0';
      final slideIndex = int.tryParse(pathParam) ?? 0;

      print('Slide index: $slideIndex');

      if (slideIndex != currentSlideIndex) {
        currentSlideIndex = slideIndex;
        notifyListeners();
      }
    });

    addListener(() {
      _set('currentSlideIndex', currentSlideIndex);
      _set('isPresenterMenuOpen', isPresenterMenuOpen);
      _set('showNotes', showNotes);
    });
  }

  void goToSlide(int index) {
    if (index < 0 || index >= totalSlides) return;
    if (currentSlideIndex == index) return;

    final isForward = index > currentSlideIndex;
    final slidePath = SDPaths.slides.slide.define(index.toString()).path;
    currentSlideIndex = index;

    router.go(slidePath, extra: {'replace': !isForward});
  }

  void nextSlide() {
    goToSlide(currentSlideIndex + 1);
  }

  void previousSlide() {
    goToSlide(currentSlideIndex - 1);
  }

  void togglePresenterMenu() {
    isPresenterMenuOpen = !isPresenterMenuOpen;
  }

  void closePresenterMenu() {
    isPresenterMenuOpen = false;
  }

  void openPresenterMenu() {
    isPresenterMenuOpen = true;
  }

  void toggleShowNotes() {
    showNotes = !showNotes;
  }
}

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter _buildRouter(List<SlideData> slides) {
  return GoRouter(
    navigatorKey: kRootNavigatorKey,
    initialLocation: SDPaths.root.path,
    redirect: (context, state) => SDPaths.slides.slide.define('0').path,
    restorationScopeId: 'root',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: kRootNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: slides.mapIndexed((index, slide) {
          return GoRoute(
            path: SDPaths.slides.slide.define(index.toString()).path,
            pageBuilder: (context, state) {
              return _getPageTransition(
                SlideScreen(index),
                state,
              );
            },
          );
        }).toList(),
      ),
    ],
  );
}

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

T _get<T>(String key, T defaultValue) {
  final stringValue = localStorage.getItem(key);
  return stringValue == null ? defaultValue : jsonDecode(stringValue) as T;
}

void _set<T>(String key, T value) {
  localStorage.setItem(key, jsonEncode(value));
}
