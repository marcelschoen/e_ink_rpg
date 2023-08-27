import 'package:e_ink_rpg/names.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(MonsterSlayerTitle());
}

class MonsterSlayerTitle extends StatefulWidget {

  MonsterSlayerTitle({super.key});

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
    NameHandler.allNames.loadAssets();
    NameHandler.fantasyNames.loadAssets();
    NameHandler.elvenNames.loadAssets();
    NameHandler.romanNames.loadAssets();
    NameHandler.goblinNames.loadAssets();
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
                  BaseButton.withImageOnly('assets/button-play.png', (context) => beginGame(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// App bar for screen with title adapted to game state
// ----------------------------------------------------------
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

beginGame(BuildContext context) {

  print ('*************** BEGIN GAME **********************');

  // TEMPORARY
  GameState().beginGame();

  switchToScreen(Game(), context);
}
