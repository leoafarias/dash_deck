import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../modules/common/helpers/controller.dart';
import '../../modules/presentation/slide_data.dart';
import '../molecules/block_widget.dart';

class SlideView extends StatelessWidget {
  final SlideData slide;
  const SlideView(
    this.slide, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final totalFlex = slide.sections
        .map((e) => e.flex ?? 1)
        .reduce((value, element) => value + element);
    return Provider(
      data: slide,
      child: SpecBuilder(
        style: slide.style,
        builder: (context) {
          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: slide.buildBackground(),
                    ),
                    Column(
                      children: slide.sections
                          .map(
                            (e) => Expanded(
                              flex: e.flex ?? 1,
                              child: SectionBlockWidget(e,
                                  heightPercentage: (e.flex ?? 1) / totalFlex),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
