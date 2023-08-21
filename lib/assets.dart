// ****************************************
// constants for icon assets
// ****************************************
import 'package:flutter/material.dart';
/*
enum GameFontAsset {
  diablo_heavy('fonts/Diablo/Diablo Heavy/DiabloHeavy.ttf'),
  diablo_light('fonts/Diablo/Diablo Heavy/DiabloLight.ttf'),
  ;

  const GameFontAsset(this._filename);

  final String _filename;

  String filename() {
    return 'assets/' + this._filename;
  }
}

 */

// ****************************************
// constants for various image assets
// ****************************************
enum GameImageAsset {

  daytime_morning('daytime/time_morning.png'),
  daytime_day('daytime/time_day.png'),
  daytime_evening('daytime/time_evening.png'),
  daytime_night('daytime/time_night.png'),
  ;

  const GameImageAsset(this._filename);

  final String _filename;

  String filename() {
    return 'assets/' + this._filename;
  }

  Widget getGameImage(double size) {
    return getSizedImage(filename(), size);
  }
}

// ****************************************
// constants for item assets
// ****************************************
enum GameItemAsset {
  // food
  apple('food/apple.png'),
  apricot('food/apricot_new.png'),
  banana('food/banana_new.png'),
  beef_jerky('food/beef_jerky_new.png'),
  cheese('food/cheese.png'),
  grape('food/grape.png'),
  choko('food/choko.png'),
  lemon('food/lemon_new.png'),
  bread_ration('food/bread_ration_new.png'),
  bone('food/bone.png'),
  fruit('food/fruit.png'),
  honeycomb('food/honeycomb_new.png'),
  orange('food/orange.png'),
  pear('food/pear.png'),
  sausage('food/sausage.png'),
  strawberry('food/strawberry_new.png'),
  snozzcumber('food/snozzcumber.png'),
  sultana('food/sultana.png'),
  // valuables
  gold_pile('gold/gold_pile.png'),
  // potions
  potion('potion/brilliant_blue_new.png'),

  // ----------------------------------------------
  // armor
  // ----------------------------------------------

  // head
  cap('armor/headgear/cap_1.png'),
  cap2('armor/headgear/cap_2.png'),
  wizardCap('armor/headgear/cornuthaum.png'),
  crestedHelmet('armor/headgear/crested_helmet.png'),
  elvenLeatherHat('armor/headgear/elven_leather_helm.png'),
  greenMask('armor/headgear/green_mask.png'),
  hat('armor/headgear/hat_1.png'),
  hat2('armor/headgear/hat_2.png'),
  hat3('armor/headgear/hat_3.png'),
  helmet('armor/headgear/helmet_1.png'),
  helmetVisored('armor/headgear/helmet_1_visored.png'),
  helmet2('armor/headgear/helmet_2.png'),
  helmetEtched('armor/headgear/helmet_2_etched.png'),
  helmet3('armor/headgear/helmet_3.png'),
  helmet3old('armor/headgear/helmet_3_old.png'),
  helmet4('armor/headgear/helmet_4.png'),
  helmet4visor('armor/headgear/helmet_4_visor.png'),
  helmet5('armor/headgear/helmet_5.png'),
  helmetArt('armor/headgear/helmet_art_1.png'),
  helmetArt2('armor/headgear/helmet_art_2.png'),
  helmetArt3('armor/headgear/helmet_art_3.png'),
  helmetEgo('armor/headgear/helmet_ego_1.png'),
  helmetEgo2('armor/headgear/helmet_ego_2.png'),
  helmetEgo3('armor/headgear/helmet_ego_3.png'),
  helmetEgo4('armor/headgear/helmet_ego_4.png'),
  plumedHelmet('armor/headgear/plumed_helmet.png'),
  wizardHat('armor/headgear/wizard_hat_1.png'),
  wizardHat2('armor/headgear/wizard_hat_2.png'),

  // torso
  bandedMailBreastPlate('armor/torso/banded_mail_1.png'),
  bandedMail2BreastPlate('armor/torso/banded_mail_2.png'),
  chainMailBreastPlate('armor/torso/chain_mail_1.png'),
  chainMail2BreastPlate('armor/torso/chain_mail_2.png'),
  chainMail3BreastPlate('armor/torso/chain_mail_3.png'),
  crystalBreastPlate('armor/torso/crystal_plate.png'),
  dwarvenRingmailBreastPlate('armor/torso/dwarven_ringmail.png'),
  elvenLeatherBreastPlate('armor/torso/elven_leather_armor.png'),
  elvenRingmailBreastPlate('armor/torso/elven_ringmail.png'),
  elvenScalemailBreastPlate('armor/torso/elven_scalemail.png'),
  iceDragonNewBreastPlate('armor/torso/ice_dragon_armor_new.png'),
  iceDragonOldBreastPlate('armor/torso/ice_dragon_armor_old.png'),
  leatherArmorBreastPlate('armor/torso/leather_armor_1.png'),
  leather2ArmorBreastPlate('armor/torso/leather_armor_2.png'),
  leather3ArmorBreastPlate('armor/torso/leather_armor_3.png'),
  orcishChainmailBreastPlate('armor/torso/orcish_chain_mail.png'),
  orcishLeatherBreastPlate('armor/torso/orcish_leather_armor.png'),
  orcishPlate2BreastPlate('armor/torso/orcish_plate_2.png'),
  orcishPlateMailBreastPlate('armor/torso/orcish_plate_mail.png'),
  orcishRingmailBreastPlate('armor/torso/orcish_ringmail.png'),
  pearlDragonBreastPlate('armor/torso/pearl_dragon_armor.png'),
  pearlDragonHidePlate('armor/torso/pearl_dragon_hide.png'),
  plateBreastPlate('armor/torso/plate_1.png'),
  plateMailBreastPlate('armor/torso/plate_mail_1.png'),
  plateMail2BreastPlate('armor/torso/plate_mail_2.png'),
  quicksilverDragonScaleMailBreastPlate('armor/torso/quicksilver_dragon_scale_mail.png'),
  quicksilverDragonScalesBreastPlate('armor/torso/quicksilver_dragon_scales.png'),
  ringMailBreastPlate('armor/torso/ring_mail_1_new.png'),
  ringMailOldBreastPlate('armor/torso/ring_mail_1_old.png'),
  ringMail2BreastPlate('armor/torso/ring_mail_2_new.png'),
  ringMailOld2BreastPlate('armor/torso/ring_mail_2_old.png'),
  ringMail3BreastPlate('armor/torso/ring_mail_3.png'),
  robeBreastPlate('armor/torso/robe_1_new.png'),
  robeOldBreastPlate('armor/torso/robe_1_old.png'),
  robe2BreastPlate('armor/torso/robe_2_new.png'),
  robe2OldBreastPlate('armor/torso/robe_2_old.png'),
  robe3BreastPlate('armor/torso/robe_3.png'),
  robeArtBreastPlate('armor/torso/robe_art_1.png'),
  robeArt2BreastPlate('armor/torso/robe_art_2.png'),
  robeEgoBreastPlate('armor/torso/robe_ego_1.png'),
  robeEgo2BreastPlate('armor/torso/robe_ego_2.png'),
  scaleMailBreastPlate('armor/torso/scale_mail_1_new.png'),
  scaleMailOldBreastPlate('armor/torso/scale_mail_1_old.png'),
  scaleMail2BreastPlate('armor/torso/scale_mail_2_new.png'),
  scaleMail2OldBreastPlate('armor/torso/scale_mail_2_old.png'),
  scaleMail3BreastPlate('armor/torso/scale_mail_3.png'),
  silverDragonScaleBreastPlate('armor/torso/silver_dragon_scale.png'),
  splintMailBreastPlate('armor/torso/sprint_mail_1.png'),
  splintMail2BreastPlate('armor/torso/sprint_mail_2.png'),
  swampDragonBreastPlate('armor/torso/swamp_dragon_armor_new.png'),
  swampDragonOldBreastPlate('armor/torso/swamp_dragon_armor_old.png'),
  trollLeatherBreastPlate('armor/torso/troll_leather_armor.png'),

  // hands
  gauntlet('armor/hands/gauntlet_1.png'),
  glove('armor/hands/glove_1_new.png'),
  gloveOld('armor/hands/glove_1_old.png'),
  glove2('armor/hands/glove_2_new.png'),
  glove2old('armor/hands/glove_2_old.png'),
  glove3('armor/hands/glove_3_new.png'),
  glove3old('armor/hands/glove_3_old.png'),
  glove4Gauntlets('armor/hands/glove_4_gauntlets.png'),
  glove4('armor/hands/glove_4_new.png'),
  glove4old('armor/hands/glove_4_old.png'),
  glove5('armor/hands/glove_5.png'),

  // legs
  bootsBrown('armor/feet/boots_1_brown_new.png'),
  bootsBrownOld('armor/feet/boots_1_brown_old.png'),
  bootsJackboots('armor/feet/boots_2_jackboots.png'),
  bootsStripe('armor/feet/boots_3_stripe_new.png'),
  bootsStripeOld('armor/feet/boots_3_stripe_old.png'),
  bootsGreen('armor/feet/boots_4_green.png'),
  bootsIron('armor/feet/boots_iron_2.png'),
  bootsLow('armor/feet/low_boots.png'),

  // ----------------------------------------------
  // weapons
  // ----------------------------------------------
  rustyShortSword('weapon/short_sword_1_new.png'),
  ;

  const GameItemAsset(this._filename);

  final String _filename;

  String filename() {
    return 'assets/item/' + this._filename;
  }

  Widget getItemImage() {
    return getImageFit(filename());
//    return getImageSmall(filename());
  }
}

// ****************************************
// constants for icon assets
// ****************************************
enum GameIconAsset {

  attack('icon163.png'),
  fight('icon2.png'),
  flee('icon8.png'),
  heart('icon23.png'),
  death('icon11.png'),
  magic('icon37.png'),
  skill('icon9.png'),
  spy('icon35.png'),
  special('icon19.png'),

  scrollWithFeather('icon212.png'),
  ;

  const GameIconAsset(this._filename);

  final String _filename;

  String filename() {
    return 'assets/icons/' + this._filename;
  }

  Widget getIconImage() {
    return getImageFit(filename());
//    return getImageSmall(filename());
  }
}

// ****************************************
// constants for image assets
// ****************************************
enum GameMonsterImageAsset {

  monster('bloodbat.png'),
  ;

  const GameMonsterImageAsset(this._filename);

  final String _filename;

  Widget getMonsterImage() {
    return getImage('assets/monster/' + this._filename);
  }

}

// ****************************************
// constants for image assets
// ****************************************
enum GameNpcImageAsset {

  player('Human1.png'),
  ;

  const GameNpcImageAsset(this._filename);

  final String _filename;

  Widget getNpcImage() {
    return getImage('assets/humanoid/' + this._filename);
  }
}

SizedBox getSizedImage(String filename, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: Image(image: AssetImage(filename)),
  );
}

SizedBox getImage(String filename) {
  return SizedBox(
    width: 64,
    height: 64,
    child: Image(image: AssetImage(filename)),
  );
}

SizedBox getImageSmall(String filename) {
  return SizedBox(
    width: 32,
    height: 32,
    child: Image(image: AssetImage(filename)),
  );
}

Widget getImageFit(String filename) {
  return Image.asset(
      filename,
      fit: BoxFit.cover
  );
}
