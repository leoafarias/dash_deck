import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../modules/presentation/deck_hooks.dart';
import '../atoms/slide_view.dart';

class SlideScreen extends HookWidget {
  const SlideScreen(
    this.slideIndex, {
    super.key,
  });

  final int slideIndex;

  @override
  Widget build(BuildContext context) {
    final slide = useDeckWatch((deck) => deck.getSlideByIndex(slideIndex));

    useAutomaticKeepAlive();

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 29, 29),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 3,
            ),
          ],
        ),
        child: SlideView(slide),
      ),
    );
  }
}
