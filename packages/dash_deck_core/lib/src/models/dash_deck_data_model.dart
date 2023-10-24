import 'package:dart_mappable/dart_mappable.dart';
import 'package:dash_deck_core/dash_deck_core.dart';

part 'dash_deck_data_model.mapper.dart';

@MappableClass()
class DashDeckData with DashDeckDataMappable {
  final List<Slide> slides;

  const DashDeckData({
    this.slides = const [],
  });

  static final fromMap = DashDeckDataMapper.fromMap;
  static final fromJson = DashDeckDataMapper.fromJson;
}
