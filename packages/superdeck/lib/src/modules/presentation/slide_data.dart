import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../slide/slide_parts.dart';
import 'presentation_controller.dart';

part 'slide_data.mapper.dart';

@MappableClass()
class SlideData with SlideDataMappable {
  final int slideIndex;
  final Style style;
  final Slide _slide;
  final FixedSlidePartWidget? _header;
  final FixedSlidePartWidget? _footer;
  final SlidePartWidget? _background;
  final Map<String, WidgetBuilderWithOptions> _widgets;
  final int totalSlideCount;

  SlideData({
    required this.slideIndex,
    required this.style,
    required Slide slide,
    FixedSlidePartWidget? header,
    FixedSlidePartWidget? footer,
    SlidePartWidget? background,
    Map<String, WidgetBuilderWithOptions> widgets = const {},
    required this.totalSlideCount,
  })  : _slide = slide,
        _header = header,
        _footer = footer,
        _background = background,
        _widgets = widgets;

  AssetModel? getAssetByReference(String contents) {
    final reference = assetHash(contents);

    return _slide.assets.firstWhereOrNull((asset) =>
        asset.path == contents ||
        asset.reference == contents ||
        asset.reference == reference);
  }

  SlideOptions get options => _slide.options ?? const SlideOptions();

  String get key => _slide.key;

  Slide get data => _slide;

  List<SectionBlock> get sections => _slide.sections;

  List<NoteModel> get notes => _slide.notes;

  String get markdown => _slide.markdown;

  Widget buildHeader() => _PartBuilder(_header);

  Widget buildFooter() => _PartBuilder(_footer);

  Widget buildBackground() {
    return _background ?? const SizedBox.shrink();
  }

  WidgetBuilderWithOptions? getWidget(String name) {
    return _widgets[name];
  }
}

class _PartBuilder extends StatelessWidget {
  final SlidePartWidget? part;

  const _PartBuilder(this.part);

  @override
  Widget build(BuildContext context) {
    return part == null ? const SizedBox() : part!;
  }
}
