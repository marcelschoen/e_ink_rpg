import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';


class IronGloves extends GameItem with Wearable {
  IronGloves() {
    name = 'Iron Gloves';
    description = 'Provides some basic protection.';
    wearableType = WearableType.arms;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.gauntlet;
  }
}

class SturdyLeatherGloves extends GameItem with Wearable {
  SturdyLeatherGloves() {
    name = 'Sturdy Leather Gloves';
    description = 'Provide good protection.';
    wearableType = WearableType.arms;
    price = 28;
    statBoostsOnEquip.add(Stat(StatType.defense, 9));
    itemAsset = GameItemAsset.glove;
  }
}

class OldLeatherGloves extends GameItem with Wearable {
  OldLeatherGloves() {
    name = 'Old Leather Gloves';
    description = 'Provides a little protection.';
    wearableType = WearableType.arms;
    price = 16;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.gloveOld;
  }
}

class NobleGloves extends GameItem with Wearable {
  NobleGloves() {
    name = 'Noble Gloves';
    description = 'Provides medium protection.';
    wearableType = WearableType.arms;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.glove2;
  }
}

class ClericGloves extends GameItem with Wearable {
  ClericGloves() {
    name = 'Cleric Gloves';
    description = 'Special gloves, provide medium protection.';
    wearableType = WearableType.arms;
    price = 125;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.glove2old;
  }
}

class KnightsGloves extends GameItem with Wearable {
  KnightsGloves() {
    name = 'Knights Gloves';
    description = 'Provide strong protection.';
    wearableType = WearableType.arms;
    price = 100;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
    itemAsset = GameItemAsset.glove3;
  }
}

class FightingGloves extends GameItem with Wearable {
  FightingGloves() {
    name = 'Fighting Gloves';
    description = 'Provide mediocre protection.';
    wearableType = WearableType.arms;
    price = 18;
    statBoostsOnEquip.add(Stat(StatType.defense, 8));
    itemAsset = GameItemAsset.glove3old;
  }
}

class NobleGauntlets extends GameItem with Wearable {
  NobleGauntlets() {
    name = 'Noble Gauntlets';
    description = 'Provide superior protection.';
    wearableType = WearableType.arms;
    price = 220;
    statBoostsOnEquip.add(Stat(StatType.defense, 48));
    itemAsset = GameItemAsset.glove4Gauntlets;
  }
}

class SilverGloves extends GameItem with Wearable {
  SilverGloves() {
    name = 'Silver Gloves';
    description = 'Provide medium protection.';
    wearableType = WearableType.arms;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 12));
    itemAsset = GameItemAsset.glove4;
  }
}

class WornGloves extends GameItem with Wearable {
  WornGloves() {
    name = 'Worn Gloves';
    description = 'Provide weak protection.';
    wearableType = WearableType.arms;
    price = 8;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.glove4old;
  }
}

class DragonScaleGloves extends GameItem with Wearable {
  DragonScaleGloves() {
    name = 'Dragon Scale Gloves';
    description = 'Provide maximum protection.';
    wearableType = WearableType.arms;
    price = 450;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
    itemAsset = GameItemAsset.glove5;
  }
}
