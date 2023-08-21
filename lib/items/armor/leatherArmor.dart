import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';

class LeatherHelmet extends GameItem with Wearable {
  LeatherHelmet() {
    name = 'Leather Helmet';
    description = 'Provides a little protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.cap;
  }
}

class LeatherBreastPlate extends GameItem with Wearable {
  LeatherBreastPlate() {
    name = 'Leather Breastplate';
    description = 'Provides a little protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.leather2ArmorBreastPlate;
  }
}

class LeatherGloves extends GameItem with Wearable {
  LeatherGloves() {
    name = 'Leather Gloves';
    description = 'Provides a little protection.';
    wearableType = WearableType.arms;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.gloveOld;
  }
}

class LeatherBoots extends GameItem with Wearable {
  LeatherBoots() {
    name = 'Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.bootsBrown;
  }
}
