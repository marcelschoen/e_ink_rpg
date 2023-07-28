import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/game.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MonsterSlayerTitle());
}

void startPlay(BuildContext context) {
  print("*** PLAY ***");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Game()),
  );
}

class MonsterSlayerTitle extends StatelessWidget {
  const MonsterSlayerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TitleScaffold(),
    );
  }
}

class TitleScaffold extends StatelessWidget {

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));
    return WillPopScope(
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
                BaseButton.withImageOnly('assets/button-play.png', (context) => startPlay(context)),
                BaseButton.withImageOnly('assets/button-fight.png', (context) => startFight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
