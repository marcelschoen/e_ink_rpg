import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';


class IronGloves extends Armor {
  IronGloves() : super(GameItemAsset.gauntlet) {
    name = 'Iron Gloves';
    description = 'Provides some basic protection.';
    wearableType = WearableType.arms;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
  }
}

class SturdyLeatherGloves extends Armor {
  SturdyLeatherGloves() : super(GameItemAsset.glove) {
    name = 'Sturdy Leather Gloves';
    description = 'Provide good protection.';
    wearableType = WearableType.arms;
    price = 28;
    statBoostsOnEquip.add(Stat(StatType.defense, 9));
  }
}

class OldLeatherGloves extends Armor {
  OldLeatherGloves() : super(GameItemAsset.gloveOld) {
    name = 'Old Leather Gloves';
    description = 'Provides a little protection.';
    wearableType = WearableType.arms;
    price = 16;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
  }
}

class NobleGloves extends Armor {
  NobleGloves() : super(GameItemAsset.glove2) {
    name = 'Noble Gloves';
    description = 'Provides medium protection.';
    wearableType = WearableType.arms;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class ClericGloves extends Armor {
  ClericGloves() : super(GameItemAsset.glove2old) {
    name = 'Cleric Gloves';
    description = 'Special gloves, provide medium protection.';
    wearableType = WearableType.arms;
    price = 125;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class KnightsGloves extends Armor {
  KnightsGloves() : super(GameItemAsset.glove3) {
    name = 'Knights Gloves';
    description = 'Provide strong protection.';
    wearableType = WearableType.arms;
    price = 100;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
  }
}

class FightingGloves extends Armor {
  FightingGloves() : super(GameItemAsset.glove3old) {
    name = 'Fighting Gloves';
    description = 'Provide mediocre protection.';
    wearableType = WearableType.arms;
    price = 18;
    statBoostsOnEquip.add(Stat(StatType.defense, 8));
  }
}

class NobleGauntlets extends Armor {
  NobleGauntlets() : super(GameItemAsset.glove4Gauntlets) {
    name = 'Noble Gauntlets';
    description = 'Provide superior protection.';
    wearableType = WearableType.arms;
    price = 220;
    statBoostsOnEquip.add(Stat(StatType.defense, 48));
  }
}

class SilverGloves extends Armor {
  SilverGloves() : super(GameItemAsset.glove4) {
    name = 'Silver Gloves';
    description = 'Provide medium protection.';
    wearableType = WearableType.arms;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 12));
  }
}

class WornGloves extends Armor {
  WornGloves() : super(GameItemAsset.glove4old) {
    name = 'Worn Gloves';
    description = 'Provide weak protection.';
    wearableType = WearableType.arms;
    price = 8;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
  }
}

class DragonScaleGloves extends Armor {
  DragonScaleGloves() : super(GameItemAsset.glove5) {
    name = 'Dragon Scale Gloves';
    description = 'Provide maximum protection.';
    wearableType = WearableType.arms;
    price = 450;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
  }
}
