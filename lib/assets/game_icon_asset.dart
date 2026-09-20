import 'package:flutter/material.dart';

import '../util/asset_filename.dart';
import '../util/image_widgets.dart';

// ****************************************
// constants for icon assets
// ****************************************
enum GameIconAsset with AssetFilename {

  search('icon213.png'),
  goback('icon19.png'),

  attack('icon163.png'),
  fight('icon2.png'),
  flee('icon8.png'),
  heart('icon23.png'),
  death('icon11.png'),
  magic('icon37.png'),
  focus('icon9.png'),
  spy('icon35.png'),
  special('icon19.png'),

  scrollWithFeather('icon212.png'),
  ;

  const GameIconAsset(this.rawFilename);

  @override
  final String rawFilename;

  @override
  String get assetFolder => 'icons/';

  Widget getIconImage() {
    return getImageFit(filename());
//    return getImageSmall(filename());
  }
}
