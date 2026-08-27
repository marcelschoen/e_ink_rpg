import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/saves.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(const MonsterSlayerTitle());
}

class MonsterSlayerTitle extends StatefulWidget {

  const MonsterSlayerTitle({super.key});

  static bool initialized = false;

  @override
  State<MonsterSlayerTitle> createState() => _MonsterSlayerTitleState();
}

class _MonsterSlayerTitleState extends State<MonsterSlayerTitle> {
  bool _assetsReady = false;

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  void initState() {
    super.initState();

    if (!MonsterSlayerTitle.initialized) {
      MonsterSlayerTitle.initialized = true;
      _loadInitialData();
    } else {
      // Assets were already loaded on a previous visit to this screen.
      _assetsReady = true;
    }
  }

  // ---------------------------------------------------------------------------
  // Loads all data needed before the player can start/continue a game.
  // Must complete before NEW GAME / CONTINUE / LOAD can be used, since
  // starting or loading a game depends on names and items being registered.
  // ---------------------------------------------------------------------------
  Future<void> _loadInitialData() async {
    await NameHandler.allNames.loadAssets();
    await NameHandler.fantasyNames.loadAssets();
    await NameHandler.elvenNames.loadAssets();
    await NameHandler.romanNames.loadAssets();
    await NameHandler.goblinNames.loadAssets();

    await ItemRegistry.loadJson();

    try {
      // Save data is optional (e.g. first launch) - don't let a missing or
      // unreadable save block the player from starting a new game.
      await GameSaveHandler.updateListOfSaves();
      await GameSaveHandler.loadLastUsedSave();
    } catch (_) {}

    setState(() {
      _assetsReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Image titleImage = const Image(image: AssetImage('assets/monster-slayer-logo.png'));
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
    if (!_assetsReady) {
      return [getTitleAppBarTitle('Loading...', true)];
    }

    List<Widget> buttons = [];
    buttons.add(BaseButton.textOnly('NEW GAME', (context) => beginGame(context, true)));
    if (GameState().selectedGameSave != null) {
      buttons.add(BaseButton.textOnly('CONTINUE', (context) => beginGame(context, false)));
    }

    if (GameSaveHandler.currentSaves.isNotEmpty) {
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
  switchToScreen(const Game(), context);
}
