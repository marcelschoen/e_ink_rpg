import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/saves.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(MonsterSlayerTitle());
}

class MonsterSlayerTitle extends StatefulWidget {

  MonsterSlayerTitle({super.key});

  static bool initialized = false;

  @override
  State<MonsterSlayerTitle> createState() => _MonsterSlayerTitleState();
}

class _MonsterSlayerTitleState extends State<MonsterSlayerTitle> {
  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  void initState() {
    super.initState();

    if (!MonsterSlayerTitle.initialized) {
      NameHandler.allNames.loadAssets();
      NameHandler.fantasyNames.loadAssets();
      NameHandler.elvenNames.loadAssets();
      NameHandler.romanNames.loadAssets();
      NameHandler.goblinNames.loadAssets();

      ItemRegistry.loadJson();

      GameSaveHandler.updateListOfSaves();

      GameSaveHandler.loadLastUsedSave();
    }

    MonsterSlayerTitle.initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: getTitleAppBar('Play4Ever Games'),
          body: Center(
            child: FittedBox(child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: titleImage,
            )),
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
    buttons.add(BaseButton.textOnly('NEW GAME', (context) => beginGame(context, true)));
    if (GameState().selectedGameSave != null) {
      buttons.add(BaseButton.textOnly('CONTINUE', (context) => beginGame(context, false)));
    }

    if (!GameSaveHandler.currentSaves.isEmpty) {
      buttons.add(BaseButton.textOnly('LOAD', (context) => switchToScreen(LoadGame(), context)));
    }

    return buttons;
  }

}



// -----------------------------------------------------------------------------
// App bar for screen with title adapted to game state
// -----------------------------------------------------------------------------
getTitleAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    // disable back button
    title: getTitleAppBarTitle(title, false),
    titleTextStyle: getTitleTextStyle(24),
    centerTitle: true,
  );
}

Widget getTitleAppBarTitle(String title, bool centered) {
  Alignment alignment = Alignment.centerLeft;
  if (centered) {
    alignment = Alignment.center;
  }
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    getOutlinedText(title, 32, 2, Colors.black87, Colors.white),
  ]);
}

// -----------------------------------------------------------------------------
/// Begin / continue game
// -----------------------------------------------------------------------------
beginGame(BuildContext context, bool startNewGame) {
  if (startNewGame) {
    print ('*************** START NEW GAME **********************');
    GameState().beginNewGame();
  } else {
    print ('*************** CONTINUE GAME **********************');
    GameSaveHandler.loadGameState(GameState().selectedGameSave!);
  }
  switchToScreen(Game(), context);
}
