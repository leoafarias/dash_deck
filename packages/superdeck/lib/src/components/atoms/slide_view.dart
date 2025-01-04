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
    final totalFlex = slide.sections.fold(0, (sum, e) => sum + (e.flex ?? 1));
    final normalizedFlex = totalFlex == 0 ? 1 : totalFlex;
    final hasSections = slide.sections.isNotEmpty;
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
                    hasSections
                        ? Column(
                            children: slide.sections
                                .map(
                                  (e) => Expanded(
                                    flex: e.flex ?? 1,
                                    child: SectionBlockWidget(e,
                                        heightPercentage:
                                            (e.flex ?? 1) / normalizedFlex),
                                  ),
                                )
                                .toList(),
                          )
                        : Container(),
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
