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
  List<Being> enemies = [];
  for (int i = 0; i < 5; i++) {
    enemies.add(Being(SpeciesType.ghost));
  }
/*
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
*/
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

  if(CurrentFight().selectedTarget != null && CurrentFight().selectedTarget!.isAlive()) {
    // Re-select target to enforce update of affected targets
    CurrentFight().selectAttackTarget(CurrentFight().selectedTarget!);
  }

  GameState().update();


}

// -------------------------------------------
// Selects the group of attacks to be used
// -------------------------------------------
selectAction(SelectedAction action) {
  CurrentFight().selectedAction = action;
  CurrentFight().selectedAttack = null;
  CurrentFight().selectedTarget = null;
  CurrentFight().deselectTargets();
  CurrentFight().deaffectTargets();
  CurrentFight().updateTargets();
  GameState().update();
}

// ---------------------------------------------------
// Select the actual attack (Hit, Swing, Fireball...)
// ---------------------------------------------------
void selectAttack(Attack attack) {
  CurrentFight().selectedAttack = attack;
  CurrentFight().deaffectTargets();
  if (CurrentFight().selectedTarget != null) {
    // Re-select target to enforce update of affected targets
    CurrentFight().selectAttackTarget(CurrentFight().selectedTarget!);
  }
  CurrentFight().updateTargets();
  GameState().update();
}

// *****************************************************************************
// Fight screen classes and widgets
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

        // ------------------- execute / flee buttons ----------
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListenableBuilder(
                  listenable: gameStateNotifier,
                  builder: (BuildContext context, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: getButtonsOrInfoLabel(context, gameStateNotifier),
                    );
                  },
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}

// -------------------------------------------------------------------------------------
// Creates RUN / FIGHT buttons
// -------------------------------------------------------------------------------------
List<Widget> getButtonsOrInfoLabel(BuildContext context, GameState gameStateNotifier) {
  List<Widget> widgets = [];
  if(CurrentFight().enemyTurn) {
    widgets.add(
        wrapButtonsOrInfoLabel(
            Center(child: Text('ENEMY TURN', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))
        )
    );
  } else {
    widgets.add(BaseButton.withImageAndText('RUN', GameIcon.flee.filename(), (context) => backToTitle(context)));
    widgets.add(getExecutionButton(context));
  }
  return widgets;
}

// --------------------------------------------------
// sized box wrapper for RUN / FIGHT buttons
// --------------------------------------------------
Widget wrapButtonsOrInfoLabel(Widget content) {
  return SizedBox(
    width: 240,
    child: Card(
      borderOnForeground: true,
      elevation: 5.0,
      child: Padding(
          padding: const EdgeInsets.all(16),
          child: content
      ),
    ),
  );
}

// --------------------------------------------------------------------
// Fight screen parts (enemy display, action buttons etc.)
// --------------------------------------------------------------------
Column fightScreen(BuildContext context, GameState gameStateNotifier) {

  return Column(
    children: [
      // ------------- enemies display panel -------------
      enemyDisplay(context),
      // ------------- turn order list widget ----------
      getTurnOrderList(),
      // ------------- player status widget ----------
      PlayerWidget(gameStateNotifier: GameState()),
      // ---------------- attack / magic selection panel ----------
      getActionButtonsOrEnemyActions(context, gameStateNotifier),
    ],
  );
}

// --------------------------------------------------------------------
// Renders the turn order list
// --------------------------------------------------------------------
Widget getTurnOrderList() {
  List<Widget> entries = [];

  entries.add(
    Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('TURN'),
          Text('ORDER')
        ],
      )
    )
  );

  BoxDecoration? border = BoxDecoration(
    border: Border.all(
        color: Colors.black54,
        width: 3,
    ),
  );
  for (Being entry in CurrentFight().turnOrder) {
    entries.add(getTurnEntry(entry, border));
    border = null;
  }
  return Row(
    children: entries,
  );
}

Widget getTurnEntry(Being being, BoxDecoration? border) {
  Widget imageWidget = being.species == SpeciesType.player ?
      GameNpcImages.player.getNpcImage() :
      GameMonsterImages.monster.getMonsterImage();
  return Container(
    decoration: border,
    margin: const EdgeInsets.all(8.0),
    child: imageWidget,
  );
}

// --------------------------------------------------------------------
// Renders either action buttons for attacks, magic etc. OR
// the actions of the enemies during their turn.
// --------------------------------------------------------------------
Widget getActionButtonsOrEnemyActions(BuildContext context, GameState gameStateNotifier) {
  return Expanded(
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
      ));
}

// ---------------------------------------------------
// Button which executes the selected action
// ---------------------------------------------------
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

// ---------------------------------------------------
// Create list of available attack options
// ---------------------------------------------------
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
