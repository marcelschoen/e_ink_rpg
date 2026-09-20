// Barrel file: re-exports the individual asset enums so existing imports of
// 'assets.dart' keep working unchanged. See lib/assets/ for the actual
// definitions, one enum per file, and lib/util/image_widgets.dart for the
// shared image-widget helpers they use.
export 'assets/game_font_asset.dart';
export 'assets/game_icon_asset.dart';
export 'assets/game_image_asset.dart';
export 'assets/game_item_asset.dart';
export 'assets/game_monster_image_asset.dart';
export 'assets/game_npc_image_asset.dart';
export 'util/image_widgets.dart';
