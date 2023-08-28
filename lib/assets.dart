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
  map_paper_background('map/paper-background.png'),
  map_paper_background_bw('map/paper-background-bw.png'),
  map_paper_background_bw_transparent('map/paper-background-bw-transparent.png'),

  map_icon_question_mark('map/question-mark.png'),

  map_poi_dungeon_entrance('map/poi/DungeonEntrance1.png'),
  map_poi_dungeon_entrance2('map/poi/DungeonEntrance2.png'),
  map_poi_shop_interior('map/poi/ShowInterior1.png'),

  map_loc_bridge_east_west('map/locations/Narrasil Bridge East-West.png'),
  map_loc_bridge_north_south('map/locations/Narrasil Bridge North-South.png'),
  map_loc_fantasy_castle('map/locations/FantasyCastle.png'),
  map_loc_castle('map/locations/Narrasil Castle.png'),
  map_loc_castle_2('map/locations/Narrasil Castle 2.png'),
  map_loc_city('map/locations/Narrasil City.png'),
  map_loc_city_2('map/locations/Narrasil City 2.png'),
  map_loc_crevasse('map/locations/Narrasil Crevasse.png'),
  map_loc_dead_tree_1('map/locations/Narrasil Dead Tree 1.png'),
  map_loc_dead_tree_2('map/locations/Narrasil Dead Tree 2.png'),
  map_loc_dunes('map/locations/Narrasil Dunes.png'),
  map_loc_fortress('map/locations/Narrasil Fortress.png'),
  map_loc_hamlet('map/locations/Narrasil Hamlet.png'),
  map_loc_hill_1('map/locations/Narrasil Hill 1.png'),
  map_loc_hill_2('map/locations/Narrasil Hill 2.png'),
  map_loc_hill_3('map/locations/Narrasil Hill 3.png'),
  map_loc_hill_4('map/locations/Narrasil Hill 4.png'),
  map_loc_hill_5('map/locations/Narrasil Hill 5.png'),
  map_loc_hill_6('map/locations/Narrasil Hill 6.png'),
  map_loc_jungle_tree_1('map/locations/Narrasil Jungle Tree 1.png'),
  map_loc_jungle_tree_2('map/locations/Narrasil Jungle Tree 2.png'),
  map_loc_jungle_tree_3('map/locations/Narrasil Jungle Tree 3.png'),
  map_loc_marsh('map/locations/Narrasil Marsh.png'),
  map_loc_mesa_1('map/locations/Narrasil Mesa 1.png'),
  map_loc_mesa_2('map/locations/Narrasil Mesa 2.png'),
  map_loc_monolith('map/locations/Narrasil Monolith.png'),
  map_loc_mountain_1('map/locations/Narrasil Mountain 1.png'),
  map_loc_mountain_2('map/locations/Narrasil Mountain 2.png'),
  map_loc_mountain_3('map/locations/Narrasil Mountain 3.png'),
  map_loc_mountain_4('map/locations/Narrasil Mountain 4.png'),
  map_loc_mountain_5('map/locations/Narrasil Mountain 5.png'),
  map_loc_mountain_6('map/locations/Narrasil Mountain 6.png'),
  map_loc_mountain_large_1('map/locations/Narrasil Mountain Large 1.png'),
  map_loc_mountain_large_2('map/locations/Narrasil Mountain Large 2.png'),
  map_loc_mountain_large_3('map/locations/Narrasil Mountain Large 3.png'),
  map_loc_mountain_large_4('map/locations/Narrasil Mountain Large 4.png'),
  map_loc_mountain_peak_1('map/locations/Narrasil Mountain Peak 1.png'),
  map_loc_mountain_peak_2('map/locations/Narrasil Mountain Peak 2.png'),
  map_loc_oasis('map/locations/Narrasil Oasis.png'),
  map_loc_pine_tree_1('map/locations/Narrasil Pine Tree 1.png'),
  map_loc_pine_tree_2('map/locations/Narrasil Pine Tree 2.png'),
  map_loc_pine_tree_3('map/locations/Narrasil Pine Tree 3.png'),
  map_loc_pine_tree_4('map/locations/Narrasil Pine Tree 4.png'),
  map_loc_pine_tree_5('map/locations/Narrasil Pine Tree 5.png'),
  map_loc_pine_tree_6('map/locations/Narrasil Pine Tree 6.png'),
  map_loc_ridge('map/locations/Narrasil Ridge.png'),
  map_loc_ruin_large('map/locations/Narrasil Ruin Large.png'),
  map_loc_ruin_small('map/locations/Narrasil Ruin Small.png'),
  map_loc_square_tower('map/locations/Narrasil Square Tower.png'),
  map_loc_standing_stones('map/locations/Narrasil Standing Stones.png'),
  map_loc_stronghold('map/locations/Narrasil Stronghold.png'),
  map_loc_swamp('map/locations/Narrasil Swamp.png'),
  map_loc_three_towers('map/locations/Narrasil Three Towers.png'),
  map_loc_tower('map/locations/Narrasil Tower.png'),
  map_loc_town('map/locations/Narrasil Town.png'),
  map_loc_tree_1('map/locations/Narrasil Tree 1.png'),
  map_loc_tree_2('map/locations/Narrasil Tree 2.png'),
  map_loc_tree_3('map/locations/Narrasil Tree 3.png'),
  map_loc_tree_4('map/locations/Narrasil Tree 4.png'),
  map_loc_tree_5('map/locations/Narrasil Tree 5.png'),
  map_loc_tree_6('map/locations/Narrasil Tree 6.png'),
  map_loc_village('map/locations/Narrasil Village.png'),
  map_loc_volcano_active('map/locations/Narrasil Volcano Active.png'),
  map_loc_volcano_dormant('map/locations/Narrasil Volcano Dormant.png'),
  map_loc_walled_enclosure('map/locations/Narrasil Walled Enclosure.png'),
  map_loc_walled_enclosure_2('map/locations/Narrasil Walled Enclosure 2.png'),
  map_loc_walled_tower('map/locations/Narrasil Walled Tower.png'),
  map_loc_custom_dungeon_entrance('map/locations/Custom Dungeon Entrance.png'),
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
  pearlDragonHide('armor/torso/pearl_dragon_hide.png'),
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
  blessedBlade('weapon/blessed_blade.png'),
  claymore('weapon/claymore.png'),
  claymore2('weapon/claymore2.png'),
  claymore3('weapon/claymore3.png'),
  claymoreBlessed('weapon/claymore_blessed.png'),
  cutlass('weapon/cutlass.png'),
  cutlass3('weapon/cutlass_3.png'),
  cutlass4('weapon/cutlass_4.png'),
  cutlass5('weapon/cutlass_5.png'),
  cutlass6('weapon/cutlass_6.png'),
  cutlass7('weapon/cutlass_7.png'),
  cutlass8('weapon/cutlass_8.png'),
  cutlass9('weapon/cutlass_9.png'),
  dagger3('weapon/dagger_3.png'),
  dagger6('weapon/dagger_6.png'),
  dagger7('weapon/dagger_7.png'),
  dagger('weapon/dagger_new.png'),
  daggerOld('weapon/dagger_old.png'),
  demonBlade('weapon/demon_blade.png'),
  doubleSword('weapon/double_sword_new.png'),
  doubleSwordOld('weapon/double_sword_old.png'),
  doubleSword2('weapon/double_sword_2.png'),
  doubleSword3('weapon/double_sword_3.png'),
  elvenBroadsword('weapon/elven_broadsword.png'),
  elvenDagger('weapon/elven_dagger.png'),
  elvenShortsword('weapon/elven_shortsword.png'),
  falchion('weapon/falchion_1_new.png'),
  falchionOld('weapon/falchion_1_old.png'),
  falchion2('weapon/falchion_2_new.png'),
  falchion2Old('weapon/falchion_2_old.png'),
  falchion3('weapon/falchion_3.png'),
  falchion4('weapon/falchion_4.png'),
  falchion5('weapon/falchion_5.png'),
  falchion6('weapon/falchion_6.png'),
  falchion7('weapon/falchion_7.png'),
  goldenSword('weapon/golden_sword.png'),
  greatSword('weapon/greatsword_1_new.png'),
  greatSwordOld('weapon/greatsword_1_old.png'),
  greatSword2('weapon/greatsword_2.png'),
  greatSword3('weapon/greatsword_3.png'),
  greatSword3Old('weapon/greatsword_3_old.png'),
  greatSword4('weapon/greatsword_4.png'),
  katana('weapon/katana.png'),
  katana1('weapon/katana_1.png'),
  katana2('weapon/katana_2.png'),
  knife('weapon/knife.png'),
  longSword('weapon/long_sword_1_new.png'),
  longSwordOld('weapon/long_sword_1_old.png'),
  longSword2('weapon/long_sword_2.png'),
  longSword3('weapon/long_sword_3.png'),
  longSword5('weapon/long_sword_5.png'),
  longSword6('weapon/long_sword_6.png'),
  longSword7('weapon/long_sword_7.png'),
  orcishDagger('weapon/orcish_dagger.png'),
  orcishGreatSword('weapon/orcish_great_sword.png'),
  orcishLongSword('weapon/orcish_long_sword.png'),
  orcishShortSword('weapon/orcish_short_sword.png'),
  quickblade('weapon/quickblade.png'),
  rapier('weapon/rapier_1.png'),
  rapier2('weapon/rapier_2.png'),
  rapier3('weapon/rapier_3.png'),
  sabreSilver('weapon/sabre_1_silver.png'),
  sabre2('weapon/sabre_2.png'),
  scimitar('weapon/scimitar_1_new.png'),
  scimitarOld('weapon/scimitar_1_old.png'),
  scimitar2('weapon/scimitar_2.png'),
  scimitar3('weapon/scimitar_3.png'),
  shortSword('weapon/short_sword_1_new.png'),
  shortSwordOld('weapon/short_sword_1_old.png'),
  shortSword2('weapon/short_sword_2_new.png'),
  shortSword2Old('weapon/short_sword_2_old.png'),
  shortSword3('weapon/short_sword_3.png'),
  shortSword5('weapon/short_sword_5.png'),
  shortSword6('weapon/short_sword_6.png'),
  shortSword7('weapon/short_sword_7.png'),
  tripleSword('weapon/triple_sword_new.png'),
  tripleSwordOld('weapon/triple_sword_old.png'),
  tripleSword2('weapon/triple_sword_2.png'),
  tripleSword3('weapon/triple_sword_3.png'),
  tsurugi('weapon/tsurugi.png'),
  twoHandedSword('weapon/two_handed_sword.png'),
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

  search('icon213.png'),
  goback('icon19.png'),

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
