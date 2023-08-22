import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';



class StripeBoots extends GameItem with Wearable {
  StripeBoots() : super() {
    name = 'Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.bootsStripe;
  }
}

class StripeBootsOld extends GameItem with Wearable {
  StripeBootsOld() : super() {
    name = 'Old Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.bootsStripeOld;
  }
}

class LowBoots extends GameItem with Wearable {
  LowBoots() : super() {
    name = 'Low Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 6;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.bootsLow;
  }
}

class Jackboots extends GameItem with Wearable {
  Jackboots() : super() {
    name = 'Jackboots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 12;
    statBoostsOnEquip.add(Stat(StatType.defense, 7));
    itemAsset = GameItemAsset.bootsJackboots;
  }
}

class GreenBoots extends GameItem with Wearable {
  GreenBoots() : super() {
    name = 'Green Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.bootsGreen;
  }
}

class IronBoots extends GameItem with Wearable {
  IronBoots() : super() {
    name = 'Iron Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.bootsIron;
  }
}

class LeatherBootsOld extends GameItem with Wearable {
  LeatherBootsOld() : super() {
    name = 'Old Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 5;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.bootsBrownOld;
  }
}

class LeatherBoots extends GameItem with Wearable {
  LeatherBoots() : super() {
    name = 'Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.bootsBrown;
  }
}
