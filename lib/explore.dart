import 'package:e_ink_rpg/assets.dart';
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
                    children: getButtons(context),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

  }

  List<Widget> getButtons(BuildContext context) {
    List<Widget> buttons = [];
    buttons.add(BaseButton.textOnly('ABORT', (context) => switchToScreen(Game(), context) ));
    buttons.add(BaseButton.textOnly('CONTINUE', (context) => continueExploration(context) ));
    return buttons;
  }

  continueExploration(BuildContext context) {
    print ('> continue exploration <');
    GameState().currentlyExploring!.exploration!.nextStep();
    if (GameState().currentlyExploring!.exploration!.isComplete()) {
      unlockExploredLocation();
      switchToScreen(Game(), context);
    }
  }

  unlockExploredLocation() {
    GameLocation location = GameState().currentlyExploring!;
    location.unlocked = true;
    location.exploration = null;
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
            // ------------- exploration view panel -------------
            Expanded(
              child: Column(
                children: [
                  // 1st line of images
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage(currentStep.gameImageAssets[0].filename())),
                          getCenterImage(currentStep),
                          Image(image: AssetImage(currentStep.gameImageAssets[2].filename())),
                        ]),
                  ),
                  Expanded(child: Center(child: getLocationInfo(GameState().currentlyExploring!))),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: AssetImage(currentStep.gameImageAssets[3].filename())),
                          Image(image: AssetImage(currentStep.gameImageAssets[4].filename())),
                        ]),
                  ),
                  getExplorationProgressBar(exploration.completionPercentage()),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget getCenterImage(ExplorationStep currentStep) {
    if (currentStep.hasEnemies) {
      return GameMonsterImageAsset.monster.getMonsterImage();
    }
    return Image(image: AssetImage(currentStep.gameImageAssets[1].filename()));
  }

  Widget getLocationInfo(GameLocation location) {
    // TODO - VARIOUS DESCRIPTIONS
    // TODO - SHOW ENEMIES AND ATTACK OPTION
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text('Location: ' + location.name
          + ' A nice place, nothing special to be found here.', style: getTitleTextStyle(24)),
    );
  }

  Widget getExplorationProgressBar(double value) {
    print(">> exploration %: " + value.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text('Progress:', style: getTitleTextStyle(24)),
          hGap(10),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 20,
              color: Colors.black45,
              backgroundColor: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}