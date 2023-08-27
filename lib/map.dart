import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/location.dart';

List<GameImageAsset> locationImage = [
  GameImageAsset.map_loc_custom_dungeon_entrance,

  GameImageAsset.map_loc_bridge_east_west,
  GameImageAsset.map_loc_bridge_north_south,
  GameImageAsset.map_loc_castle,
  GameImageAsset.map_loc_castle_2,
  GameImageAsset.map_loc_city,
  GameImageAsset.map_loc_city_2,
  GameImageAsset.map_loc_crevasse,
  GameImageAsset.map_loc_dead_tree_1,
  GameImageAsset.map_loc_dead_tree_2,
  GameImageAsset.map_loc_dunes,
  GameImageAsset.map_loc_fortress,
  GameImageAsset.map_loc_hamlet,
  GameImageAsset.map_loc_hill_1,

  GameImageAsset.map_loc_jungle_tree_1,

  GameImageAsset.map_loc_marsh,

  GameImageAsset.map_loc_mesa_1,
  GameImageAsset.map_loc_mesa_2,

  GameImageAsset.map_loc_monolith,

  GameImageAsset.map_loc_mountain_1,
  GameImageAsset.map_loc_mountain_2,
  GameImageAsset.map_loc_mountain_3,
  GameImageAsset.map_loc_mountain_4,
  GameImageAsset.map_loc_mountain_5,
  GameImageAsset.map_loc_mountain_6,
  GameImageAsset.map_loc_mountain_large_1,
  GameImageAsset.map_loc_mountain_large_2,
  GameImageAsset.map_loc_mountain_large_3,
  GameImageAsset.map_loc_mountain_large_4,
  GameImageAsset.map_loc_oasis,
  GameImageAsset.map_loc_mountain_peak_1,
  GameImageAsset.map_loc_mountain_peak_2,
  GameImageAsset.map_loc_pine_tree_1,
  GameImageAsset.map_loc_pine_tree_2,
  GameImageAsset.map_loc_pine_tree_3,
  GameImageAsset.map_loc_pine_tree_4,
  GameImageAsset.map_loc_pine_tree_5,
  GameImageAsset.map_loc_pine_tree_6,
  GameImageAsset.map_loc_ridge,
  GameImageAsset.map_loc_ruin_large,
  GameImageAsset.map_loc_ruin_small,
  GameImageAsset.map_loc_square_tower,
  GameImageAsset.map_loc_standing_stones,
  GameImageAsset.map_loc_mesa_1,
  GameImageAsset.map_loc_mesa_2,
];

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------
Widget getMapScreen(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-.2, 0),
                image: AssetImage(GameImageAsset.map_paper_background_bw_transparent.filename()),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 40),
          child: getMapContents(context),
          //getOutlinedText('Region: ' + NameHandler.allNames.compose(3), 24, 1, Colors.black, Colors.white),
        ),
      ),
      Column(
        children: [
          BaseButton.textOnlyWithSizes('CLICK', (p0) { }, 18, 160, 40),
          BaseButton.textOnlyWithSizes('CLICK', (p0) { }, 18, 160, 40),
        ],
      )
    ],
  );
}

Widget getMapContents(BuildContext context) {
  GameRegion region = GameState().currentRegion;
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: getOutlinedText('Region: ' + NameHandler.allNames.compose(3), 24, 1, Colors.black, Colors.white),
      ),
      Expanded(child: getLocations(region, context)),
    ],
  );
}

Widget getLocations(GameRegion region, BuildContext context) {

  List<GameLocation> locations = region.locations;
  List<Widget> locationWidgets = [];
  for (GameLocation location in locations) {
    if (!location.unlocked) {
      locationWidgets.add(Image.asset(GameImageAsset.map_icon_question_mark.filename()));
    } else {
      // TODO
      locationWidgets.add(InkWell(
          onTap: () {
            print('> tapped: ' + location.name);
          },
          child: Image.asset(GameImageAsset.map_loc_hamlet.filename())  // TODO - set correct
        )
      );
    }
  }

  return Padding(
    padding: const EdgeInsets.only(left:80, top: 30, right: 50),
    child: GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      // Generate 100 widgets that display their index in the List.
      children:locationWidgets
    ),
  );
}

/*
Widget getMapPointOfInterest(BuildContext context, int index) {
  if (Random().nextInt(10) > 6) {
    return Image.asset(locationImage[index].filename());
  }
  return Image.asset(locationImage[index].filename());
//  return Image.asset(GameImageAsset.map_loc_marsh.filename());
}

 */