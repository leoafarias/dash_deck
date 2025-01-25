import '../common/helpers/controller.dart';
import 'presentation_controller.dart';

DeckController useDeck() => useController<DeckController>();

T useDeckWatch<T>(T Function(DeckController) selector) =>
    useControllerWatch(selector);
