import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

List<GameImageAsset> locationImage = [
  GameImageAsset.map_icon_mountain_1,
  GameImageAsset.map_icon_mountain_2,
  GameImageAsset.map_icon_mountain_3,
  GameImageAsset.map_icon_mountain_4,
  GameImageAsset.map_icon_mountain_5,
  GameImageAsset.map_icon_mountain_6,
  GameImageAsset.map_icon_mountain_large_1,
  GameImageAsset.map_icon_mountain_large_2,
  GameImageAsset.map_icon_mountain_large_3,
  GameImageAsset.map_icon_mountain_large_4,
  GameImageAsset.map_icon_oasis,
  GameImageAsset.map_icon_mountain_peak_1,
  GameImageAsset.map_icon_mountain_peak_2,
  GameImageAsset.map_icon_pine_tree_1,
  GameImageAsset.map_icon_pine_tree_2,
  GameImageAsset.map_icon_pine_tree_3,
  GameImageAsset.map_icon_pine_tree_4,
  GameImageAsset.map_icon_pine_tree_5,
  GameImageAsset.map_icon_pine_tree_6,
  GameImageAsset.map_icon_ridge,
  GameImageAsset.map_icon_ruin_large,
  GameImageAsset.map_icon_ruin_small,
  GameImageAsset.map_icon_square_tower,
  GameImageAsset.map_icon_standing_stones,
  GameImageAsset.map_icon_mesa_1,
  GameImageAsset.map_icon_mesa_2,
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
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 30),
        child: getOutlinedText('Region: ' + NameHandler.allNames.compose(3), 24, 1, Colors.black, Colors.white),
      ),
      Expanded(child: getMapPointsOfInterest(context)),
    ],
  );
}

Widget getMapPointsOfInterest(BuildContext context) {

  return Padding(
    padding: const EdgeInsets.only(left:80, top: 30, right: 50),
    child: GridView.count(
      crossAxisCount: 5,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      // Generate 100 widgets that display their index in the List.
      children: List.generate(25, (index) {
        return getMapPointOfInterest(context, index);
//        return getCardWithRoundedBorder(getMapPointOfInterest(context));
/*
        return Text('$index',
          style: Theme.of(context).textTheme.headlineSmall,
        );
*/
      }),
    ),
  );
}

Widget getMapPointOfInterest(BuildContext context, int index) {
  return Image.asset(locationImage[index].filename());
}