

import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------
Widget getJobsScreen(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          thickness: 20,
          isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().inventorySelectionState,
            builder: (BuildContext context, Widget? child) {
              return GridView.count(
                childAspectRatio: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: GameState().player.inventory.getItemWidgets(context)
              );
            },
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid,
                    width: 4
                ),
              ),
              child: SizedBox(
                height: 180,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black12,
                        child: Container(
                          margin: EdgeInsets.only(top: 4, bottom: 0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Details', style: getTitleTextStyle(18)),
                            ],
                          ),
                        ),
                      ),
                      jobDetails(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(children: [
            BaseButton.textOnlyWithSizes("Use", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Combine", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard all", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
          ],)
        ],
      )
    ],
  );
}


// ---------------------------------------------------------------------
// The box with the details of the selected item stack
// ---------------------------------------------------------------------
Widget jobDetails() {
  return Expanded(
    child: Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(5),
      child: ListenableBuilder(
        listenable: GameState().inventorySelectionState,
        builder: (BuildContext context, Widget? child) {
          return Row(
          );
        },
      ),
    ),
  );
}

