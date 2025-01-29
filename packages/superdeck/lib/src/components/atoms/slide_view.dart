import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/deck/slide_configuration.dart';
import '../molecules/block_widget.dart';

class SlideView extends StatelessWidget {
  final SlideConfiguration slide;
  const SlideView(
    this.slide, {
    super.key,
  });

  Widget _renderPreferredSize(PreferredSizeWidget? widget) {
    return widget != null
        ? SizedBox.fromSize(
            size: widget.preferredSize,
            child: widget,
          )
        : const SizedBox.shrink();
  }

  Widget _renderSections(List<SectionElement> sections) {
    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalFlex = slide.sections.fold(0, (sum, e) => sum + (e.flex ?? 1));
    final normalizedFlex = totalFlex == 0 ? 1 : totalFlex;

    return Column(
      children: sections.map((e) {
        final heightPercentage = 1 / normalizedFlex;
        return Expanded(
          flex: e.flex ?? 1,
          child: SectionBlockWidget(e, heightPercentage: heightPercentage),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = slide.parts.header?.preferredSize.height ?? 0;
    final footerHeight = slide.parts.footer?.preferredSize.height ?? 0;

    return SpecBuilder(
      style: slide.style,
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: slide.parts.background ?? const SizedBox.shrink(),
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromPoints(
                      const Offset(0, 0),
                      Offset(kResolution.width, headerHeight),
                    ),
                    child: _renderPreferredSize(slide.parts.header),
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromPoints(
                      Offset(0, headerHeight),
                      Offset(
                        kResolution.width,
                        kResolution.height - footerHeight,
                      ),
                    ),
                    child: _renderSections(slide.sections),
                  ),
                  Positioned.fromRect(
                    rect: Rect.fromPoints(
                      Offset(0, kResolution.height - footerHeight),
                      Offset(kResolution.width, kResolution.height),
                    ),
                    child: _renderPreferredSize(slide.parts.footer),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
