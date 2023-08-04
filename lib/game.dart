import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

// Switches back to title screen
void backToTitle(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MonsterSlayerTitle()),
  );
}

// Main game screen
class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: Placeholder(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImageOnly('assets/button-back.png', (context) => backToTitle(context)),
              BaseButton.withImageOnly('assets/button-fight.png', (context) => startFight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
