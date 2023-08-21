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

  bool hasEquipped(GameItem item) {
    print('>>>> CHECK IF EQUIPPED: ' + item.name);
    for (Wearable wearable in wearables.values) {
      GameItem equippedItem = wearable as GameItem;
      print('>>>> check against: ' + equippedItem.name);
      if (equippedItem.name == item.name) {
        return true;
      }
    }
    return false;
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
                      equipmentItemDetails(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(children: [
            ListenableBuilder(
              listenable: GameState().equipState,
              builder: (BuildContext context, Widget? child) {
                return getEquipOrUnequipButton();
              },
            ),
          ],)
        ],
      ),
      getLoadoutButtonsBar(),
    ],
  );
}

Widget getEquipOrUnequipButton() {
  if (GameState().selectedInEquipment != null) {
    if (GameState().equipment.hasEquipped(GameState().selectedInEquipment!)) {
      return BaseButton.textOnlyWithSizes("Unequip", (p0) => {  }, 26, 160, 2 );
    } else {
      return BaseButton.textOnlyWithSizes("Equip", (p0) => {  }, 26, 160, 2 );
    }
  }
  return BaseButton.textOnlyWithSizes("...", (p0) => {  }, 26, 160, 2 );
}


// ---------------------------------------------------------------------
// The box with the details of the selected item stack
// ---------------------------------------------------------------------
Widget equipmentItemDetails() {
  return Expanded(
    child: Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(5),
      child: ListenableBuilder(
        listenable: GameState().equipState,
        builder: (BuildContext context, Widget? child) {
          return Row(
            children: getSelectedEquipmentItemDetails(),
          );
        },
      ),
    ),
  );
}

// ---------------------------------------------------------------------
// The item image and description of the selected item stack
// ---------------------------------------------------------------------
List<Widget> getSelectedEquipmentItemDetails() {
  List<Widget> detailContents = [];
  if (GameState().selectedInEquipment != null) {
    detailContents.add(SizedBox(width: 160,
        child: getEquipmentItemWidget(GameState().selectedInEquipment!, 96)));
    detailContents.add(Expanded(
        child: Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Text(GameState().selectedInEquipment!.description, style: getTitleTextStyle(20)))
    )
    );
  }
  return detailContents;
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
              vGap(20),
              getEquipmentFieldWithLabel('Body:', WearableType.torso),
              vGap(20),
              getEquipmentFieldWithLabel('Arms:', WearableType.arms),
              vGap(20),
              getEquipmentFieldWithLabel('Hands:', WearableType.hands),
              vGap(20),
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
              print('---> tapped equipped item: ' + item!.name + ' <----');
              /*
              GameState().player.inventory.addItem(item);
              GameState().equipment.unequip(item as Wearable);

               */
              GameState().selectedInEquipment = item!;
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

// ---------------------------------------------------------------------
// Item widget
// ---------------------------------------------------------------------
Widget getEquipmentItemWidget(GameItem gameItem, double length) {
  Size size = Size(length, length);
  return Column(
    children: [
      Expanded(
        child: Container(
          constraints: BoxConstraints.tight(size),
          padding: const EdgeInsets.all(4),
          child: FittedBox(child: gameItem.itemAsset.getItemImage()),
        ),
      ),

      Row(
        children: [
          Expanded(
            child: Text(gameItem.name,
                style: TextStyle(fontWeight: FontWeight.bold, ),
                textAlign: TextAlign.center),
          ),
        ],
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Loadout', style: getTitleTextStyle(32)),
          getLoadoutButton(' 1 '),
          getLoadoutButton(' 2 '),
          getLoadoutButton(' 3 '),
          getLoadoutButton(' 4 '),
          getLoadoutButton(' 5 '),
          getLoadoutButton(' 6 '),
          getLoadoutButton(' 7 '),
          getLoadoutButton(' 8 '),
        ],
      ),
    )
  );
}

Widget getLoadoutButton(String label) {
  return InkWell(
    onTap: () { print('select loadout ' + label); } ,
    child: Container(
      color: Colors.black12,
      child: Text(label, style: getTitleTextStyle(30)),
    ),
  );
}
