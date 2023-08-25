import 'package:dotted_border/dotted_border.dart';
import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/item.dart';

class Inventory {
  List<InventoryGameItemStack> itemStacks = [];

  void removeOneItemFromStack(InventoryGameItemStack itemStack) {
    itemStack.remove(1);
    if (itemStack.item == null) {
      itemStacks.remove(itemStack);
    }
  }

  void deselectAllStacks() {
    for (InventoryGameItemStack itemStack in itemStacks) {
      itemStack.selected = false;
    }
  }

  void selectStack(InventoryGameItemStack itemStack) {
    deselectAllStacks();
    itemStack.selected = true;
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
    InventoryGameItemStack? stack = _findStackForItem(item);
    if (stack != null) {
      stack.stackSize ++;
      return;
    }
/*
    for (InventoryGameItemStack itemStack in itemStacks) {
      if (itemStack.item.runtimeType == item.runtimeType && itemStack.stackSize < 99) {
        itemStack.stackSize ++;
        return;
      }
    }

 */
    itemStacks.add(InventoryGameItemStack(item));
  }

  void removeItem(GameItem item) {
    InventoryGameItemStack? stack = _findStackForItem(item);
    if (stack != null) {
      stack.remove(1);
    }
  }

  InventoryGameItemStack? _findStackForItem(GameItem item) {
    for (InventoryGameItemStack itemStack in itemStacks) {
      if (itemStack.item.runtimeType == item.runtimeType && itemStack.stackSize < 99) {
        return itemStack;
      }
    }
    return null;
  }

  void addVariousItems(Iterable<GameItem> newItems) {
    for (GameItem item in newItems) {
      addItem(item);
    }
  }

  void removeStack(InventoryGameItemStack itemStack) {
    itemStacks.remove(itemStack);
    GameState().inventorySelectionState.update();
  }

  // ---------------------------------------------------------------------------
  // List of equipable items from inventory
  // ---------------------------------------------------------------------------
  List<Widget> getEquipableItemWidgets() {
    List<Widget> itemWidgets = [];
    for (InventoryGameItemStack itemStack in itemStacks) {
      if (itemStack.item != null &&
          (itemStack.item!.itemCategory == ItemCategory.wearable
          || itemStack.item!.itemCategory == ItemCategory.weapon)) {
        itemWidgets.add(getItemStackWidget(itemStack, 56, (p0) { getSelectEquippableItemFunction(itemStack); }, false ));
      }
    }
    return itemWidgets;
  }

  // ---------------------------------------------------------------------------
  // List of inventory items
  // ---------------------------------------------------------------------------
  List<Widget> getItemWidgets() {
    List<Widget> itemWidgets = [];
    for (InventoryGameItemStack itemStack in itemStacks) {
      if (itemStack.item != null) {
        itemWidgets.add(getItemStackWidget(itemStack, 56, (p0) { getSelectInventoryItemFunction(itemStack); }, true ));
      }
    }
    return itemWidgets;
  }

}

// -----------------------------------------------------------------------------
// Holder for a stack of items in the inventory
// -----------------------------------------------------------------------------
class InventoryGameItemStack {
  int stackSize = 0;
  bool selected = false;
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

  clear() {
    stackSize = 0;
    item = null;
  }
}

// -----------------------------------------------------------------------------
// Inventory screen
// -----------------------------------------------------------------------------
Widget getInventoryScreen(BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          controller: scrollController,
          thickness: 20,
          isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().inventorySelectionState,
            builder: (BuildContext context, Widget? child) {
              return GridView.count(
                controller: scrollController,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 6,
                // Generate 100 widgets that display their index in the List.
                children: GameState().player.inventory.getItemWidgets()
              );
            },
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid,
                    width: 4
                ),
              ),
              child: SizedBox(
                height: 180,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black12,
                        child: Container(
                          margin: EdgeInsets.only(top: 4, bottom: 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Details', style: getTitleTextStyle(18)),
                            ],
                          ),
                        ),
                      ),
                      inventoryItemDetails(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(children: [
            BaseButton.textOnlyWithSizes("Use", (p0) => { useItem() }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Combine", (p0) => { print('>> NAME: ' + NameHandler.elvenNames.compose(3)) }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard", (p0) => { discardItem(false) }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard all", (p0) => { discardItem(true) }, 26, 160, 2 ),
          ],)
        ],
      )
    ],
  );
}

// ---------------------------------------------------------------------
// The box with the details of the selected item stack
// ---------------------------------------------------------------------
Widget inventoryItemDetails() {
  return Expanded(
    child: Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(5),
      child: ListenableBuilder(
        listenable: GameState().inventorySelectionState,
        builder: (BuildContext context, Widget? child) {
          return Row(
            children: getSelectedInventoryItemDetails(),
          );
        },
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// The item image and description of the selected item stack
// ---------------------------------------------------------------------
List<Widget> getSelectedInventoryItemDetails() {
  List<Widget> detailContents = [];
  if (GameState().selectedInInventory != null) {
    detailContents.add(SizedBox(width: 160,
        child: getItemStackWidget(GameState().selectedInInventory!, 96, null, false )));
    detailContents.add(Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
        child: Text(GameState().selectedInInventory!.item!.description, style: getTitleTextStyle(20)))
      )
    );
  }
  return detailContents;
}

// --------------------------------------------------------------------
// Uses the selected item (consumes food etc.
// --------------------------------------------------------------------
void useItem() {
  if (GameState().selectedInInventory != null) {
    if (GameState().selectedInInventory!.item! is Consumable) {
      // TODO - CONSUME ITEM
      var consumable = GameState().selectedInInventory!.item! as Consumable;
      consumable.consume();
      GameState().selectedInInventory!.remove(1);
      GameState().inventorySelectionState.update();
    }
  }
}

// --------------------------------------------------------------------
// Discards the currently selected item
// --------------------------------------------------------------------
void discardItem(bool discardAll) {
  if (GameState().selectedInInventory != null) {
    if (discardAll) {
      GameState().selectedInInventory!.clear();
    } else {
      GameState().player.inventory.removeOneItemFromStack(GameState().selectedInInventory!);
    }
    GameState().selectedInInventory = null;
    GameState().inventorySelectionState.update();
  }
}

// --------------------------------------------------------------------
// Function for selecting an equipable item
// --------------------------------------------------------------------
getSelectEquippableItemFunction(InventoryGameItemStack itemStack) {
  GameState().selectedInEquipment = itemStack!.item;
  GameState().equipState.update();

}

getSelectInventoryItemFunction(InventoryGameItemStack itemStack) {
  GameState().selectedInInventory = itemStack;
  GameState().player.inventory.selectStack(itemStack);
  GameState().inventorySelectionState.update();
}

// ---------------------------------------------------------------------
// Item stack widget
// ---------------------------------------------------------------------
Widget getItemStackWidget(InventoryGameItemStack itemStack, double length, Function(InventoryGameItemStack itemStack)? doStuff, bool selectionBorder) {
  if (doStuff == null) {
    return _getDetailIconWidget(itemStack, length, false);
  }

  return InkWell(
    onTap: () {
      doStuff!(itemStack);
    },
    child: _getDetailIconWidget(itemStack, length, selectionBorder),
  );
}

Widget _getDetailIconWidget(InventoryGameItemStack itemStack, double length, bool selectionBorder) {
  Size size = Size(length, length);
  return getItemBorder(selectionBorder ? itemStack.selected : false, Column(
    children: [
      Expanded(
        child: Container(
          constraints: BoxConstraints.tight(size),
          padding: const EdgeInsets.all(4),
          child: FittedBox(child: itemStack.item!.itemAsset.getItemImage()),
        ),
      ),

      Row(
        children: [
          Container(
              color: Colors.black,
              width: 24,
              height: 36,
              alignment: Alignment.center,
              child: Text(itemStack.stackSize.toString(),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
                  textAlign: TextAlign.center)
          ),
          Expanded(
            child: Text(itemStack.item!.name,
                style: TextStyle(fontWeight: FontWeight.bold, ),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    ],
  ),
  );
}

// ---------------------------------------------------------------------
// Border around selected inventory item stack
// ---------------------------------------------------------------------
Widget getItemBorder(bool selected, Widget content) {
  if(selected) {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 4,
      color: Colors.blueGrey,
      radius: Radius.circular(8),
      padding: EdgeInsets.all(4),
      child: content,
    );
  }
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      color: Colors.black12,
      child: content,
    ),
  );
}