import 'package:e_ink_rpg/models/stat.dart';

import '../assets.dart';
import '../state.dart';
import 'attack.dart';
import 'effects.dart';


// -----------------------------------------------------------------------------
// Base class for all items
// -----------------------------------------------------------------------------
abstract class GameItem {

  String name = 'item';
  String description = '';
  ItemCategory itemCategory = ItemCategory.item;
  GameItemAsset itemAsset = GameItemAsset.apple;

  int price = -1;

  GameItem(this.itemAsset) {
    itemCollection.add(this);
    print ('> number of game items registered: ' + itemCollection.length.toString());
  }

  static List<GameItem> itemCollection = [];
}

enum ItemCategory {
  item,
  consumable,
  wearable,
  weapon,
  rune,
}

// -----------------------------------------------------------------------------
// Item that can be consumed for some effect
// -----------------------------------------------------------------------------
class Consumable extends GameItem {

  ItemCategory itemCategory = ItemCategory.consumable;

  // List of stats; the stat of corresponding type of the player
  // will be boosted by the value of this stat
  List<Stat> statValueBoostsOnConsume = [];

  // List of stats; the stat of corresponding type of the player
  // will be refilled and have its max value boosted by the max value of this stat
  List<Stat> statMaxValueBoostsOnConsume = [];

  // List of stats that will be restored completely when the item is consumed.
  List<Stat> statRestoreOnConsume = [];

  Consumable(GameItemAsset itemAsset) : super(itemAsset);

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

// -----------------------------------------------------------------------------
// Item that can be equiped (armor etc.)
// -----------------------------------------------------------------------------
mixin Wearable {

  List<Stat> statBoostsOnEquip = [];
  ItemCategory itemCategory = ItemCategory.wearable;

  WearableType wearableType = WearableType.none;

}

// -----------------------------------------------------------------------------
// Types of wearables
// -----------------------------------------------------------------------------
enum WearableType {
  none,
  // these can be equiped on body parts (armor)
  head,
  torso,
  shield,  // cloaks / capes
  arms,
  legs,
  // these are usually weapons or shields
  hands,
  // these can be put on in addition to armor
  rings,
  necklace
}

// -----------------------------------------------------------------------------
// Armor items
// -----------------------------------------------------------------------------
class Armor extends GameItem with Wearable {
  double defense = 2;
  Map<StatType, double> statBoosts = {};
  List<Effect> effects = [];

  Armor(GameItemAsset itemAsset) : super(itemAsset);

  addStatBoost(StatType type, double boostValue) {
    statBoosts.putIfAbsent(type, () => boostValue);
  }

  addEffect(Effect effect) {
    effects.add(effect);
  }
}

// -----------------------------------------------------------------------------
// Weapon items
// -----------------------------------------------------------------------------
class Weapon extends GameItem with Wearable {
  List<Attack> availableAttacks = [];
  ItemCategory itemCategory = ItemCategory.weapon;
  double attackPower = 1.0;
  bool twoHanded = false;

  Weapon(GameItemAsset itemAsset) : super(itemAsset) {
    this.wearableType = WearableType.hands;
    for (Attack attack in getAvailableAttacks()) {
      availableAttacks.add(attack);
    }
  }

  List<Attack> getAvailableAttacks() {
    return [Hit(), Swing()];
  }
}

// -----------------------------------------------------------------------------
// Weapon items
// -----------------------------------------------------------------------------
class Sword extends Weapon {

  Sword(GameItemAsset itemAsset) : super(itemAsset);

  List<Attack> getAvailableAttacks() {
    return [Hit(), Swing()];
  }
}

// -----------------------------------------------------------------------------
// Double-handed sword items
// -----------------------------------------------------------------------------
class LargeSword extends Sword {
  LargeSword(GameItemAsset itemAsset) : super(itemAsset) {
    twoHanded = true;
  }
}

// -----------------------------------------------------------------------------
// Dagger items
// -----------------------------------------------------------------------------
class Dagger extends Weapon {

  Dagger(GameItemAsset itemAsset) : super(itemAsset);

  List<Attack> getAvailableAttacks() {
    return [Hit()];
  }
}

