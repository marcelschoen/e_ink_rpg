import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';



class StripeBoots extends Armor {
  StripeBoots() : super(GameItemAsset.bootsStripe) {
    name = 'Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class StripeBootsOld extends Armor {
  StripeBootsOld() : super(GameItemAsset.bootsStripeOld) {
    name = 'Old Stripe Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class LowBoots extends Armor {
  LowBoots() : super(GameItemAsset.bootsLow) {
    name = 'Low Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 6;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
  }
}

class Jackboots extends Armor {
  Jackboots() : super(GameItemAsset.bootsJackboots) {
    name = 'Jackboots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 12;
    statBoostsOnEquip.add(Stat(StatType.defense, 7));
  }
}

class GreenBoots extends Armor {
  GreenBoots() : super(GameItemAsset.bootsGreen) {
    name = 'Green Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
  }
}

class IronBoots extends Armor {
  IronBoots() : super(GameItemAsset.bootsIron) {
    name = 'Iron Boots';
    description = 'Provides some basic protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
  }
}

class LeatherBootsOld extends Armor {
  LeatherBootsOld() : super(GameItemAsset.bootsBrownOld) {
    name = 'Old Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 5;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
  }
}

class LeatherBoots extends Armor {
  LeatherBoots() : super(GameItemAsset.bootsBrown) {
    name = 'Leather Boots';
    description = 'Provides a little protection.';
    wearableType = WearableType.legs;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
  }
}
