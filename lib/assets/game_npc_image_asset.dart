import '../util/asset_filename.dart';

// ****************************************
// constants for image assets
// ****************************************
enum GameNpcImageAsset with AssetFilename {

  female1('faces/female/Portrait_1.png'),
  female2('faces/female/Portrait_2.png'),
  female3('faces/female/Portrait_3.png'),
  female4('faces/female/Portrait_4.png'),
  female5('faces/female/Portrait_5.png'),
  female6('faces/female/Portrait_6.png'),
  female7('faces/female/Portrait_7.png'),
  female8('faces/female/Portrait_8.png'),
  female9('faces/female/Portrait_9.png'),
  female10('faces/female/Portrait_10.png'),

  //male2('faces/male/Portrait_2.png'),  // FIX BACKGROUND
  male3('faces/male/Portrait_3.png'),
  male4('faces/male/Portrait_4.png'),
  male5('faces/male/Portrait_5.png'),
  male6('faces/male/Portrait_6.png'),
  male7('faces/male/Portrait_7.png'),
  male8('faces/male/Portrait_8.png'),
  male9('faces/male/Portrait_9.png'),
  male10('faces/male/Portrait_10.png'),
  male11('faces/male/Portrait_11.png'),
  male12('faces/male/Portrait_12.png'),
  male13('faces/male/Portrait_13.png'),
  male14('faces/male/Portrait_14.png'),
  male15('faces/male/Portrait_15.png'),
  male16('faces/male/Portrait_16.png'),
  male17('faces/male/Portrait_17.png'),
  male18('faces/male/Portrait_18.png'),
  male19('faces/male/Portrait_19.png'),
  male20('faces/male/Portrait_20.png'),
  male21('faces/male/Portrait_21.png'),
  male22('faces/male/Portrait_22.png'),
  male23('faces/male/Portrait_23.png'),
  male24('faces/male/Portrait_24.png'),
  male25('faces/male/Portrait_25.png'),
  male26('faces/male/Portrait_26.png'),
  male27('faces/male/Portrait_27.png'),
  male28('faces/male/Portrait_28.png'),
  male29('faces/male/Portrait_29.png'),
  male30('faces/male/Portrait_30.png'),
  male31('faces/male/Portrait_31.png'),
  male32('faces/male/Portrait_32.png'),
  male33('faces/male/Portrait_33.png'),

  player('Human1.png'),
  ;

  const GameNpcImageAsset(this.rawFilename);

  @override
  final String rawFilename;

  @override
  String get assetFolder => 'humanoid/';
}
