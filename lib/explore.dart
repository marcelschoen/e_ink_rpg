import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/location.dart';


// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
beginExploring(GameLocation location, BuildContext context) {
  GameState().currentlyExploring = location;
  GameState().setScreenType(ScreenType.exploration);
  switchToScreen(Exploration(), context);
}

// -----------------------------------------------------------------------------
// Shows the exploration screen(s)
// -----------------------------------------------------------------------------
class Exploration extends StatelessWidget {

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: getAppBar('EXPLORING...'),
          body: Center(
            child: explorationScreen(context),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: ListenableBuilder(
                listenable: GameState().titleState,
                builder: (BuildContext context, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getButtons(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

  }

  List<Widget> getButtons() {
    List<Widget> buttons = [];
    buttons.add(BaseButton.textOnly('ABORT', (context) => print('* abort ') ));
    buttons.add(BaseButton.textOnly('EXPLORE', (context) => print('* abort ') ));
    return buttons;
  }

  continueExploration() {
    int percentageExplored = 7 + GameState().gameRandom.nextInt(10);
    GameState().currentlyExploring!.exploredPercentage += percentageExplored;
    if (GameState().gameRandom.nextInt(10) > 7) {
      print ('>> FIGHT <<');
    } else {
      print ('>> more expored <<');
    }
  }

  // --------------------------------------------------------------------
  // Fight screen parts (enemy display, action buttons etc.)
  // --------------------------------------------------------------------
  Column explorationScreen(BuildContext context) {
    return Column(
      children: [
        // ------------- player status widget ----------
        // PlayerWidget(),
        getPartyStatusBar(),
        // ------------- enemies display panel -------------
        Placeholder()
      ],
    );
  }
}