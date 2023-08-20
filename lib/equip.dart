

import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';



// -----------------------------------------------------------------------------
// Equip screen
// -----------------------------------------------------------------------------
Widget getEquipScreen(BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Row(
    children: [
      Placeholder(),
      Expanded(

        child: Scrollbar(
          controller: scrollController,
          thickness: 20,
          isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().inventorySelectionState,
            builder: (BuildContext context, Widget? child) {
              return GridView.count(
                controller: scrollController,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: GameState().player.inventory.getEquipableItemWidgets()
              );
            },
          ),
        ),
      ),
    ],
  );
}
