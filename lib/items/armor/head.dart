import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';


class LeatherCap extends GameItem with Wearable {
  LeatherCap() : super() {
    name = 'Leather Cap';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 9));
    itemAsset = GameItemAsset.cap;
  }
}

class OldLeatherCap extends GameItem with Wearable {
  OldLeatherCap() : super() {
    name = 'Old Leather Cap';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 10;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
    itemAsset = GameItemAsset.cap2;
  }
}

class WizardCap extends GameItem with Wearable {
  WizardCap() : super() {
    name = 'Fancy Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 12));
    itemAsset = GameItemAsset.wizardCap;
  }
}

class WizardHat extends GameItem with Wearable {
  WizardHat() : super() {
    name = 'Plain Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.wizardHat;
  }
}

class WizardHat2 extends GameItem with Wearable {
  WizardHat2() : super() {
    name = 'Ancient Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 11));
    itemAsset = GameItemAsset.wizardHat2;
  }
}

class WizardHat3 extends GameItem with Wearable {
  WizardHat3() : super() {
    name = 'Icy Wizard Hat';
    description = 'A cold, icy magical hat.';
    wearableType = WearableType.head;
    price = 155;
    statBoostsOnEquip.add(Stat(StatType.defense, 16));
    itemAsset = GameItemAsset.hat;
  }
}

class WizardHat4 extends GameItem with Wearable {
  WizardHat4() : super() {
    name = 'Wizard Hat';
    description = 'A magical hat.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
    itemAsset = GameItemAsset.hat2;
  }
}

class WizardHat5 extends GameItem with Wearable {
  WizardHat5() : super() {
    name = 'Sparkly Wizard Hat';
    description = 'My god, it is full of stars!';
    wearableType = WearableType.head;
    price = 265;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
    itemAsset = GameItemAsset.hat3;
  }
}

class CrestedHelmet extends GameItem with Wearable {
  CrestedHelmet() : super() {
    name = 'Crested Helmet';
    description = 'Magical helmet.';
    wearableType = WearableType.head;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.crestedHelmet;
  }
}

class ElvenLeatherHat extends GameItem with Wearable {
  ElvenLeatherHat() : super() {
    name = 'Elvent Leather Hat';
    description = 'Looking good...';
    wearableType = WearableType.head;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 14));
    itemAsset = GameItemAsset.elvenLeatherHat;
  }
}

class GreenMask extends GameItem with Wearable {
  GreenMask() : super() {
    name = 'Mysterious Mask';
    description = 'A powerful relic.';
    wearableType = WearableType.head;
    price = 135;
    statBoostsOnEquip.add(Stat(StatType.defense, 25));
    itemAsset = GameItemAsset.greenMask;
  }
}

class LeatherHelmet extends GameItem with Wearable {
  LeatherHelmet() : super() {
    name = 'Leather Helmet';
    description = 'Provides a little protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.cap;
  }
}

class IronHelmet extends GameItem with Wearable {
  IronHelmet() : super() {
    name = 'Iron Helmet';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
    itemAsset = GameItemAsset.helmet;
  }
}

class VisoredHelmet extends GameItem with Wearable {
  VisoredHelmet() : super() {
    name = 'Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
    itemAsset = GameItemAsset.helmetVisored;
  }
}

class WingedHelmet extends GameItem with Wearable {
  WingedHelmet() : super() {
  name = 'Winged Helmet';
  description = 'Provides solid protection.';
  wearableType = WearableType.head;
  price = 55;
  statBoostsOnEquip.add(Stat(StatType.defense, 38));
  itemAsset = GameItemAsset.helmet2;
  }
}

class EtchedHelmet extends GameItem with Wearable {
  EtchedHelmet() : super() {
    name = 'Etched Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 44));
    itemAsset = GameItemAsset.helmetEtched;
  }
}

class SpikyHelmet extends GameItem with Wearable {
  SpikyHelmet() : super() {
    name = 'Spiky Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 44));
    itemAsset = GameItemAsset.helmet3;
  }
}

class NobleHelmet extends GameItem with Wearable {
  NobleHelmet() : super() {
    name = 'Noble Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
    itemAsset = GameItemAsset.helmet3old;
  }
}

class HornedHelmet extends GameItem with Wearable {
  HornedHelmet() : super() {
    name = 'Hornet Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 55));
    itemAsset = GameItemAsset.helmet4;
  }
}

class VisoredHelmet2 extends GameItem with Wearable {
  VisoredHelmet2() : super() {
    name = 'Old Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 25));
    itemAsset = GameItemAsset.helmet4visor;
  }
}

class VisoredHelmet3 extends GameItem with Wearable {
  VisoredHelmet3() : super() {
    name = 'Steel Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 68;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
    itemAsset = GameItemAsset.helmet5;
  }
}

class ArtHelmet extends GameItem with Wearable {
  ArtHelmet() : super() {
    name = 'Art Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 150;
    statBoostsOnEquip.add(Stat(StatType.defense, 20));
    itemAsset = GameItemAsset.helmetArt;
  }
}

class ArtHelmet2 extends GameItem with Wearable {
  ArtHelmet2() : super() {
    name = 'Silver Art Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 170;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.helmetArt2;
  }
}

class ArtHelmet3 extends GameItem with Wearable {
  ArtHelmet3() : super() {
    name = 'Centurion Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 120;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
    itemAsset = GameItemAsset.helmetArt3;
  }
}

class EgoHelmet extends GameItem with Wearable {
  EgoHelmet() : super() {
    name = 'Goldwing Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 180;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
    itemAsset = GameItemAsset.helmetEgo;
  }
}

class EgoHelmet2 extends GameItem with Wearable {
  EgoHelmet2() : super() {
    name = 'Gold Visored Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 160;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
    itemAsset = GameItemAsset.helmetEgo2;
  }
}

class EgoHelmet3 extends GameItem with Wearable {
  EgoHelmet3() : super() {
    name = 'Ceremonial Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 250;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
    itemAsset = GameItemAsset.helmetEgo3;
  }
}

class EgoHelmet4 extends GameItem with Wearable {
  EgoHelmet4() : super() {
    name = 'Southern Helmet';
    description = 'Provides basic protection.';
    wearableType = WearableType.head;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
    itemAsset = GameItemAsset.helmetEgo4;
  }
}

class PlumedHelmet extends GameItem with Wearable {
  PlumedHelmet() : super() {
    name = 'Plumed Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 55));
    itemAsset = GameItemAsset.plumedHelmet;
  }
}
