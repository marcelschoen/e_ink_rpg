import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assets.dart';
import 'models/attack.dart';
import 'models/beings.dart';
import 'models/magic.dart';

// *****************************************************************************
// Functions
// *****************************************************************************

// -----------------------------------------------
// Switches back to title screen
// -----------------------------------------------
void backToTitle(BuildContext context) {
  print("*** abort fight ***");
  switchToScreen(MonsterSlayerTitle(), context);
}

void continueAfterFight(BuildContext context) {
  print("*** continue ***");
  if(GameState().player.isAlive()) {
    print("*** start next fight ***");
    startFight(context);
  } else {
    print("*** back to title ***");
    switchToScreen(MonsterSlayerTitle(), context);
  }
}

// placeholder for not yet implemented buttons
void doNothing() {
  print("*** NO OPERATION / NOT IMPLEMENTED ***");
}

// -----------------------------------------------
// Switches to the fight screen and starts combat
// -----------------------------------------------
void startFight(BuildContext context) {
  print("*** START FIGHT ***");

  GameState().player.heal();
  print(">> player health: " + GameState().player.health().toString());

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

  switchToScreen(Fight(), context);
}

// -------------------------------------------
// Performs attacks by player and enemies
// -------------------------------------------
executeCombatTurn(BuildContext context) {
  CurrentFight().enemiesAttackPlayer();
  for (Being enemy in CurrentFight().enemies()) {
    CurrentFight().attackTarget(GameState().player, enemy, Hit());
  }
  print(">> player health: " + GameState().player.health().toString());
  if(CurrentFight().finished()) {
    print("*** FIGHT OVER ***");
    if(GameState().player.isAlive()) {
      print("*** PLAYER WON! ***");
      switchToScreen(FightOverScaffold(), context);
    } else {
      print("*** PLAYER LOST! ***");
      switchToScreen(FightOverScaffold(), context);
    }
  }
}

// *****************************************************************************
// Fight screen
// *****************************************************************************

// Main fight / combat screen
class Fight extends StatelessWidget {
  const Fight({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GameState(),
        child: FightScaffold(gameStateNotifier: GameState())
    );
  }
}

class FightScaffold extends StatelessWidget {
  const FightScaffold({super.key, required this.gameStateNotifier});

  final GameState gameStateNotifier;

  Future<bool> _onWillPop() async {
    // disable "back" button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('!! Combat !!'),
        ),

        // ********** Actual combat screen part **********
        body: Center(
          child: fightScreen(context, gameStateNotifier),
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
      ),
    );
  }
}

selectAction(SelectedAction action) {
  print(">> select action: " + action.toString());
  CurrentFight().selectedAction = action;
  GameState().update();
}

// Fight screen parts (enemy display, action buttons etc.)
Column fightScreen(BuildContext context, GameState gameStateNotifier) {

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
          BaseButton.withImageAndText('RUN', GameIcon.flee.filename(), (context) => executeCombatTurn(context)),
          BaseButton.withImageAndText('FIGHT', GameIcon.fight.filename(), (context) => executeCombatTurn(context)),
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
                    BaseButton.withImageAndText('Attack', GameIcon.attack.filename(), (context) => selectAction(SelectedAction.attack)),
                    BaseButton.withImageAndText('Magic', GameIcon.magic.filename(), (context) => selectAction(SelectedAction.magic)),
                    BaseButton.withImageAndText('Skill', GameIcon.skill.filename(), (context) => selectAction(SelectedAction.skill)),
                    BaseButton.withImageAndText('Spy', GameIcon.spy.filename(), (context) => selectAction(SelectedAction.spy)),
                  ],
                ),
                ListenableBuilder (
                  listenable: gameStateNotifier,

                  builder: (BuildContext context, Widget? child) {
                    return Expanded(
                      child: Column(
                        children:
                        getActionOptions(),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
    ],
  );
}

List<Widget> getActionOptions() {
  List<Widget> options = [ ];
  if(CurrentFight().selectedAction == SelectedAction.magic) {
    for (Spell spell in GameState().player.availableSpells) {
      options.add(BaseButton.textOnly(spell.name(), (p0) { }));
    }
  } else {
    for (Attack attack in GameState().player.availableAttacks) {
      options.add(BaseButton.textOnly(attack.name(), (p0) { }));
    }
  }

  return options;
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

  final BeingState monsterStateNotifier;

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
              Text(monsterStateNotifier.being().getSpecies()),
              getMonsterImage(monsterStateNotifier.being()),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: getMonsterLifebarIcon(monsterStateNotifier.being())
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
                          value: (monsterStateNotifier.being().health().toDouble() /
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
        image: AssetImage(GameIcon.heart.filename()));
  }
  return Image(
      height: 12,
      image: AssetImage(GameIcon.death.filename()));
}

Widget getMonsterImage(Being enemy) {
  if(enemy.isAlive()) {
    return Image(
        height: 92,
        image: AssetImage('assets/monster/RPG_Monster_123-3.png'));
  }
  return SizedBox(width: 90, height: 100,);
}


// *****************************************************************************
// Fight over screen (won / lost)
// *****************************************************************************


class FightOverScaffold extends StatelessWidget {
  const FightOverScaffold({super.key});

  Future<bool> _onWillPop() async {
    // disable "back" button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GameState().player.isAlive() ? Text('!! VICTORY !!') : Text('!! YOU LOST !!'),
        ),

        // ********** Actual combat screen part **********
        body: Center(
          child: Placeholder(),
        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseButton.withImageOnly(GameState().player.isAlive() ? 'assets/button-fight.png' : 'assets/button-back.png',
                        (context) => continueAfterFight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
