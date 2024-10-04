import '../common/helpers/controller.dart';
import '../navigation/navigation_hooks.dart';
import '../slide/slide_configuration.dart';
import 'deck_controller.dart';

T _useSelectController<T>(T Function(DeckController) selector) {
  final controller = useController<DeckController>();
  return selector(controller);
}

List<SlideData> useSlides() {
  return _useSelectController((controller) => controller.slides);
}

SlideData useCurrentSlide() {
  final index = useCurrentSlideIndex();
  return _useSelectController((controller) => controller.slides[index]);
}

// SlideConfiguration useCurrentSlide() {
//   final index = useCurrentSlideIndex();
//   return useSlideConfiguration(index);
// }

WidgetBuilderWithOptions? useDeckExamples(String name) {
  return _useSelectController(
    (controller) => controller.getWidget(name),
  );
}

double useTotalPartsHeight() {
  return _useSelectController((controller) => controller.totalPartsHeight);
}
