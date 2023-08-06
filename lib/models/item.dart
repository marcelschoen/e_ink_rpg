import 'package:e_ink_rpg/models/stat.dart';
import 'package:flutter/material.dart';

import '../assets.dart';
import '../state.dart';
import 'attack.dart';


// ----------------
// Item widget
// ----------------
Widget getItemWidget(BuildContext context, GameItem item) {
  return FittedBox(
    child: Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black12,
      child: Column(children: [
        item.itemAsset.getItemImage(),
//      Text(item.name),
      ],),
    ),
  );
}

// ----------------------------------------------
// Base class for all items
// ----------------------------------------------
abstract class GameItem {

  String name = 'item';
  String description = '';
  ItemCategory itemCategory = ItemCategory.item;
  GameItemAsset itemAsset = GameItemAsset.apple;

  int price = -1;
}

enum ItemCategory {
  item,
  consumable,
  wearable,
  weapon,
  rune,
}

// ----------------------------------------------
// Weapon items
// ----------------------------------------------
mixin Weapon {
  List<Attack> availableAttacks = [];
  ItemCategory itemCategory = ItemCategory.weapon;
}

// ----------------------------------------------
// Item that can be consumed for some effect
// ----------------------------------------------
mixin Consumable {

  ItemCategory itemCategory = ItemCategory.consumable;

  // List of stats; the stat of corresponding type of the player
  // will be boosted by the value of this stat
  List<Stat> statValueBoostsOnConsume = [];

  // List of stats; the stat of corresponding type of the player
  // will be refilled and have its max value boosted by the max value of this stat
  List<Stat> statMaxValueBoostsOnConsume = [];

  // List of stats that will be restored completely when the item is consumed.
  List<Stat> statRestoreOnConsume = [];

  consume() {
    // simpler items just refill one of the stats (e.g. health)
    for (Stat boosted in statValueBoostsOnConsume) {
      if (GameState().player.hasStat(boosted.statType)) {
        int boostValue = boosted.value();
        GameState().player.restoreStatBy(boosted.statType, boostValue);
      }
    }
    // more valuable items increase the max value of the stat
    for (Stat boosted in statMaxValueBoostsOnConsume) {
      if (GameState().player.hasStat(boosted.statType)) {
        int boostValue = boosted.maxValue();
        GameState().player.setStatMaxValue(boosted.statType, boostValue);
        GameState().player.restoreStat(boosted.statType);
      }
    }
  }
}

// ----------------------------------------------
// Item that can be equiped (armor etc.)
// ----------------------------------------------
mixin Wearable {

  List<Stat> statBoostsOnEquip = [];
  ItemCategory itemCategory = ItemCategory.wearable;

  WearableType wearableType = WearableType.none;

}

enum WearableType {
  none,
  // these can be equiped on body parts (armor)
  head,
  torso,
  hands,
  legs,
  feet,
  // these can be put on in addition to armor
  rings,
  necklace
}