import 'package:flutter/material.dart';

import 'item.dart';

class Inventory {
  List<InventoryGameItemStack> itemStacks = [];

  void throwAwayItem(InventoryGameItemStack itemStack) {
    itemStack.remove(1);
    if (itemStack.item == null) {
      itemStacks.remove(itemStack);
    }
  }

  void reset() {
    itemStacks.clear();
  }

  void addItems(GameItem item, int number) {
    for (int i = 0; i < number; i++) {
      addItem(item);
    }
  }

  void addItem(GameItem item) {
    for (InventoryGameItemStack itemStack in itemStacks) {
      if (itemStack.item.runtimeType == item.runtimeType && itemStack.stackSize < 99) {
        itemStack.stackSize ++;
        return;
      }
    }
    itemStacks.add(InventoryGameItemStack(item));
  }

  void addVariousItems(Iterable<GameItem> newItems) {
    for (GameItem item in newItems) {
      addItem(item);
    }
  }
  /*
  Iterable<GameItem> getItemsByCategory(ItemCategory category) {

    return itemStacks.where((element) => element.itemCategory == category);
  }

   */

  List<Widget> getItemWidgets(BuildContext context) {
    List<Widget> itemWidgets = [];
    for (InventoryGameItemStack itemStack in itemStacks) {
      itemWidgets.add(getItemWidget(context, itemStack));
    }
    return itemWidgets;
  }

}

class InventoryGameItemStack {
  int stackSize = 0;
  GameItem? item = null;

  InventoryGameItemStack(this.item) {
    this.stackSize = 1;
  }

  InventoryGameItemStack.multiple(this.item, this.stackSize);

  remove(int number) {
    stackSize -= number;
    if (stackSize <= 0) {
      stackSize = 0;
      item = null;
    }
  }
}