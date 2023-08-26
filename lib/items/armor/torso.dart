import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';

class BandedMailBreastPlate extends Armor {
  BandedMailBreastPlate() : super(GameItemAsset.bandedMailBreastPlate) {
    name = 'Old Banded Mail Breastplate';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 12;
    statBoostsOnEquip.add(Stat(StatType.defense, 20));
  }
}

class BandedMail2BreastPlate extends Armor {
  BandedMail2BreastPlate() : super(GameItemAsset.bandedMail2BreastPlate) {
    name = 'Banded Mail Breastplate';
    description = 'Provides a little protection.';
    wearableType = WearableType.torso;
    price = 18;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
  }
}

class OldChainMail extends Armor {
  OldChainMail() : super(GameItemAsset.chainMailBreastPlate) {
    name = 'Old Chain Mail';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 22));
  }
}

class NobleChainMail extends Armor {
  NobleChainMail() : super(GameItemAsset.chainMail2BreastPlate) {
    name = 'Noble Chain Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
  }
}

class ChainMail extends Armor {
  ChainMail() : super(GameItemAsset.chainMail3BreastPlate) {
    name = 'Chain Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
  }
}

class IronBreastPlate extends Armor {
  IronBreastPlate() : super(GameItemAsset.chainMailBreastPlate) {
    name = 'Iron Breastplate';
    description = 'Provides some basic protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
  }
}

class LeatherBreastPlate extends Armor {
  LeatherBreastPlate() : super(GameItemAsset.leather2ArmorBreastPlate) {
    name = 'Leather Breastplate';
    description = 'Provides a little protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class CrystalBreastPlate extends Armor {
  CrystalBreastPlate() : super(GameItemAsset.crystalBreastPlate) {
    name = 'Crystal Breastplate';
    description = 'Provides special protection.';
    wearableType = WearableType.torso;
    price = 120;
    statBoostsOnEquip.add(Stat(StatType.defense, 46));
  }
}

class DwarvenRingMail extends Armor {
  DwarvenRingMail() : super(GameItemAsset.dwarvenRingmailBreastPlate) {
    name = 'Dwarven Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 60;
    statBoostsOnEquip.add(Stat(StatType.defense, 52));
  }
}

class ElvenLeatherBreastPlate extends Armor {
  ElvenLeatherBreastPlate() : super(GameItemAsset.elvenLeatherBreastPlate) {
    name = 'Elven Leather Breastplate';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 48));
  }
}

class ElvenRingMail extends Armor {
  ElvenRingMail() : super(GameItemAsset.elvenRingmailBreastPlate) {
    name = 'Elven Ring Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 90;
    statBoostsOnEquip.add(Stat(StatType.defense, 62));
  }
}

class ElvenScaleMail extends Armor {
  ElvenScaleMail() : super(GameItemAsset.elvenScalemailBreastPlate) {
    name = 'Elven Scale Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
  }
}

class IceDragonBreastPlate extends Armor {
  IceDragonBreastPlate() : super(GameItemAsset.iceDragonNewBreastPlate) {
    name = 'Ice Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 350;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
  }
}

class OldIceDragonBreastPlate extends Armor {
  OldIceDragonBreastPlate() : super(GameItemAsset.iceDragonOldBreastPlate) {
    name = 'Old Ice Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 300;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
  }
}

class LeatherArmor extends Armor {
  LeatherArmor() : super(GameItemAsset.leatherArmorBreastPlate) {
    name = 'Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class SturdyLeatherArmor extends Armor {
  SturdyLeatherArmor() : super(GameItemAsset.leather2ArmorBreastPlate) {
    name = 'Sturdy Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 24));
  }
}

class NobleLeatherArmor extends Armor {
  NobleLeatherArmor() : super(GameItemAsset.leather3ArmorBreastPlate) {
    name = 'Noble Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 130;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
  }
}

class OrcishChainMail extends Armor {
  OrcishChainMail() : super(GameItemAsset.orcishChainmailBreastPlate) {
    name = 'Orcish Chain Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
  }
}

class OrcishLeatherArmor extends Armor {
  OrcishLeatherArmor() : super(GameItemAsset.orcishLeatherBreastPlate) {
    name = 'Orcish Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
  }
}

class OrcishSpikyMail extends Armor {
  OrcishSpikyMail() : super(GameItemAsset.orcishPlate2BreastPlate) {
    name = 'Orcish Spiky Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 58));
  }
}

class OrcishPlateMail extends Armor {
  OrcishPlateMail() : super(GameItemAsset.orcishPlateMailBreastPlate) {
    name = 'Orcish Plate Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 68));
  }
}

class OrcishRingMail extends Armor {
  OrcishRingMail() : super(GameItemAsset.orcishRingmailBreastPlate) {
    name = 'Orcish Ring Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
  }
}

class PearlDragonBreastPlate extends Armor {
  PearlDragonBreastPlate() : super(GameItemAsset.pearlDragonBreastPlate) {
    name = 'Pearl Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 230;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
  }
}

class PearlDragonHide extends Armor {
  PearlDragonHide() : super(GameItemAsset.pearlDragonHide) {
    name = 'Pearl Dragon Hide';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 160;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
  }
}

class IronArmor extends Armor {
  IronArmor() : super(GameItemAsset.plateBreastPlate) {
    name = 'Iron Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
  }
}

class SteelArmor extends Armor {
  SteelArmor() : super(GameItemAsset.plateMailBreastPlate) {
    name = 'Steel Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 90;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
  }
}

class NobleArmor extends Armor {
  NobleArmor() : super(GameItemAsset.plateMail2BreastPlate) {
    name = 'Noble Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
  }
}

class QuicksilverDragonScaleMail extends Armor {
  QuicksilverDragonScaleMail()
      : super(GameItemAsset.quicksilverDragonScaleMailBreastPlate) {
    name = 'Quicksilver Dragon Mail';
    description = 'Provides superior protection.';
    wearableType = WearableType.torso;
    price = 350;
    statBoostsOnEquip.add(Stat(StatType.defense, 180));
  }
}

class QuicksilverDragonScaleArmor extends Armor {
  QuicksilverDragonScaleArmor()
      : super(GameItemAsset.quicksilverDragonScalesBreastPlate) {
    name = 'Quicksilver Dragon Armor';
    description = 'Provides superior protection.';
    wearableType = WearableType.torso;
    price = 320;
    statBoostsOnEquip.add(Stat(StatType.defense, 160));
  }
}

class RingmailBreastplate extends Armor {
  RingmailBreastplate() : super(GameItemAsset.ringMailBreastPlate) {
    name = 'Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 44;
    statBoostsOnEquip.add(Stat(StatType.defense, 34));
  }
}

class OldRingmailBreastplate extends Armor {
  OldRingmailBreastplate() : super(GameItemAsset.ringMailOldBreastPlate) {
    name = 'Old Ring Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 34;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
  }
}

class NobleRingmail extends Armor {
  NobleRingmail() : super(GameItemAsset.ringMail2BreastPlate) {
    name = 'Noble Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 74;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
  }
}

class OldNobleRingmail extends Armor {
  OldNobleRingmail() : super(GameItemAsset.ringMailOld2BreastPlate) {
    name = 'Old Noble Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
  }
}

class MagicRingmail extends Armor {
  MagicRingmail() : super(GameItemAsset.ringMail3BreastPlate) {
    name = 'Magic Ring Mail';
    description = 'Protection for wizards.';
    wearableType = WearableType.torso;
    price = 355;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
  }
}

class OldRobe extends Armor {
  OldRobe() : super(GameItemAsset.robe2BreastPlate) {
    name = 'Old Robe';
    description = 'Ugly and worn.';
    wearableType = WearableType.torso;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
  }
}

class SimpleRobe extends Armor {
  SimpleRobe() : super(GameItemAsset.robeBreastPlate) {
    name = 'Simple Robe';
    description = 'Comfy but weak.';
    wearableType = WearableType.torso;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
  }
}

class SatinRobe extends Armor {
  SatinRobe() : super(GameItemAsset.robeOldBreastPlate) {
    name = 'Satin Robe';
    description = 'Comfy but weak.';
    wearableType = WearableType.torso;
    price = 25;
    statBoostsOnEquip.add(Stat(StatType.defense, 8));
  }
}

class MagicRobe extends Armor {
  MagicRobe() : super(GameItemAsset.robe2OldBreastPlate) {
    name = 'Magic Robe';
    description = 'A magical robe.';
    wearableType = WearableType.torso;
    price = 95;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
  }
}

class WizardRobe extends Armor {
  WizardRobe() : super(GameItemAsset.robe3BreastPlate) {
    name = 'Wizard Robe';
    description = 'A wizards robe.';
    wearableType = WearableType.torso;
    price = 195;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
  }
}

class ArtRobe extends Armor {
  ArtRobe() : super(GameItemAsset.robeArtBreastPlate) {
    name = 'Fancy Magic Robe';
    description = 'A fancy magical robe.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
  }
}

class ArtRobe2 extends Armor {
  ArtRobe2() : super(GameItemAsset.robeArt2BreastPlate) {
    name = 'Strong Magic Robe';
    description = 'A strong magical robe.';
    wearableType = WearableType.torso;
    price = 190;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
  }
}

class ClericRobe extends Armor {
  ClericRobe() : super(GameItemAsset.robeEgoBreastPlate) {
    name = 'Cleric Robe';
    description = 'A clerics robe.';
    wearableType = WearableType.torso;
    price = 140;
    statBoostsOnEquip.add(Stat(StatType.defense, 70));
  }
}

class PriestRobe extends Armor {
  PriestRobe() : super(GameItemAsset.robeEgo2BreastPlate) {
    name = 'Priest Robe';
    description = 'A priests robe.';
    wearableType = WearableType.torso;
    price = 180;
    statBoostsOnEquip.add(Stat(StatType.defense, 86));
  }
}

class ScaleMail extends Armor {
  ScaleMail() : super(GameItemAsset.scaleMailBreastPlate) {
    name = 'Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 46));
  }
}

class OldScaleMail extends Armor {
  OldScaleMail() : super(GameItemAsset.scaleMailOldBreastPlate) {
    name = 'Old Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
  }
}

class NobleScaleMail extends Armor {
  NobleScaleMail() : super(GameItemAsset.scaleMail2BreastPlate) {
    name = 'Noble Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 68));
  }
}

class WornScaleMail extends Armor {
  WornScaleMail() : super(GameItemAsset.scaleMail2OldBreastPlate) {
    name = 'Worn Scale Mail';
    description = 'An old, but still valid armor.';
    wearableType = WearableType.torso;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
  }
}

class MagicScaleMail extends Armor {
  MagicScaleMail() : super(GameItemAsset.scaleMail3BreastPlate) {
    name = 'Magic Scale Mail';
    description = 'A magical armor.';
    wearableType = WearableType.torso;
    price = 190;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
  }
}

class SilverDragonScaleArmor extends Armor {
  SilverDragonScaleArmor() : super(GameItemAsset.silverDragonScaleBreastPlate) {
    name = 'Silver Dragon Scale Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 250;
    statBoostsOnEquip.add(Stat(StatType.defense, 110));
  }
}

class SplintMail extends Armor {
  SplintMail() : super(GameItemAsset.splintMailBreastPlate) {
    name = 'Splint Mail';
    description = 'An old armor.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
  }
}

class NobleSplintMail extends Armor {
  NobleSplintMail() : super(GameItemAsset.splintMail2BreastPlate) {
    name = 'Noble Splint Mail';
    description = 'A solid armor for nobles.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
  }
}

class SwampDragonArmor extends Armor {
  SwampDragonArmor() : super(GameItemAsset.swampDragonBreastPlate) {
    name = 'Swamp Dragon Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 300;
    statBoostsOnEquip.add(Stat(StatType.defense, 140));
  }
}

class OldSwampDragonArmor extends Armor {
  OldSwampDragonArmor() : super(GameItemAsset.swampDragonOldBreastPlate) {
    name = 'Old Swamp Dragon Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 200;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
  }
}

class TrollLeatherArmor extends Armor {
  TrollLeatherArmor() : super(GameItemAsset.trollLeatherBreastPlate) {
    name = 'Troll Leather Armor';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 38;
    statBoostsOnEquip.add(Stat(StatType.defense, 52));
  }
}
