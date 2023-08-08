import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(MonsterSlayerTitle());
}

class MonsterSlayerTitle extends StatelessWidget {

  MonsterSlayerTitle({super.key});

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: getAppBar('Play4Ever Games Presents'),
          body: Center(
            child: titleImage,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseButton.withImageOnly('assets/button-play.png', (context) => beingGame(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

beingGame(BuildContext context) {

  // TEMPORARY
  GameState().beginGame();

  switchToScreen(Game(), context);
}
