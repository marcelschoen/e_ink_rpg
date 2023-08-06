import 'package:flutter/material.dart';

import 'item.dart';

class Inventory {
  List<GameItem> items = [];

  void throwAwayItem(GameItem item) {
    items.remove(item);
  }

  void reset() {
    items.clear();
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

  List<Widget> getItemWidgets(BuildContext context) {
    List<Widget> itemWidgets = [];
    for (GameItem item in items) {
      itemWidgets.add(getItemWidget(context, item));
    }
    return itemWidgets;
  }

}