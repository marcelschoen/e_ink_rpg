// ****************************************
// constants for icon assets
// ****************************************
import 'package:flutter/material.dart';

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
  // armor
  ironHelmet('armor/headgear/helmet_1.png'),
  ironBreastPlate('armor/torso/chain_mail_1.png'),
  ironGloves('armor/hands/gauntlet_1.png'),
  // weapons
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
