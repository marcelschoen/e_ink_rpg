import 'package:e_ink_rpg/models/stat.dart';

import '../../models/item.dart';

class IronHelmet extends GameItem with Wearable {
  IronBreastPlate() {
    this.name = 'Iron Helmet';
    this.description = 'Provides some basic protection.';
    this.wearableType = WearableType.head;
    this.price = 30;
    this.statBoostsOnEquip.add(Stat(StatType.defense, 5));
  }
}

class IronBreastPlate extends GameItem with Wearable {
  IronBreastPlate() {
    this.name = 'Iron Breastplate';
    this.description = 'Provides some basic protection.';
    this.wearableType = WearableType.torso;
    this.price = 80;
    this.statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class IronGloves extends GameItem with Wearable {
  IronBreastPlate() {
    this.name = 'Iron Gloves';
    this.description = 'Provides some basic protection.';
    this.wearableType = WearableType.hands;
    this.price = 20;
    this.statBoostsOnEquip.add(Stat(StatType.defense, 6));
  }
}