import 'package:flutter_hooks/flutter_hooks.dart';

import '../common/helpers/controller.dart';
import 'presentation_controller.dart';
import 'slide_data.dart';

UseDeckController get useDeck {
  return UseDeckController();
}

class UseDeckController extends UseController<DeckController> {
  UseDeckController();

  UseDeckActions actions() {
    final context = useContext();
    return UseDeckActions(Provider.of<DeckController>(context));
  }

  List<SlideData> slides() => select((controller) => controller.slides);
  DeckConfiguration configuration() => select((c) => c.configuration);
  SlideData selectSlide(int index) {
    final allSlides = slides();
    if (index < 0 || index >= allSlides.length) {
      throw Exception('Invalid slide index: $index');
    }

    final selectedSlide = allSlides[index];

    return useMemoized(() => selectedSlide, [selectedSlide]);
  }

  int slideCount() => select((controller) => controller.slides.length);
  bool isMenuOpen() => select((c) => c.isMenuOpen);
  bool showNotes() => select((c) => c.isNotesShown);

  int currentPage() => select((c) => c.currentPage);
  int currentSlideIndex() => currentPage() - 1;
  SlideData activeSlide() => select((c) => c.currentSlide);
}

class UseDeckActions {
  final DeckController controller;
  UseDeckActions(this.controller);

  void goToPage(int page) => controller.goToSlide(page - 1);
  void nextPage() => controller.nextSlide();
  void previousPage() => controller.previousSlide();
  void openMenu() => controller.openMenu();
  void closeMenu() => controller.closeMenu();
  void toggleMenu() => controller.toggleMenu();
  void toggleNotes() => controller.toggleNotes();
  void showNotes() => controller.showNotes();
  void hideNotes() => controller.hideNotes();
}
