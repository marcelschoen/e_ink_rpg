import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:flutter/services.dart';

import '../assets.dart';
import '../state.dart';
import 'attack.dart';
import 'attribute.dart';
import 'effects.dart';


// -----------------------------------------------------------------------------
// Provides item instances
// -----------------------------------------------------------------------------
class ItemRegistry {

  static Map<String, GameItem> _itemMap = {};
  static Map<int, GameItem> _itemIndex = {};

  static GameItem getItem(String itemName) {
    return _itemMap[itemName]!;
  }

  static GameItem getItemById(num itemId) {
    return _itemIndex[itemId]!;
  }

  static void registerItem(GameItem item) {
    _itemMap[item.name] = item;
    _itemIndex[item.id] = item;
  }

  static Iterable<int> getRegisteredIds() {
    return _itemIndex.keys;
  }

  static loadJson() async {
    /*
    print('------------> CONTENT <------------');
    debugPrint(content, wrapWidth: 1024);
    print('------------> ENDx <------------');
     */
    String jsonConsumables = await loadAsset('consumables.json');
    Map<String, dynamic> consumables = _processJsonData(jsonConsumables, 'food', 'consumables.json');
    _processConsumables(consumables, 1000);

    String jsonWeapons = await loadAsset('weapons.json');
    Map<String, dynamic> weapons = _processJsonData(jsonWeapons, 'sword', 'weapons.json');
    _processJsonData(jsonWeapons, 'dagger', 'weapons.json');
    _processJsonData(jsonWeapons, 'largeSword', 'weapons.json');
    _processWeapons(weapons, 'sword', 2000);
    _processWeapons(weapons, 'dagger', 3000);
    _processWeapons(weapons, 'largeSword', 4000);

    String jsonArmor = await loadAsset('armor.json');
    Map<String, dynamic> armor = _processJsonData(jsonArmor, 'head', 'armor.json');
    _processJsonData(jsonArmor, 'torso', 'armor.json');
    _processJsonData(jsonArmor, 'arms', 'armor.json');
    _processJsonData(jsonArmor, 'legs', 'armor.json');
    _processArmor(armor, 'head', 5000);
    _processArmor(armor, 'torso', 6000);
    _processArmor(armor, 'arms', 7000);
    _processArmor(armor, 'legs', 8000);
  }

  static Future<String> loadAsset(String filename) async {
    return await rootBundle.loadString('assets/item/' + filename);
  }

  // Processes JSON data containing game items, validates the "id" field and returns a map
  static Map<String, dynamic> _processJsonData(String json, String node, String filename) {
    Map<String, dynamic> data = jsonDecode(json);
    List<dynamic> entries = data[node];
    Set<int> usedIds = {};
    for (int index = 0; index < entries.length; index ++) {
      var id = entries[index]['id'];
      var name = entries[index]['name'];
      if (id == null) {
        throw 'Invalid JSON data in: ' + filename + ' / entry ' + (name == null ? '?' : name) + ' has no "id" field.';
      }
      int number = id;
      if (usedIds.contains(number)) {
        throw 'Invalid JSON data in: ' + filename + ' / id ' + id.toString() + ' used more than once.';
      }
      usedIds.add(number);
    }
    return data;
  }

  static _processArmor(Map<String, dynamic> armor, String node, num indexOffset) {
    List<dynamic> wearable = armor[node];
    for (int index = 0; index < wearable.length; index ++) {
      var id = wearable[index]['id'];
      var asset = wearable[index]['asset'];
      var name = wearable[index]['name'];
      var description = wearable[index]['description'];
      var price = wearable[index]['price'];
      var defense = wearable[index]['defense'];
      Armor armor = Armor(GameItemAsset.values.byName(asset));
      armor.id = id + indexOffset;
      armor.name = name;
      armor.description = description;
      armor.setDefense(defense);
      armor.setPrice(price);
      if (node == 'head') {
        armor.wearableType = WearableType.head;
      } else if (node == 'torso') {
        armor.wearableType = WearableType.torso;
      } else if (node == 'arms') {
        armor.wearableType = WearableType.arms;
      } else if (node == 'legs') {
        armor.wearableType = WearableType.legs;
      } else if (node == 'necklace') {
        armor.wearableType = WearableType.necklace;
      } else if (node == 'rings') {
        armor.wearableType = WearableType.rings;
      }
      ItemRegistry.registerItem(armor);
    }
  }

  static _processWeapons(Map<String, dynamic> weapons, String node, num indexOffset) {
    List<dynamic> swords = weapons[node];
    for (int index = 0; index < swords.length; index ++) {
      var id = swords[index]['id'];
      var asset = swords[index]['asset'];
      var name = swords[index]['name'];
      var description = swords[index]['description'];
      var attackPower = swords[index]['attackPower'];
      var price = swords[index]['price'];
      if (node == 'sword') {
        Sword sword = Sword(GameItemAsset.values.byName(asset));
        sword.id = id + indexOffset;
        sword.name = name;
        sword.description = description;
        sword.setAttackPower(attackPower);
        sword.setPrice(price);
        ItemRegistry.registerItem(sword);
      } else if (node == 'dagger') {
        Dagger dagger = Dagger(GameItemAsset.values.byName(asset));
        dagger.id = id + indexOffset;
        dagger.name = name;
        dagger.description = description;
        dagger.setAttackPower(attackPower);
        dagger.setPrice(price);
        ItemRegistry.registerItem(dagger);
      } else if (node == 'largeSword') {
        LargeSword largeSword = LargeSword(GameItemAsset.values.byName(asset));
        largeSword.id = id + indexOffset;
        largeSword.name = name;
        largeSword.description = description;
        largeSword.setAttackPower(attackPower);
        largeSword.setPrice(price);
        ItemRegistry.registerItem(largeSword);
      }
    }
  }

  // Processes all "consumables" items
  static _processConsumables(Map<String, dynamic> consumables, num indexOffset) {
    List<dynamic> food = consumables['food'];
    for (int index = 0; index < food.length; index ++) {
      var id = food[index]['id'];
      var asset = food[index]['asset'];
      var name = food[index]['name'];
      var description = food[index]['description'];
      var restoreHealth = food[index]['restoreHealth'];
      if (name == null) {
        name = _camelCasedAssetName(asset);
      }
      if (description == null) {
        description = 'Restores ' + restoreHealth.toString() + ' HP';
      }
      Consumable consumable = Consumable(GameItemAsset.values.byName(asset));
      consumable.id = id + indexOffset;
      consumable.name = name;
      consumable.description = description;
      if (restoreHealth == -1) {
        consumable.statRestoreOnConsume.add(StatType.health);
      } else {
        consumable.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, restoreHealth, restoreHealth));
      }
      ItemRegistry.registerItem(consumable);
    }
  }

  // Turns asset name 'bread_ration' into 'Bread Ration'
  static String _camelCasedAssetName(String assetName) {
    return StringUtils.capitalize(assetName.replaceAll('_', ' '), allWords: true);
  }
}



// -----------------------------------------------------------------------------
// Base class for all items
// -----------------------------------------------------------------------------
abstract class GameItem {

  int id = 0;
  String name = 'item';
  String description = '';
  ItemCategory itemCategory = ItemCategory.item;
  GameItemAsset itemAsset = GameItemAsset.apple;
  Map<AttributeType, Attribute> _attrs = {};

  GameItem() {
    setAttrValue(AttributeType.price, -1);
  }

  setPrice(double value) {
    setAttrValue(AttributeType.price, value);
  }

  GameItem.fromAsset(this.itemAsset) {
    itemCollection.add(this);
  }

  increaseAttrValueBy(AttributeType type, double value) {
    _attrs[type]!.increaseValueBy(value);
  }

  double attrValue(AttributeType type) {
    return _attrs.containsKey(type) ? _attrs[type]!.value() : 0;
  }

  Attribute getAttribute(AttributeType type) {
    return _attrs[type]!;
  }

  void setAttrValue(AttributeType type, double value) {
    if (!_attrs.containsKey(type)) {
      setAttribute(Attribute.withValue(type, value));
    } else {
      _attrs[type]!.setValueTo(value);
    }
  }

  void setAttribute(Attribute attr) {
    _attrs[attr.type] = attr;
  }

  static List<GameItem> itemCollection = [];
}

// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
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
  List<StatType> statRestoreOnConsume = [];

  Consumable(GameItemAsset itemAsset) : super.fromAsset(itemAsset);

//  factory Consumable.fromJson(Map<String, dynamic> consumable) =>
//      Consumable(_toInt(consumable['id']), consumable['name']);
/*
  Consumable clone() {
    Consumable consumable = Consumable(this.itemAsset);
    consumable.itemCategory = this.itemCategory;
    consumable.statRestoreOnConsume = this.statRestoreOnConsume;
    consumable.statValueBoostsOnConsume = this.statValueBoostsOnConsume;
    consumable.statMaxValueBoostsOnConsume = this.statMaxValueBoostsOnConsume;
    consumable.price = this.price;
    consumable.description = this.description;
    return consumable;
  }
*/

  consume() {
    // simpler items just refill one of the stats (e.g. health)
    for (Stat boosted in statValueBoostsOnConsume) {
      if (GameState().player.hasStat(boosted.statType)) {
        double boostValue = boosted.value();
        GameState().player.restoreStatBy(boosted.statType, boostValue);
      }
    }
    // more valuable items increase the max value of the stat
    for (Stat boosted in statMaxValueBoostsOnConsume) {
      if (GameState().player.hasStat(boosted.statType)) {
        double boostValue = boosted.maxValue();
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
  Map<StatType, double> statBoosts = {};
  List<Effect> effects = [];

  Armor(GameItemAsset itemAsset) : super.fromAsset(itemAsset) {
    setAttrValue(AttributeType.defense, 2);
  }

  setDefense(double value) {
    setAttrValue(AttributeType.defense, value);
  }

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
  bool twoHanded = false;

  Weapon(GameItemAsset itemAsset) : super.fromAsset(itemAsset) {
    this.wearableType = WearableType.hands;
    setAttrValue(AttributeType.attackPower, 1.0);
    for (Attack attack in getAvailableAttacks()) {
      availableAttacks.add(attack);
    }
  }

  setAttackPower(double value) {
    setAttrValue(AttributeType.attackPower, value);
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

