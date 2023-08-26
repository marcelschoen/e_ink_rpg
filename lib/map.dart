import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';


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
                image: AssetImage(GameImageAsset.map_paper_background.filename()),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 20),
          child: getOutlinedText('Hello there', 24, 1, Colors.black, Colors.white),
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