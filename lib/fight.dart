import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/attack.dart';
import 'models/beings.dart';

// *****************************************************************************
// Functions
// *****************************************************************************

// Switches back to title screen
void backToTitle(BuildContext context) {
  print("*** abort fight ***");
  Navigator.pop(context);
}

void startFight(BuildContext context) {
  print("*** START FIGHT ***");

  Being monsterOne = Being(SpeciesType.ghost);
  Being monsterTwo = Being(SpeciesType.skeleton);
  List<Being> enemies = [];
  enemies.add(monsterTwo);
  enemies.add(monsterOne);

  print(">> created monster has strength: " +
      monsterOne.hasStat(StatType.strength).toString());
  print(">> created monster strength: " +
      monsterOne.stat(StatType.strength)!.value().toString());

  CurrentFight().setEnemies(enemies);

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Fight()),
  );
}

// *****************************************************************************
// Classes
// *****************************************************************************

// Main fight / combat screen
class Fight extends StatelessWidget {
  const Fight({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GameState(), child: FightScaffold());
  }
}

class FightScaffold extends StatelessWidget {
  const FightScaffold({super.key});

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
              BaseButton.withImageOnly('assets/button-back.png',
                  (context) => backToTitle(context)),
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
      // ------------- player status widget ----------
      PlayerWidget(gameStateNotifier: GameState()),
      // ------------- enemies display panel -------------
      enemyDisplay(context),
      // ------------------- execute / flee buttons ----------
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BaseButton.withImageAndText('RUN', 'assets/icons/run.png', (context) => executeCombatTurn()),
          BaseButton.withImageAndText('FIGHT', 'assets/icons/fight.png', (context) => executeCombatTurn()),
        ],
      ),
      // ---------------- attack / magic selection panel ----------
      Expanded(
          // fill vertically
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    BaseButton.withImageAndText('Attack', 'assets/icons/attack.png', (context) => doNothing()),
                    BaseButton.withImageAndText('Magic', 'assets/icons/magic.png', (context) => doNothing()),
                    BaseButton.withImageAndText('Skill', 'assets/icons/skill.png', (context) => doNothing()),
                    BaseButton.textOnly('Spy', (context) => doNothing()),
                  ],
                ),
                Column(
                  children: [

                  ],
                ),
              ],
            ),
          )),
    ],
  );
}

doNothing() {
  print("****** DO NOTHING ******");
}

executeCombatTurn() {
//  CurrentFight().enemiesAttackPlayer();
  for (Being enemy in CurrentFight().enemies()) {
    CurrentFight().attackTarget(GameState().player, enemy, Hit());
  }
  if(CurrentFight().finished()) {
    print("*** FIGHT OVER ***");
    if(Player().isAlive()) {
      print("*** PLAYER WON! ***");
    } else {
      print("*** PLAYER LOST! ***");
    }

  }
}

// ----------------------------------------------------
// Enemies display
// ----------------------------------------------------
Widget enemyDisplay(BuildContext context) {
  List<Widget> enemies = [];
  for (Being enemy in CurrentFight().enemies()) {
    enemies.add(EnemyWidget(monsterStateNotifier: enemy.state()));
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
        child: Row(
      children: enemies,
    )),
  );
}

// -------------------------------------
// Widget for a single enemy
// -------------------------------------
class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key, required this.monsterStateNotifier});

  final MonsterState monsterStateNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: monsterStateNotifier,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            foregroundDecoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: Column(children: [
              Text(monsterStateNotifier.monster().getSpecies()),
              getMonsterImage(monsterStateNotifier.monster()),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: getMonsterLifebarIcon(monsterStateNotifier.monster())
                    /*
                    Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 16.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),*/
                  ),
                  SizedBox(
                      width: 60,
                      child: LinearProgressIndicator(
                          value: (monsterStateNotifier.monster().health().toDouble() /
                              100),
                          minHeight: 10,
                          color: Colors.black45,
                          backgroundColor: Colors.black12,
                          valueColor: AlwaysStoppedAnimation(Colors.black54))),
                ],
              ),
 //           Text(' HEALTH: ' +
 //               monsterStateNotifier.monster().health().toString()),
            ]),
          ),
        );
      },
    );
  }
}

Widget getMonsterLifebarIcon(Being enemy) {
  if(enemy.isAlive()) {
    return Image(
        height: 12,
        image: AssetImage('assets/icons/heart.png'));
  }
  return Image(
      height: 12,
      image: AssetImage('assets/icons/skull.png'));
}

Widget getMonsterImage(Being enemy) {
  if(enemy.isAlive()) {
    return Image(
        height: 92,
        image: AssetImage('assets/monster/RPG_Monster_123-3.png'));
  }
  return SizedBox(width: 90, height: 100,);
}
