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
          appBar: getTitleAppBar('Play4Ever Games Presents'),
          body: Center(
            child: titleImage,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseButton.textOnly('CONTINUE', (context) => beginGame(context)),  // TODO - ONLY AVAILABLE IF CURRENT GAME EXISTS
                  BaseButton.textOnly('LOAD', (context) => loadSave(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
    getOutlinedText(title, 36, 3, Colors.black87, Colors.white),
  ]);
}

// -----------------------------------------------------------------------------
/// Begin / continue game
// -----------------------------------------------------------------------------
beginGame(BuildContext context) {

  print ('*************** BEGIN GAME **********************');

  // TEMPORARY
  GameState().beginGame();

  switchToScreen(Game(), context);
}

// -----------------------------------------------------------------------------
// Load a game save
// -----------------------------------------------------------------------------
loadSave(BuildContext context) {

  print ('*************** LOAD SAVE **********************');

  switchToScreen(GameSaves(), context);
}
