import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/item.dart';

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
}



// -----------------------------------------------------------------------------
// Inventory screen
// -----------------------------------------------------------------------------

// MISSING BUTTONS FOR SELECTED ITEM ("Use", "Discard", ...)

Widget getInventoryScreen(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          thickness: 20,
          isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().inventoryGridState,
            builder: (BuildContext context, Widget? child) {
              return GridView.count(
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 6,
                  // Generate 100 widgets that display their index in the List.
                  children: GameState().player.inventory.getItemWidgets(context)
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
                height: 110,
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
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(5),
                          child: Text('dfa adf adf adf asdf ', style: getTitleTextStyle(16)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(children: [
            BaseButton.textOnly("Use", (p0) {
                if (GameState().selectedInInventory != null) {
                  print("* use " + GameState().selectedInInventory!.item!.name + " *");
                  if (GameState().selectedInInventory!.item! is Consumable) {
                    // TODO - CONSUME ITEM
                    var consumable = GameState().selectedInInventory!.item! as Consumable;
                    consumable.consume();
                    GameState().selectedInInventory!.remove(1);
                    GameState().inventoryGridState.update();
                  }
                }
              }),
            BaseButton.textOnly("Discard", (p0) {
                if (GameState().selectedInInventory != null) {
                  GameState().selectedInInventory!.remove(1);
                  GameState().inventoryGridState.update();
                }
              }),
          ],)
        ],
      )
    ],
  );
}

// ----------------
// Item widget
// ----------------
Widget getItemWidget(BuildContext context, InventoryGameItemStack itemStack) {
  Size size = Size(56, 56);
  return InkWell(
    onTap: () {
      print("* tapped: " + itemStack.item!.name + " *");
      GameState().selectedInInventory = itemStack;
      GameState().inventoryGridState.update();
      /*
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
          title: Text(itemStack.item!.name),
          content: Text(itemStack.item!.description),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
        );
        */
    },
    child: getItemBorder(itemStack, Column(
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
                  child: Text(itemStack.stackSize.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
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
    ),
  );
}

Widget getItemBorder(InventoryGameItemStack itemStack, Widget content) {
  if(itemStack.selected) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 3.0,
          ),
        ),
      ),
      child: content,
    );
  }
  return Container(
    color: Colors.black12,
    child: content,
  );
}