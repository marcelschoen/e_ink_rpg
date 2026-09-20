import 'package:flutter/material.dart';

import '../util/asset_filename.dart';
import '../util/image_widgets.dart';

// ****************************************
// constants for various image assets
// ****************************************
enum GameImageAsset with AssetFilename {

  npc_humanoid('humanoid/Human1.png'),

  mount_horse('mounts/horse.png'),

  daytime_morning('daytime/time_morning.png'),
  daytime_day('daytime/time_day.png'),
  daytime_evening('daytime/time_evening.png'),
  daytime_night('daytime/time_night.png'),
  map_paper_background('map/paper-background.png'),
  map_paper_background_bw('map/paper-background-bw.png'),
  map_paper_background_bw_transparent('map/paper-background-bw-transparent.png'),

  map_icon_question_mark('map/loc/question-mark.png'),
  map_icon_lock('map/locked.png'),

  map_loc_hamlet('map/loc/Narrasil Hamlet small.png'),


  // Tile based map content

  map_tile_empty('map/tiles/empty-location.png'),

  map_tile_center_up('map/tiles/center-up.png'),
  map_tile_center_down('map/tiles/center-down.png'),
  map_tile_center_left('map/tiles/center-left.png'),
  map_tile_center_right('map/tiles/center-right.png'),
  map_tile_center_location('map/tiles/center-location.png'),
  map_tile_center_question_mark('map/tiles/center-question-mark.png'),

  map_tile_region('map/tiles/region.png'),

  // POI tiles

  map_tile_poi_village('map/tiles/poi_village.png'),
  map_tile_poi_dungeon('map/tiles/poi_dungeon.png'),

  // Background tiles (map background between path)
  map_tile_bg_pinetrees_1('map/tiles/bg_pinetrees.png'),
  map_tile_bg_pinetrees_2('map/tiles/bg_pinetrees_2.png'),
  map_tile_bg_pinetrees_3('map/tiles/bg_pinetrees_3.png'),
  map_tile_bg_pinetrees_4('map/tiles/bg_pinetrees_4.png'),
  map_tile_bg_pinetrees_5('map/tiles/bg_pinetrees_5.png'),

  map_tile_bg_leaftrees_1('map/tiles/bg_leaftrees_1.png'),
  map_tile_bg_leaftrees_2('map/tiles/bg_leaftrees_2.png'),
  map_tile_bg_leaftrees_3('map/tiles/bg_leaftrees_3.png'),
  map_tile_bg_leaftrees_4('map/tiles/bg_leaftrees_4.png'),
  map_tile_bg_leaftrees_5('map/tiles/bg_leaftrees_5.png'),

  map_player_position('map/tiles/player_position.png'),

  map_poi_dungeon_entrance('map/poi/DungeonEntrance1.png'),
  map_poi_dungeon_entrance2('map/poi/DungeonEntrance2.png'),
  map_poi_shop_interior('map/poi/ShopInterior1.png'),

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

  const GameImageAsset(this.rawFilename);

  @override
  final String rawFilename;

  Widget getGameImage() {
    return getSizedImage(filename(), 64);
  }
/*
  Widget getGameImage(double size) {
    return getSizedImage(filename(), size);
  }

 */
}
