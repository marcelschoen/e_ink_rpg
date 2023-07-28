import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MonsterSlayerTitle());
}
/*
void startPlay(BuildContext context) {
  print("*** PLAY ***");
  switchToScreen(Game(), context);
}
 */

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Monster Slayer'),
          ),
          body: Center(
            child: titleImage,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
//                BaseButton.withImageOnly('assets/button-play.png', (context) => startPlay(context)),
                  BaseButton.withImageOnly('assets/button-fight.png', (context) => startFight(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
