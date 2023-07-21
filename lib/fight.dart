import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

import 'models/beings.dart';

// Switches back to title screen
void backToTitle(BuildContext context) {
  print("*** abort fight ***");
  Navigator.pop(context);
}

void startFight(BuildContext context) {
  print("*** START FIGHT ***");

  Monster monsterOne = Monster(MonsterType.ghost);
  Monster monsterTwo = Monster(MonsterType.skeleton);
  List<Monster> enemies = [];
  enemies.add(monsterTwo);
  enemies.add(monsterOne);

  CurrentFight().setEnemies(enemies);
  CurrentFight().begin();

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Fight()),
  );
}

// Main fight / combat screen
class Fight extends StatelessWidget {
  const Fight({super.key});

  @override
  Widget build(BuildContext context) {
    return FightScaffold();
  }
}

class FightScaffold extends StatefulWidget {
  const FightScaffold({super.key});

  @override
  State<FightScaffold> createState() => _FightScaffoldState();
}

class _FightScaffoldState extends State<FightScaffold> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fight Screen'),
      ),

      // ********** Actual combat screen part **********
      body: Center(
        child: fightScreen(context),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImage('BACK', 'assets/button-back.png', (context) => backToTitle(context)),
            ],
          ),
        ),
      ),
    );
  }
}

// Fight screen parts (enemy display, action buttons etc.)
Column fightScreen(BuildContext context) {
  return Column(
    children: [
      Expanded( // fill vertically
//        child: Placeholder()
          child: monsterDisplay(context),
      ),
      Expanded( // fill vertically
          child: Row(
            children: [
              BaseButton.textOnly('FIGHT', (context) => backToTitle(context)),

            ],
          )
      ),
      Expanded( // fill vertically
          child: Placeholder()
      ),
    ],
  );
}

// Monster display
Widget monsterDisplay(BuildContext context) {

  List<Text> onScreen = [];
  for (Monster enemy in CurrentFight().enemies()) {
    onScreen.add(Text('*** Monster: ' + enemy.getSpecies() ));
  }

  return

    Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: onScreen,
                /*
                [
                  Text("*** Monster ***"),
                  Text("*** Monster ***"),
                  Text("*** Monster ***"),
                  Text("*** Monster ***"),
                ],
                 */
              )
            ),
          ),
        ),
      ],
    );
}

class CurrentFight {

  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  // instance variables
  List<Monster> _enemies = [];
  bool fightRunning = false;

  CurrentFight._internal() {
  }

  factory CurrentFight() {
    return _instance;
  }

  void setEnemies(List<Monster> enemies) {
    this._enemies = enemies;
  }

  List<Monster> enemies() {
    return this._enemies;
  }

  void begin() {
    fightRunning = true;
  }

  void stop() {
    fightRunning = false;
  }

  bool running() {
    return fightRunning;
  }

  bool finished() {
    return !fightRunning;
  }


}