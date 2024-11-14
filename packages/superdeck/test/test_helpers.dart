import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck/src/modules/common/helpers/controller.dart';
import 'package:superdeck/src/modules/common/styles/style.dart';
import 'package:superdeck/src/modules/presentation/presentation_controller.dart';
import 'package:superdeck/src/modules/presentation/slide_data.dart';
import 'package:superdeck_core/superdeck_core.dart';

extension WidgetTesterX on WidgetTester {
  Future<void> pumpWithScaffold(Widget widget) async {
    await pumpWidget(MaterialApp(home: Scaffold(body: widget)));
  }

  Future<void> pumpSlide(
    SlideData slide, {
    bool isSnapshot = false,
    DeckStyle? style,
    Map<String, WidgetBuilderWithOptions> widgets = const {},
    List<AssetModel> assets = const [],
  }) async {
    final controller = DeckController(
        options: DeckConfiguration(
      styles: const {},
      baseStyle: style ?? const DeckStyle(),
      widgets: widgets,
    ));
    return pumpWithScaffold(
      Provider(
        data: slide,
        child: Provider(
          data: controller,
          child: SlideView(slide),
        ),
      ),
    );
  }
}
