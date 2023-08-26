import '../../assets.dart';
import '../../models/item.dart';

class BlessedBlade extends Sword {
  BlessedBlade() : super(GameItemAsset.blessedBlade) {
    description = 'A holy blade.';
    name = 'Blessed Blade';
    price = 50;
    attackPower = 8.0;
  }
}

class Claymore extends LargeSword {
  Claymore() : super(GameItemAsset.claymore) {
    description = 'A two-handed sword.';
    name = 'Claymore';
    price = 35;
    attackPower = 10.0;
  }
}

class NobleClaymore extends LargeSword {
  NobleClaymore() : super(GameItemAsset.claymore2) {
    description = 'A noble two-handed sword.';
    name = 'Noble Claymore';
    price = 75;
    attackPower = 12.0;
  }
}

class MagicClaymore extends LargeSword {
  MagicClaymore() : super(GameItemAsset.claymore3) {
    description = 'A magic two-handed sword.';
    name = 'Magic Claymore';
    price = 180;
    attackPower = 8.0;
  }
}

class BlessedClaymore extends LargeSword {
  BlessedClaymore() : super(GameItemAsset.claymoreBlessed) {
    description = 'A holy two-handed sword.';
    name = 'Blessed Claymore';
    price = 100;
    attackPower = 15.0;
  }
}

class Cutlass extends Sword {
  Cutlass() : super(GameItemAsset.cutlass) {
    description = 'A regular cutlass.';
    name = 'Regular Cutlass';
    price = 20;
    attackPower = 15.0;
  }
}

class CrystalCutlass extends Sword {
  CrystalCutlass() : super(GameItemAsset.cutlass3) {
    description = 'A crystal cutlass.';
    name = 'Crystal Cutlass';
    price = 50;
    attackPower = 18.0;
  }
}

class SteelCutlass extends Sword {
  SteelCutlass() : super(GameItemAsset.cutlass4) {
    description = 'A steel cutlass.';
    name = 'Steel Cutlass';
    price = 25;
    attackPower = 20.0;
  }
}

class HardenedCutlass extends Sword {
  HardenedCutlass() : super(GameItemAsset.cutlass5) {
    description = 'A hardened cutlass.';
    name = 'Hardened Cutlass';
    price = 45;
    attackPower = 16.0;
  }
}

class IronCutlass extends Sword {
  IronCutlass() : super(GameItemAsset.cutlass6) {
    description = 'An iron cutlass.';
    name = 'Iron Cutlass';
    price = 45;
    attackPower = 16.0;
  }
}

class GoldenCutlass extends Sword {
  GoldenCutlass() : super(GameItemAsset.cutlass7) {
    description = 'A golden cutlass.';
    name = 'Golden Cutlass';
    price = 120;
    attackPower = 10.0;
  }
}

class AncientCutlass extends Sword {
  AncientCutlass() : super(GameItemAsset.cutlass8) {
    description = 'An ancient cutlass.';
    name = 'Ancient Cutlass';
    price = 32;
    attackPower = 25.0;
  }
}

class OfficerCutlass extends Sword {
  OfficerCutlass() : super(GameItemAsset.cutlass9) {
    description = 'An officers cutlass.';
    name = 'Officers Cutlass';
    price = 85;
    attackPower = 20.0;
  }
}

class ValuableDagger extends Dagger {
  ValuableDagger() : super(GameItemAsset.dagger3) {
    description = 'A valuable dagger.';
    name = 'Valuable Dagger';
    price = 68;
    attackPower = 8.0;
  }
}

class IronDagger extends Dagger {
  IronDagger() : super(GameItemAsset.dagger6) {
    description = 'An iron dagger.';
    name = 'Iron Dagger';
    price = 14;
    attackPower = 10.0;
  }
}

class RustyDagger extends Dagger {
  RustyDagger() : super(GameItemAsset.dagger7) {
    description = 'A rusty dagger.';
    name = 'Rusty Dagger';
    price = 10;
    attackPower = 6.0;
  }
}

class NewDagger extends Dagger {
  NewDagger() : super(GameItemAsset.dagger) {
    description = 'A new dagger.';
    name = 'New Dagger';
    price = 15;
    attackPower = 8.0;
  }
}

class OldDagger extends Dagger {
  OldDagger() : super(GameItemAsset.daggerOld) {
    description = 'An old dagger.';
    name = 'Old Dagger';
    price = 7;
    attackPower = 8.0;
  }
}

class DemonBlade extends Sword {
  DemonBlade() : super(GameItemAsset.demonBlade) {
    description = 'A demonish blade. It radiates evil power!';
    name = 'Demon Blade';
    price = 166;
    attackPower = 35.0;
  }
}

class DoubleSword extends LargeSword {
  DoubleSword() : super(GameItemAsset.doubleSword) {
    description = 'A double sword.';
    name = 'Double Sword';
    price = 24;
    attackPower = 14.0;
  }
}

class DoubleSwordOld extends LargeSword {
  DoubleSwordOld() : super(GameItemAsset.doubleSwordOld) {
    description = 'An old double sword.';
    name = 'Old Double Sword';
    price = 13;
    attackPower = 13.0;
  }
}

class NobleDoubleSword extends LargeSword {
  NobleDoubleSword() : super(GameItemAsset.doubleSword2) {
    description = 'A noble double sword.';
    name = 'Noble Double Sword';
    price = 57;
    attackPower = 22.0;
  }
}

class HolyDoubleSword extends LargeSword {
  HolyDoubleSword() : super(GameItemAsset.doubleSword3) {
    description = 'A holy double sword.';
    name = 'Holy Double Sword';
    price = 190;
    attackPower = 34.0;
  }
}

class ElvenBroadSword extends LargeSword {
  ElvenBroadSword() : super(GameItemAsset.elvenBroadsword) {
    description = 'An elven broadsword.';
    name = 'Elven Broadsword';
    price = 28;
    attackPower = 22.0;
  }
}

class ElvenDagger extends Dagger {
  ElvenDagger() : super(GameItemAsset.elvenDagger) {
    description = 'An elven dagger.';
    name = 'Elven Dagger';
    price = 18;
    attackPower = 12.0;
  }
}

class ElvenShortSword extends Sword {
  ElvenShortSword() : super(GameItemAsset.elvenShortsword) {
    description = 'An elven shortsword.';
    name = 'Elven Shortsword';
    price = 34;
    attackPower = 18.0;
  }
}

class Falchion extends Sword {
  Falchion() : super(GameItemAsset.falchion) {
    description = 'A new falchion.';
    name = 'Falchion';
    price = 24;
    attackPower = 12.0;
  }
}

class PirateFalchion extends Sword {
  PirateFalchion() : super(GameItemAsset.falchion2) {
    description = 'A pirate\'s falchion.';
    name = 'Pirate Falchion';
    price = 19;
    attackPower = 13.0;
  }
}

class GoldenFalchion extends Sword {
  GoldenFalchion() : super(GameItemAsset.falchion2Old) {
    description = 'A golden falchion.';
    name = 'Golden Falchion';
    price = 112;
    attackPower = 10.0;
  }
}

class OrcishFalchion extends Sword {
  OrcishFalchion() : super(GameItemAsset.falchion3) {
    description = 'An orcish falchion.';
    name = 'Orcish Falchion';
    price = 33;
    attackPower = 17.0;
  }
}

class HeavyFalchion extends Sword {
  HeavyFalchion() : super(GameItemAsset.falchion4) {
    description = 'A heavy falchion.';
    name = 'Heavy Falchion';
    price = 33;
    attackPower = 16.0;
  }
}

class CleavingFalchion extends Sword {
  CleavingFalchion() : super(GameItemAsset.falchion5) {
    description = 'A cleaving falchion.';
    name = 'Cleaving Falchion';
    price = 42;
    attackPower = 19.0;
  }
}

class SteelFalchion extends Sword {
  SteelFalchion() : super(GameItemAsset.falchion6) {
    description = 'A steel falchion.';
    name = 'Steel Falchion';
    price = 14;
    attackPower = 15.0;
  }
}

class NobleFalchion extends Sword {
  NobleFalchion() : super(GameItemAsset.falchion7) {
    description = 'A noble falchion.';
    name = 'Noble Falchion';
    price = 54;
    attackPower = 15.0;
  }
}

class GoldenSword extends LargeSword {
  GoldenSword() : super(GameItemAsset.goldenSword) {
    description = 'A golden broadsword.';
    name = 'Golden Broadsword';
    price = 140;
    attackPower = 17.0;
  }
}

class GreatSword extends LargeSword {
  GreatSword() : super(GameItemAsset.greatSword) {
    description = 'A greatsword.';
    name = 'Greatsword';
    price = 37;
    attackPower = 24.0;
  }
}

class OldGreatSword extends LargeSword {
  OldGreatSword() : super(GameItemAsset.greatSwordOld) {
    description = 'An old greatsword.';
    name = 'Old Greatsword';
    price = 27;
    attackPower = 20.0;
  }
}

class RunicGreatSword extends LargeSword {
  RunicGreatSword() : super(GameItemAsset.greatSword2) {
    description = 'A greatsword with mysterious runes.';
    name = 'Runic Greatsword';
    price = 177;
    attackPower = 28.0;
  }
}

class NobleGreatSword extends LargeSword {
  NobleGreatSword() : super(GameItemAsset.greatSword3) {
    description = 'A noble man\'s greatsword.';
    name = 'Noble Greatsword';
    price = 126;
    attackPower = 25.0;
  }
}

class SteelGreatSword extends LargeSword {
  SteelGreatSword() : super(GameItemAsset.greatSword3Old) {
    description = 'A steel greatsword.';
    name = 'Steel Greatsword';
    price = 56;
    attackPower = 23.0;
  }
}

class MagicGreatSword extends LargeSword {
  MagicGreatSword() : super(GameItemAsset.greatSword4) {
    description = 'A magical greatsword.';
    name = 'Magic Greatsword';
    price = 192;
    attackPower = 28.0;
  }
}

class SteelKatana extends LargeSword {
  SteelKatana() : super(GameItemAsset.katana) {
    description = 'A steel katana.';
    name = 'Steel Katana';
    price = 53;
    attackPower = 28.0;
  }
}

class Katana extends LargeSword {
  Katana() : super(GameItemAsset.katana1) {
    description = 'An elegant katana.';
    name = 'Katana';
    price = 48;
    attackPower = 25.0;
  }
}

class MasterKatana extends LargeSword {
  MasterKatana() : super(GameItemAsset.katana2) {
    description = 'An master katana.';
    name = 'Master Katana';
    price = 82;
    attackPower = 30.0;
  }
}

class Knife extends Dagger {
  Knife() : super(GameItemAsset.knife) {
    description = 'A small knife.';
    name = 'Knife';
    price = 17;
    attackPower = 16.0;
  }
}

class OldLongSword extends LargeSword {
  OldLongSword() : super(GameItemAsset.longSword) {
    description = 'An old longsword.';
    name = 'Old Longsword';
    price = 22;
    attackPower = 26.0;
  }
}

class LongSword extends LargeSword {
  LongSword() : super(GameItemAsset.longSwordOld) {
    description = 'A longsword.';
    name = 'Longsword';
    price = 26;
    attackPower = 29.0;
  }
}

class NobleLongSword extends LargeSword {
  NobleLongSword() : super(GameItemAsset.longSword2) {
    description = 'A noble longsword.';
    name = 'Noble Longsword';
    price = 50;
    attackPower = 31.0;
  }
}

class WeirdLongSword extends LargeSword {
  WeirdLongSword() : super(GameItemAsset.longSword3) {
    description = 'A mysterious, weird longsword.';
    name = 'Weird Longsword';
    price = 0;
    attackPower = 25.0;
  }
}

class MagicLongSword extends LargeSword {
  MagicLongSword() : super(GameItemAsset.longSword5) {
    description = 'A magical longsword.';
    name = 'Magical Longsword';
    price = 110;
    attackPower = 26.0;
  }
}

class SturdyLongSword extends LargeSword {
  SturdyLongSword() : super(GameItemAsset.longSword6) {
    description = 'A sturdy longsword.';
    name = 'Sturdy Longsword';
    price = 40;
    attackPower = 29.0;
  }
}

class EnchantedLongSword extends LargeSword {
  EnchantedLongSword() : super(GameItemAsset.longSword7) {
    description = 'An enchanted longsword.';
    name = 'Enchanted Longsword';
    price = 190;
    attackPower = 40.0;
  }
}

class OrcishDagger extends Dagger {
  OrcishDagger() : super(GameItemAsset.orcishDagger) {
    description = 'An orcish dagger.';
    name = 'Orcish Dagger';
    price = 17;
    attackPower = 15.0;
  }
}

class OrcishGreatsword extends LargeSword {
  OrcishGreatsword() : super(GameItemAsset.orcishGreatSword) {
    description = 'An orcish greatsword.';
    name = 'Orcish Greatsword';
    price = 29;
    attackPower = 35.0;
  }
}

class OrcishLongsword extends LargeSword {
  OrcishLongsword() : super(GameItemAsset.orcishLongSword) {
    description = 'An orcish longsword.';
    name = 'Orcish Longsword';
    price = 36;
    attackPower = 38.0;
  }
}

class OrcishShortsword extends Sword {
  OrcishShortsword() : super(GameItemAsset.orcishShortSword) {
    description = 'An orcish shortsword.';
    name = 'Orcish Shortsword';
    price = 26;
    attackPower = 24.0;
  }
}

class Quickblade extends Sword {
  Quickblade() : super(GameItemAsset.quickblade) {
    description = 'A superfast blade!';
    name = 'Quickblade';
    price = 126;
    attackPower = 40.0;
  }
}

class Rapier extends Sword {
  Rapier() : super(GameItemAsset.rapier) {
    description = 'A rapier!';
    name = 'Rapier';
    price = 26;
    attackPower = 28.0;
  }
}

class MagicRapier extends Sword {
  MagicRapier() : super(GameItemAsset.rapier2) {
    description = 'A magic rapier!';
    name = 'Magic Rapier';
    price = 86;
    attackPower = 18.0;
  }
}

class NobleRapier extends Sword {
  NobleRapier() : super(GameItemAsset.rapier3) {
    description = 'A noble rapier!';
    name = 'Noble Rapier';
    price = 46;
    attackPower = 38.0;
  }
}

class SilverSabre extends Sword {
  SilverSabre() : super(GameItemAsset.sabreSilver) {
    description = 'A silver sabre useful against the undead!';
    name = 'Silver Sabre';
    price = 60;
    attackPower = 35.0;
  }
}

class BloodSabre extends Sword {
  BloodSabre() : super(GameItemAsset.sabre2) {
    description = 'A blood-thirsty sabre!';
    name = 'Blood Sabre';
    price = 44;
    attackPower = 46.0;
  }
}

class Scimitar extends Sword {
  Scimitar() : super(GameItemAsset.scimitar) {
    description = 'A shiny scimitar!';
    name = 'Scimitar';
    price = 27;
    attackPower = 20.0;
  }
}

class OldScimitar extends Sword {
  OldScimitar() : super(GameItemAsset.scimitarOld) {
    description = 'An old scimitar!';
    name = 'Old Scimitar';
    price = 17;
    attackPower = 14.0;
  }
}

class GoldenScimitar extends Sword {
  GoldenScimitar() : super(GameItemAsset.scimitar2) {
    description = 'A gold-adorned scimitar!';
    name = 'Golden Scimitar';
    price = 76;
    attackPower = 44.0;
  }
}

class MagicalScimitar extends Sword {
  MagicalScimitar() : super(GameItemAsset.scimitar3) {
    description = 'A magical scimitar!';
    name = 'Magical Scimitar';
    price = 114;
    attackPower = 40.0;
  }
}

class RustyShortSword extends Sword {
  RustyShortSword() : super(GameItemAsset.shortSword) {
    description =
        'A bit rusty and pretty weak, but it can still do some damage.';
    name = 'Rusty short sword';
    price = 14;
    attackPower = 5.0;
  }
}

class OldShortSword extends Sword {
  OldShortSword() : super(GameItemAsset.shortSwordOld) {
    description = 'An old, worn short sword.';
    name = 'Old Short Sword';
    price = 20;
    attackPower = 6.0;
  }
}

class MagicalShortSword extends Sword {
  MagicalShortSword() : super(GameItemAsset.shortSword2) {
    description = 'A magical short sword.';
    name = 'Magical Short Sword';
    price = 90;
    attackPower = 55.0;
  }
}

class SturdyShortSword extends Sword {
  SturdyShortSword() : super(GameItemAsset.shortSword2Old) {
    description = 'A sturdy short sword.';
    name = 'Sturdy Short Sword';
    price = 28;
    attackPower = 26.0;
  }
}

class NobleShortSword extends Sword {
  NobleShortSword() : super(GameItemAsset.shortSword3) {
    description = 'A nobleman short sword.';
    name = 'Noble Short Sword';
    price = 78;
    attackPower = 30.0;
  }
}

class GoldenShortSword extends Sword {
  GoldenShortSword() : super(GameItemAsset.shortSword5) {
    description = 'A gold-adorned short sword.';
    name = 'Gold Short Sword';
    price = 120;
    attackPower = 20.0;
  }
}

class SteelShortSword extends Sword {
  SteelShortSword() : super(GameItemAsset.shortSword6) {
    description = 'A steel short sword.';
    name = 'Steel Short Sword';
    price = 45;
    attackPower = 30.0;
  }
}

class DarkShortSword extends Sword {
  DarkShortSword() : super(GameItemAsset.shortSword7) {
    description = 'A short sword that exhumes dark power!';
    name = 'Dark Short Sword';
    price = 200;
    attackPower = 60.0;
  }
}

class TripleSword extends LargeSword {
  TripleSword() : super(GameItemAsset.tripleSword) {
    description = 'A massive triple sword!';
    name = 'Triple Sword';
    price = 90;
    attackPower = 50.0;
  }
}

class OldTripleSword extends LargeSword {
  OldTripleSword() : super(GameItemAsset.tripleSwordOld) {
    description = 'A big old triple sword!';
    name = 'Old Triple Sword';
    price = 70;
    attackPower = 40.0;
  }
}

class NobleTripleSword extends LargeSword {
  NobleTripleSword() : super(GameItemAsset.tripleSword2) {
    description = 'A nobleman triple sword!';
    name = 'Noble Triple Sword';
    price = 140;
    attackPower = 56.0;
  }
}

class DragonTripleSword extends LargeSword {
  DragonTripleSword() : super(GameItemAsset.tripleSword3) {
    description = 'A dragon-scale adorned triple sword!';
    name = 'Dragon Triple Sword';
    price = 180;
    attackPower = 76.0;
  }
}

class Tsurugi extends Sword {
  Tsurugi() : super(GameItemAsset.tsurugi) {
    description = 'An elegant, fast weapon!';
    name = 'Tsurugi';
    price = 140;
    attackPower = 70.0;
  }
}

class TwoHandedSword extends LargeSword {
  TwoHandedSword() : super(GameItemAsset.twoHandedSword) {
    description = 'A heavy two-handed sword!';
    name = 'Two-Handed Sword';
    price = 58;
    attackPower = 60.0;
  }
}
