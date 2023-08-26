import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';


class LeatherCap extends Armor {
  LeatherCap() : super(GameItemAsset.cap) {
    name = 'Leather Cap';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 9));
  }
}

class OldLeatherCap extends Armor {
  OldLeatherCap() : super(GameItemAsset.cap2) {
    name = 'Old Leather Cap';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 10;
    statBoostsOnEquip.add(Stat(StatType.defense, 6));
  }
}

class WizardCap extends Armor {
  WizardCap() : super(GameItemAsset.wizardCap) {
    name = 'Fancy Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 12));
  }
}

class WizardHat extends Armor {
  WizardHat() : super(GameItemAsset.wizardHat) {
    name = 'Plain Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class WizardHat2 extends Armor {
  WizardHat2() : super(GameItemAsset.wizardHat2) {
    name = 'Ancient Wizard Hat';
    description = 'Magical hat.';
    wearableType = WearableType.head;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 11));
  }
}

class WizardHat3 extends Armor {
  WizardHat3() : super(GameItemAsset.hat) {
    name = 'Icy Wizard Hat';
    description = 'A cold, icy magical hat.';
    wearableType = WearableType.head;
    price = 155;
    statBoostsOnEquip.add(Stat(StatType.defense, 16));
  }
}

class WizardHat4 extends Armor {
  WizardHat4() : super(GameItemAsset.hat2) {
    name = 'Wizard Hat';
    description = 'A magical hat.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
  }
}

class WizardHat5 extends Armor {
  WizardHat5() : super(GameItemAsset.hat3) {
    name = 'Sparkly Wizard Hat';
    description = 'My god, it is full of stars!';
    wearableType = WearableType.head;
    price = 265;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
  }
}

class CrestedHelmet extends Armor {
  CrestedHelmet() : super(GameItemAsset.crestedHelmet) {
    name = 'Crested Helmet';
    description = 'Magical helmet.';
    wearableType = WearableType.head;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class ElvenLeatherHat extends Armor {
  ElvenLeatherHat() : super(GameItemAsset.elvenLeatherHat) {
    name = 'Elvent Leather Hat';
    description = 'Looking good...';
    wearableType = WearableType.head;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 14));
  }
}

class GreenMask extends Armor {
  GreenMask() : super(GameItemAsset.greenMask) {
    name = 'Mysterious Mask';
    description = 'A powerful relic.';
    wearableType = WearableType.head;
    price = 135;
    statBoostsOnEquip.add(Stat(StatType.defense, 25));
  }
}

class LeatherHelmet extends Armor {
  LeatherHelmet() : super(GameItemAsset.cap) {
    name = 'Leather Helmet';
    description = 'Provides a little protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
  }
}

class IronHelmet extends Armor {
  IronHelmet() : super(GameItemAsset.helmet) {
    name = 'Iron Helmet';
    description = 'Provides some basic protection.';
    wearableType = WearableType.head;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 5));
  }
}

class VisoredHelmet extends Armor {
  VisoredHelmet() : super(GameItemAsset.helmetVisored) {
    name = 'Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
  }
}

class WingedHelmet extends Armor {
  WingedHelmet() : super(GameItemAsset.helmet2) {
  name = 'Winged Helmet';
  description = 'Provides solid protection.';
  wearableType = WearableType.head;
  price = 55;
  statBoostsOnEquip.add(Stat(StatType.defense, 38));
  }
}

class EtchedHelmet extends Armor {
  EtchedHelmet() : super(GameItemAsset.helmetEtched) {
    name = 'Etched Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 44));
  }
}

class SpikyHelmet extends Armor {
  SpikyHelmet() : super(GameItemAsset.helmet3) {
    name = 'Spiky Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 44));
  }
}

class NobleHelmet extends Armor {
  NobleHelmet() : super(GameItemAsset.helmet3old) {
    name = 'Noble Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
  }
}

class HornedHelmet extends Armor {
  HornedHelmet() : super(GameItemAsset.helmet4) {
    name = 'Hornet Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 55));
  }
}

class VisoredHelmet2 extends Armor {
  VisoredHelmet2() : super(GameItemAsset.helmet4visor) {
    name = 'Old Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 25));
  }
}

class VisoredHelmet3 extends Armor {
  VisoredHelmet3() : super(GameItemAsset.helmet5) {
    name = 'Steel Visored Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 68;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
  }
}

class ArtHelmet extends Armor {
  ArtHelmet() : super(GameItemAsset.helmetArt) {
    name = 'Art Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 150;
    statBoostsOnEquip.add(Stat(StatType.defense, 20));
  }
}

class ArtHelmet2 extends Armor {
  ArtHelmet2() : super(GameItemAsset.helmetArt2) {
    name = 'Silver Art Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 170;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class ArtHelmet3 extends Armor {
  ArtHelmet3() : super(GameItemAsset.helmetArt3) {
    name = 'Centurion Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 120;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
  }
}

class EgoHelmet extends Armor {
  EgoHelmet() : super(GameItemAsset.helmetEgo) {
    name = 'Goldwing Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 180;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
  }
}

class EgoHelmet2 extends Armor {
  EgoHelmet2() : super(GameItemAsset.helmetEgo2) {
    name = 'Gold Visored Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 160;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
  }
}

class EgoHelmet3 extends Armor {
  EgoHelmet3() : super(GameItemAsset.helmetEgo3) {
    name = 'Ceremonial Helmet';
    description = 'A special helmet, provides meagre protection.';
    wearableType = WearableType.head;
    price = 250;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
  }
}

class EgoHelmet4 extends Armor {
  EgoHelmet4() : super(GameItemAsset.helmetEgo4) {
    name = 'Southern Helmet';
    description = 'Provides basic protection.';
    wearableType = WearableType.head;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 35));
  }
}

class PlumedHelmet extends Armor {
  PlumedHelmet() : super(GameItemAsset.plumedHelmet) {
    name = 'Plumed Helmet';
    description = 'Provides solid protection.';
    wearableType = WearableType.head;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 55));
  }
}
