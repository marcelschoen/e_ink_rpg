import 'package:flutter/material.dart';

import '../util/asset_filename.dart';
import '../util/image_widgets.dart';

// ****************************************
// constants for image assets
// ****************************************
enum GameMonsterImageAsset with AssetFilename {

  monster('bloodbat.png'),
  ;

  const GameMonsterImageAsset(this.rawFilename);

  @override
  final String rawFilename;

  @override
  String get assetFolder => 'monster/';

  Widget getMonsterImage() {
    return getImage(filename());
  }

}
