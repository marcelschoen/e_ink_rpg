import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'game.dart';
import 'models/exploration.dart';
import 'models/location.dart';


// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
beginExploring(GameLocation location, BuildContext context) {
  GameState().currentlyExploring = location;
  GameState().currentlyExploring!.startExploration();
  GameState().setScreenType(ScreenType.exploration);
  switchToScreen(ExplorationWidget(), context);
}

// -----------------------------------------------------------------------------
// Shows the exploration screen(s)
// -----------------------------------------------------------------------------
class ExplorationWidget extends StatelessWidget {

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
                listenable: GameState().explorationState,
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
    buttons.add(BaseButton.textOnly('ABORT', (context) => switchToScreen(Game(), context) ));
    buttons.add(BaseButton.textOnly('CONTINUE', (context) => continueExploration() ));
    return buttons;
  }

  continueExploration() {
    print ('> continue exploration <');
    GameState().currentlyExploring!.exploration!.nextStep();
  }



  // --------------------------------------------------------------------
  // Fight screen parts (enemy display, action buttons etc.)
  // --------------------------------------------------------------------
  Widget explorationScreen(BuildContext context) {

    return ListenableBuilder(
      listenable: GameState().explorationState,
      builder: (BuildContext context, Widget? child) {
        Exploration exploration = GameState().currentlyExploring!.exploration!;
        ExplorationStep currentStep = exploration.currentStep();
        return Column(
          children: [
            // ------------- player status widget ----------
            // PlayerWidget(),
            getPartyStatusBar(),
            // ------------- enemies display panel -------------
            Expanded(
              child: Column(

                children: [
                  // 1st line of images
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage(currentStep.gameImageAssets[0].filename())),
                          Image(image: AssetImage(currentStep.gameImageAssets[0].filename())),
                          Image(image: AssetImage(currentStep.gameImageAssets[0].filename())),
                        ]),
                  ),
                  Expanded(child: Container()),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage(currentStep.gameImageAssets[3].filename())),
                          Image(image: AssetImage(currentStep.gameImageAssets[4].filename())),
                        ]),
                  ),
                ],),
            )
          ],
        );
      },
    );
  }
}