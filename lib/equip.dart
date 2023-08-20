import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
//
// Equipment-related stuff
//
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Stores what the player has currently equiped
// -----------------------------------------------------------------------------
class Equipment {
  Wearable? head;

  Map<WearableType, Wearable> wearables = {};

  Equipment() {
  }

  GameItem? getWearable(WearableType wearableType) {
    Wearable? wearable = wearables[wearableType];
    return wearable == null ? null : wearable as GameItem;
  }

  equip(Wearable wearable) {
    wearables[wearable.wearableType] = wearable;
  }

  unequip(Wearable wearable) {
    wearables.remove(wearable.wearableType);
  }
}

// -----------------------------------------------------------------------------
// Stores a number of loadouts that the player can easily switch between
// -----------------------------------------------------------------------------
class Loadouts {
  static final int NUMBER_OF_LOADOUTS = 8;
  List<Equipment> loadouts = [];

  Loadouts() {
    for (int i = 0; i < NUMBER_OF_LOADOUTS; i++) {
      loadouts.add(Equipment());
    }
  }

  Equipment getLoadoutNo(int number) {
    return loadouts.elementAt(number);
  }
}

// -----------------------------------------------------------------------------
// Equip screen
// -----------------------------------------------------------------------------
Widget getEquipScreen(BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Column(
    children: [
      Expanded(
        child: Row(
          children: [
            Expanded(flex: 2, child: getEquipmentPanel()),
            Expanded(flex: 1,
              child: Scrollbar(
                controller: scrollController,
                thickness: 20,
                isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
                child: ListenableBuilder(
                  listenable: GameState().equipState,
                  builder: (BuildContext context, Widget? child) {
                    return GridView.count(
                      shrinkWrap: true,
                      controller: scrollController,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,
                        // Generate 100 widgets that display their index in the List.
                        children: GameState().player.inventory.getEquipableItemWidgets()
//                        children: GameState().player.inventory.getItemWidgets()
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      getLoadoutButtonsBar(),
    ],
  );
}

// -----------------------------------------------------------------------------
// Equipment details panel
// -----------------------------------------------------------------------------
Widget getEquipmentPanel() {
  return ListenableBuilder(
    listenable: GameState().equipState,
    builder: (BuildContext context, Widget? child) {
      return getCardWithRoundedBorder(
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getEquipmentFieldWithLabel('Head:', WearableType.head),
              vGap(40),
              getEquipmentFieldWithLabel('Body:', WearableType.torso),
              vGap(40),
              getEquipmentFieldWithLabel('Arms:', WearableType.arms),
              vGap(40),
              getEquipmentFieldWithLabel('Hands:', WearableType.hands),
              vGap(40),
              getEquipmentFieldWithLabel('Legs:', WearableType.legs),
            ],
        ),
          )
      );
    },
  );
}

// -----------------------------------------------------------------------------
// Creates a label with a item picture
// -----------------------------------------------------------------------------
Widget getEquipmentFieldWithLabel(String label, WearableType type) {
  GameItem? item = GameState().equipment.getWearable(type);
  Widget itemImage = FittedBox();
  if (item != null) {
    itemImage = FittedBox(child: item!.itemAsset.getItemImage());
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(label, textAlign: TextAlign.right, style: getTitleTextStyle(30)),
        ),
        InkWell(
            onTap: () {
              GameState().player.inventory.addItem(item);
              GameState().equipment.unequip(item as Wearable);
              GameState().equipState.update();
            },
            child: itemImage
        ),
      ],
    );
  }
  return Row(
    children: [
      SizedBox(width: 150, child: Text(label, textAlign: TextAlign.right, style: getTitleTextStyle(30)),
      ),
      itemImage,
    ],
  );
}

// -----------------------------------------------------------------------------
// Loadout buttons bar
// -----------------------------------------------------------------------------
Widget getLoadoutButtonsBar() {
  return getCardWithRoundedBorder(
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 6, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Loadout', style: getTitleTextStyle(32)),
          Row(
            children: [

            ],
          )
        ],
      ),
    )
  );
}
