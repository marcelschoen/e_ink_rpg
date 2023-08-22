import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';



class StripeBoots extends GameItem with Wearable {
  StripeBoots() {
    name = 'Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.bootsStripe;
  }
}

class StripeBootsOld extends GameItem with Wearable {
  StripeBootsOld() {
    name = 'Old Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.bootsStripeOld;
  }
}

class LowBoots extends GameItem with Wearable {
  LowBoots() {
    name = 'Low Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 6;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.bootsLow;
  }
}

class Jackboots extends GameItem with Wearable {
  Jackboots() {
    name = 'Jackboots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 12;
    statBoostsOnEquip.add(Stat(StatType.defense, 7));
    itemAsset = GameItemAsset.bootsJackboots;
  }
}

class GreenBoots extends GameItem with Wearable {
  GreenBoots() {
    name = 'Green Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.bootsGreen;
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

class LeatherBootsOld extends GameItem with Wearable {
  LeatherBootsOld() {
    name = 'Old Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 5;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.bootsBrownOld;
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
