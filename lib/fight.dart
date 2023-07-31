import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assets.dart';
import 'enemydisplay.dart';
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
  // ----------- TEMPORARY - INITIALIZE WAVE OF ENEMIES -----------------
  Being monsterOne = Being(SpeciesType.ghost);
  Being monsterTwo = Being(SpeciesType.skeleton);

  monsterOne.stat(StatType.health)!.setMaxValueTo(30);
  monsterOne.heal();

  List<Being> enemies = [];
  enemies.add(monsterTwo);
  enemies.add(monsterOne);

  print(">> created monster has strength: " +
      monsterOne.hasStat(StatType.strength).toString());
  print(">> created monster strength: " +
      monsterOne.stat(StatType.strength)!.value().toString());

  // --------------------------------------------------------------------------

  CurrentFight().begin(enemies);
  switchToScreen(Fight(), context);
}

// -------------------------------------------
// Performs attacks by player and enemies
// -------------------------------------------
executeCombatTurn(BuildContext context) {

//  CurrentFight().enemiesAttackPlayer();

  if (CurrentFight().selectedAttack == null || CurrentFight().selectedTarget == null) {
    return;
  }

  if (CurrentFight().selectedTarget != null) {
    attackTarget(GameState().player, CurrentFight().selectedTarget!, CurrentFight().selectedAttack!);
  }
/*
  for (Being enemy in CurrentFight().enemies()) {
    if (enemy.isAlive()) {
      attackTarget(GameState().player, enemy, CurrentFight().selectedAttack!);
    }
  }
*/
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

  CurrentFight().selectedTarget = null;
  CurrentFight().deselectTargets();
  CurrentFight().updateTargets();
  GameState().update();
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

// -------------------------------------------
// Selects the group of attacks to be used
// -------------------------------------------
selectAction(SelectedAction action) {
  CurrentFight().selectedAction = action;
  CurrentFight().deaffectTargets();
  CurrentFight().updateTargets();
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
      ListenableBuilder(
        listenable: gameStateNotifier,
        builder: (BuildContext context, Widget? child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImageAndText('RUN', GameIcon.flee.filename(), (context) => executeCombatTurn(context)),
              getExecutionButton(context),
            ],
          );
        },
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

Widget getExecutionButton(BuildContext context) {
  BaseButton button = BaseButton.withImageAndText('FIGHT', GameIcon.fight.filename(), (context) => executeCombatTurn(context));
  if (CurrentFight().selectedAction == SelectedAction.spy) {
    button = BaseButton.withImageAndText('LOOK', GameIcon.fight.filename(), (context) => executeCombatTurn(context));
//  } else if (CurrentFight().selectedAction == SelectedAction.skill) {
//    return BaseButton.withImageAndText('LOOK', GameIcon.fight.filename(), (context) => executeCombatTurn(context));
  }

  print("> execution button / selected target: " + CurrentFight().selectedTarget.toString());
  if (CurrentFight().selectedTarget == null || CurrentFight().selectedAttack == null) {
    button.enabled = false;
  }

  return button;
}

List<Widget> getActionOptions() {
  List<Widget> options = [ ];
  if(CurrentFight().selectedAction == SelectedAction.magic) {
    for (Spell spell in GameState().player.availableSpells) {
      options.add(BaseButton.textOnly(spell.name(), (p0) { selectAttack(spell); }));
    }
  } else if(CurrentFight().selectedAction == SelectedAction.attack) {
    for (Attack attack in GameState().player.availableAttacks) {
      options.add(BaseButton.textOnly(attack.name(), (p0) { selectAttack(attack); }));
    }
  }

  return options;
}

void selectAttack(Attack attack) {
  CurrentFight().selectedAttack = attack;
  CurrentFight().deaffectTargets();
  CurrentFight().updateTargets();
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
