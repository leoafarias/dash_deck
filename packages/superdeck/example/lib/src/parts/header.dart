import 'package:flutter/material.dart';
import 'package:superdeck/superdeck.dart';

class HeaderPart extends FixedSlidePartWidget {
  const HeaderPart({
    super.key,
  });

  @override
  double get height => 0;

  @override
  Widget build(context) {
    final slide = Provider.of<SlideData>(context);

    final index = slide.slideIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(slide.options?.title ?? 'Generative UI with Flutter'),
          const SizedBox(width: 20),
          Text('${index + 1}'),
        ],
      ),
    );
  }
}
