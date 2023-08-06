import 'item.dart';

class Inventory {
  List<GameItem> items = [];

  void throwAwayItem(GameItem item) {
    items.remove(item);
  }

  void addItem(GameItem item) {
    items.add(item);
  }

  void addItems(Iterable<GameItem> newItems) {
    items.addAll(newItems);
  }

  Iterable<GameItem> getItemsByCategory(ItemCategory category) {
    return items.where((element) => element.itemCategory == category);
  }
}