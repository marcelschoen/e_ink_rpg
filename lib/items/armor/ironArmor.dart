import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';

class IronHelmet extends GameItem with Wearable {
  IronHelmet() {
    name = 'Iron Helmet';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.helmet;
  }
}

class IronBreastPlate extends GameItem with Wearable {
  IronBreastPlate() {
    name = 'Iron Breastplate';
    description = 'Provides some basic protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.chainMailBreastPlate;
  }
}

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

class IronBoots extends GameItem with Wearable {
  IronBoots() {
    name = 'Iron Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.bootsIron;
  }
}
