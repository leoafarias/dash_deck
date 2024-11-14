import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../components/molecules/slide_screen.dart';
import '../modules/common/helpers/hooks.dart';
import '../modules/presentation/presentation_hooks.dart';

class PresentationScreen extends HookWidget {
  const PresentationScreen({super.key});

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeInOutCubic;

  @override
  Widget build(BuildContext context) {
    final slideIndex = useDeck.currentSlideIndex();
    final pageController = usePageController(initialPage: slideIndex);

    final slides = useDeck.slides();

    usePostFrameEffect(() {
      if (slideIndex >= slides.length) {
        return;
      }

      if (slideIndex < 0) {
        return;
      }
      pageController.animateToPage(
        slideIndex,
        duration: _duration,
        curve: _curve,
      );
    }, [slideIndex, slides.length]);

    return PageView(
      controller: pageController,
      children: slides.mapIndexed((index, slide) {
        return SlideScreen(index);
      }).toList(),
    );
  }
}
