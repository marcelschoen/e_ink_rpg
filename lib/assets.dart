// ****************************************
// constants for icon assets
// ****************************************
import 'package:flutter/material.dart';

// ****************************************
// constants for item assets
// ****************************************
enum GameItemAsset {
  // food
  apple('food/apple.png'),
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
  ;

  const GameIconAsset(this._filename);

  final String _filename;

  String filename() {
    return 'assets/icons/' + this._filename;
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
