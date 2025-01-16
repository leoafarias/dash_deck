import 'package:superdeck_core/src/models/block_model.dart';

class RawSlide {
  String key;
  String markdown;
  Map<String, dynamic> options;
  List<String> comments;
  List<SectionElement> sections;

  RawSlide({
    required this.key,
    required this.markdown,
    required this.options,
    required this.comments,
    required this.sections,
  });
}
