import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';
import '../../models/item.dart';


class BandedMailBreastPlate extends GameItem with Wearable {
  BandedMailBreastPlate() : super() {
    name = 'Old Banded Mail Breastplate';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 12;
    statBoostsOnEquip.add(Stat(StatType.defense, 20));
    itemAsset = GameItemAsset.bandedMailBreastPlate;
  }
}

class BandedMail2BreastPlate extends GameItem with Wearable {
  BandedMail2BreastPlate() : super() {
    name = 'Banded Mail Breastplate';
    description = 'Provides a little protection.';
    wearableType = WearableType.torso;
    price = 18;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
    itemAsset = GameItemAsset.bandedMail2BreastPlate;
  }
}

class OldChainMail extends GameItem with Wearable {
  OldChainMail() : super() {
    name = 'Old Chain Mail';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 22));
    itemAsset = GameItemAsset.chainMailBreastPlate;
  }
}

class NobleChainMail extends GameItem with Wearable {
  NobleChainMail() : super() {
    name = 'Noble Chain Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 85;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
    itemAsset = GameItemAsset.chainMail2BreastPlate;
  }
}

class ChainMail extends GameItem with Wearable {
  ChainMail() : super() {
    name = 'Chain Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 45;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
    itemAsset = GameItemAsset.chainMail3BreastPlate;
  }
}

class IronBreastPlate extends GameItem with Wearable {
  IronBreastPlate() : super() {
    name = 'Iron Breastplate';
    description = 'Provides some basic protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 15));
    itemAsset = GameItemAsset.chainMailBreastPlate;
  }
}

class LeatherBreastPlate extends GameItem with Wearable {
  LeatherBreastPlate() : super() {
    name = 'Leather Breastplate';
    description = 'Provides a little protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.leather2ArmorBreastPlate;
  }
}

class CrystalBreastPlate extends GameItem with Wearable {
  CrystalBreastPlate() : super() {
    name = 'Crystal Breastplate';
    description = 'Provides special protection.';
    wearableType = WearableType.torso;
    price = 120;
    statBoostsOnEquip.add(Stat(StatType.defense, 46));
    itemAsset = GameItemAsset.crystalBreastPlate;
  }
}

class DwarvenRingMail extends GameItem with Wearable {
  DwarvenRingMail() : super() {
    name = 'Dwarven Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 60;
    statBoostsOnEquip.add(Stat(StatType.defense, 52));
    itemAsset = GameItemAsset.dwarvenRingmailBreastPlate;
  }
}

class ElvenLeatherBreastPlate extends GameItem with Wearable {
  ElvenLeatherBreastPlate() : super() {
    name = 'Elven Leather Breastplate';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 48));
    itemAsset = GameItemAsset.elvenLeatherBreastPlate;
  }
}

class ElvenRingMail extends GameItem with Wearable {
  ElvenRingMail() : super() {
    name = 'Elven Ring Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 90;
    statBoostsOnEquip.add(Stat(StatType.defense, 62));
    itemAsset = GameItemAsset.elvenRingmailBreastPlate;
  }
}

class ElvenScaleMail extends GameItem with Wearable {
  ElvenScaleMail() : super() {
    name = 'Elven Scale Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
    itemAsset = GameItemAsset.elvenScalemailBreastPlate;
  }
}

class IceDragonBreastPlate extends GameItem with Wearable {
  IceDragonBreastPlate() : super() {
    name = 'Ice Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 350;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
    itemAsset = GameItemAsset.iceDragonNewBreastPlate;
  }
}

class OldIceDragonBreastPlate extends GameItem with Wearable {
  OldIceDragonBreastPlate() : super() {
    name = 'Old Ice Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 300;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
    itemAsset = GameItemAsset.iceDragonOldBreastPlate;
  }
}

class LeatherArmor extends GameItem with Wearable {
  LeatherArmor() : super() {
    name = 'Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 30;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.leatherArmorBreastPlate;
  }
}

class SturdyLeatherArmor extends GameItem with Wearable {
  SturdyLeatherArmor() : super() {
    name = 'Sturdy Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 24));
    itemAsset = GameItemAsset.leather2ArmorBreastPlate;
  }
}

class NobleLeatherArmor extends GameItem with Wearable {
  NobleLeatherArmor() : super() {
    name = 'Noble Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 130;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
    itemAsset = GameItemAsset.leather3ArmorBreastPlate;
  }
}

class OrcishChainMail extends GameItem with Wearable {
  OrcishChainMail() : super() {
    name = 'Orcish Chain Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 40;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
    itemAsset = GameItemAsset.orcishChainmailBreastPlate;
  }
}

class OrcishLeatherArmor extends GameItem with Wearable {
  OrcishLeatherArmor() : super() {
    name = 'Orcish Leather Armor';
    description = 'Provides mediocre protection.';
    wearableType = WearableType.torso;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 18));
    itemAsset = GameItemAsset.orcishLeatherBreastPlate;
  }
}

class OrcishSpikyMail extends GameItem with Wearable {
  OrcishSpikyMail() : super() {
    name = 'Orcish Spiky Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 65;
    statBoostsOnEquip.add(Stat(StatType.defense, 58));
    itemAsset = GameItemAsset.orcishPlate2BreastPlate;
  }
}

class OrcishPlateMail extends GameItem with Wearable {
  OrcishPlateMail() : super() {
    name = 'Orcish Plate Mail';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 68));
    itemAsset = GameItemAsset.orcishPlateMailBreastPlate;
  }
}

class OrcishRingMail extends GameItem with Wearable {
  OrcishRingMail() : super() {
    name = 'Orcish Ring Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
    itemAsset = GameItemAsset.orcishRingmailBreastPlate;
  }
}

class PearlDragonBreastPlate extends GameItem with Wearable {
  PearlDragonBreastPlate() : super() {
    name = 'Pearl Dragon Breastplate';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 230;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
    itemAsset = GameItemAsset.pearlDragonBreastPlate;
  }
}

class PearlDragonHide extends GameItem with Wearable {
  PearlDragonHide() : super() {
    name = 'Pearl Dragon Hide';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 160;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
    itemAsset = GameItemAsset.pearlDragonHide;
  }
}

class IronArmor extends GameItem with Wearable {
  IronArmor() : super() {
    name = 'Iron Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 80;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
    itemAsset = GameItemAsset.plateBreastPlate;
  }
}

class SteelArmor extends GameItem with Wearable {
  SteelArmor() : super() {
    name = 'Steel Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 90;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
    itemAsset = GameItemAsset.plateMailBreastPlate;
  }
}

class NobleArmor extends GameItem with Wearable {
  NobleArmor() : super() {
    name = 'Noble Armor';
    description = 'Provides strong protection.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 50));
    itemAsset = GameItemAsset.plateMail2BreastPlate;
  }
}

class QuicksilverDragonScaleMail extends GameItem with Wearable {
  QuicksilverDragonScaleMail() : super() {
    name = 'Quicksilver Dragon Mail';
    description = 'Provides superior protection.';
    wearableType = WearableType.torso;
    price = 350;
    statBoostsOnEquip.add(Stat(StatType.defense, 180));
    itemAsset = GameItemAsset.quicksilverDragonScaleMailBreastPlate;
  }
}

class QuicksilverDragonScaleArmor extends GameItem with Wearable {
  QuicksilverDragonScaleArmor() : super() {
    name = 'Quicksilver Dragon Armor';
    description = 'Provides superior protection.';
    wearableType = WearableType.torso;
    price = 320;
    statBoostsOnEquip.add(Stat(StatType.defense, 160));
    itemAsset = GameItemAsset.quicksilverDragonScalesBreastPlate;
  }
}

class RingmailBreastplate extends GameItem with Wearable {
  RingmailBreastplate() : super() {
    name = 'Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 44;
    statBoostsOnEquip.add(Stat(StatType.defense, 34));
    itemAsset = GameItemAsset.ringMailBreastPlate;
  }
}

class OldRingmailBreastplate extends GameItem with Wearable {
  OldRingmailBreastplate() : super() {
    name = 'Old Ring Mail';
    description = 'Provides good protection.';
    wearableType = WearableType.torso;
    price = 34;
    statBoostsOnEquip.add(Stat(StatType.defense, 28));
    itemAsset = GameItemAsset.ringMailOldBreastPlate;
  }
}

class NobleRingmail extends GameItem with Wearable {
  NobleRingmail() : super() {
    name = 'Noble Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 74;
    statBoostsOnEquip.add(Stat(StatType.defense, 38));
    itemAsset = GameItemAsset.ringMail2BreastPlate;
  }
}

class OldNobleRingmail extends GameItem with Wearable {
  OldNobleRingmail() : super() {
    name = 'Old Noble Ring Mail';
    description = 'Provides solid protection.';
    wearableType = WearableType.torso;
    price = 55;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
    itemAsset = GameItemAsset.ringMailOld2BreastPlate;
  }
}

class MagicRingmail extends GameItem with Wearable {
  MagicRingmail() : super() {
    name = 'Magic Ring Mail';
    description = 'Protection for wizards.';
    wearableType = WearableType.torso;
    price = 355;
    statBoostsOnEquip.add(Stat(StatType.defense, 80));
    itemAsset = GameItemAsset.ringMail3BreastPlate;
  }
}

class OldRobe extends GameItem with Wearable {
  OldRobe() : super() {
    name = 'Old Robe';
    description = 'Ugly and worn.';
    wearableType = WearableType.torso;
    price = 15;
    statBoostsOnEquip.add(Stat(StatType.defense, 4));
    itemAsset = GameItemAsset.robe2BreastPlate;
  }
}

class SimpleRobe extends GameItem with Wearable {
  SimpleRobe() : super() {
    name = 'Simple Robe';
    description = 'Comfy but weak.';
    wearableType = WearableType.torso;
    price = 20;
    statBoostsOnEquip.add(Stat(StatType.defense, 10));
    itemAsset = GameItemAsset.robeBreastPlate;
  }
}

class SatinRobe extends GameItem with Wearable {
  SatinRobe() : super() {
    name = 'Satin Robe';
    description = 'Comfy but weak.';
    wearableType = WearableType.torso;
    price = 25;
    statBoostsOnEquip.add(Stat(StatType.defense, 8));
    itemAsset = GameItemAsset.robeOldBreastPlate;
  }
}

class MagicRobe extends GameItem with Wearable {
  MagicRobe() : super() {
    name = 'Magic Robe';
    description = 'A magical robe.';
    wearableType = WearableType.torso;
    price = 95;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
    itemAsset = GameItemAsset.robe2OldBreastPlate;
  }
}

class WizardRobe extends GameItem with Wearable {
  WizardRobe() : super() {
    name = 'Wizard Robe';
    description = 'A wizards robe.';
    wearableType = WearableType.torso;
    price = 195;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
    itemAsset = GameItemAsset.robe3BreastPlate;
  }
}

class ArtRobe extends GameItem with Wearable {
  ArtRobe() : super() {
    name = 'Fancy Magic Robe';
    description = 'A fancy magical robe.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 60));
    itemAsset = GameItemAsset.robeArtBreastPlate;
  }
}

class ArtRobe2 extends GameItem with Wearable {
  ArtRobe2() : super() {
    name = 'Strong Magic Robe';
    description = 'A strong magical robe.';
    wearableType = WearableType.torso;
    price = 190;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
    itemAsset = GameItemAsset.robeArt2BreastPlate;
  }
}

class ClericRobe extends GameItem with Wearable {
  ClericRobe() : super() {
    name = 'Cleric Robe';
    description = 'A clerics robe.';
    wearableType = WearableType.torso;
    price = 140;
    statBoostsOnEquip.add(Stat(StatType.defense, 70));
    itemAsset = GameItemAsset.robeEgoBreastPlate;
  }
}

class PriestRobe extends GameItem with Wearable {
  PriestRobe() : super() {
    name = 'Priest Robe';
    description = 'A priests robe.';
    wearableType = WearableType.torso;
    price = 180;
    statBoostsOnEquip.add(Stat(StatType.defense, 86));
    itemAsset = GameItemAsset.robeEgo2BreastPlate;
  }
}

class ScaleMail extends GameItem with Wearable {
  ScaleMail() : super() {
    name = 'Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 46));
    itemAsset = GameItemAsset.scaleMailBreastPlate;
  }
}

class OldScaleMail extends GameItem with Wearable {
  OldScaleMail() : super() {
    name = 'Old Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
    itemAsset = GameItemAsset.scaleMailOldBreastPlate;
  }
}

class NobleScaleMail extends GameItem with Wearable {
  NobleScaleMail() : super() {
    name = 'Noble Scale Mail';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 110;
    statBoostsOnEquip.add(Stat(StatType.defense, 68));
    itemAsset = GameItemAsset.scaleMail2BreastPlate;
  }
}

class WornScaleMail extends GameItem with Wearable {
  WornScaleMail() : super() {
    name = 'Worn Scale Mail';
    description = 'An old, but still valid armor.';
    wearableType = WearableType.torso;
    price = 35;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
    itemAsset = GameItemAsset.scaleMail2OldBreastPlate;
  }
}

class MagicScaleMail extends GameItem with Wearable {
  MagicScaleMail() : super() {
    name = 'Magic Scale Mail';
    description = 'A magical armor.';
    wearableType = WearableType.torso;
    price = 190;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
    itemAsset = GameItemAsset.scaleMail3BreastPlate;
  }
}

class SilverDragonScaleArmor extends GameItem with Wearable {
  SilverDragonScaleArmor() : super() {
    name = 'Silver Dragon Scale Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 250;
    statBoostsOnEquip.add(Stat(StatType.defense, 110));
    itemAsset = GameItemAsset.silverDragonScaleBreastPlate;
  }
}

class SplintMail extends GameItem with Wearable {
  SplintMail() : super() {
    name = 'Splint Mail';
    description = 'An old armor.';
    wearableType = WearableType.torso;
    price = 50;
    statBoostsOnEquip.add(Stat(StatType.defense, 30));
    itemAsset = GameItemAsset.splintMailBreastPlate;
  }
}

class NobleSplintMail extends GameItem with Wearable {
  NobleSplintMail() : super() {
    name = 'Noble Splint Mail';
    description = 'A solid armor for nobles.';
    wearableType = WearableType.torso;
    price = 70;
    statBoostsOnEquip.add(Stat(StatType.defense, 40));
    itemAsset = GameItemAsset.splintMail2BreastPlate;
  }
}

class SwampDragonArmor extends GameItem with Wearable {
  SwampDragonArmor() : super() {
    name = 'Swamp Dragon Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 300;
    statBoostsOnEquip.add(Stat(StatType.defense, 140));
    itemAsset = GameItemAsset.swampDragonBreastPlate;
  }
}

class OldSwampDragonArmor extends GameItem with Wearable {
  OldSwampDragonArmor() : super() {
    name = 'Old Swamp Dragon Armor';
    description = 'A powerful dragon armor.';
    wearableType = WearableType.torso;
    price = 200;
    statBoostsOnEquip.add(Stat(StatType.defense, 90));
    itemAsset = GameItemAsset.swampDragonOldBreastPlate;
  }
}

class TrollLeatherArmor extends GameItem with Wearable {
  TrollLeatherArmor() : super() {
    name = 'Troll Leather Armor';
    description = 'A solid armor.';
    wearableType = WearableType.torso;
    price = 38;
    statBoostsOnEquip.add(Stat(StatType.defense, 52));
    itemAsset = GameItemAsset.trollLeatherBreastPlate;
  }
}
