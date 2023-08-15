import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assets.dart';
import 'enemydisplay.dart';
import 'game.dart';
import 'models/action.dart';
import 'models/attack.dart';
import 'models/beings.dart';
import 'models/jobs.dart';
import 'models/magic.dart';

// *****************************************************************************
// Functions
// *****************************************************************************

// -----------------------------------------------
// Switches back to title screen
// -----------------------------------------------
void backToTitle(BuildContext context) {
  switchToScreen(MonsterSlayerTitle(), context);
}

void continueAfterFight(BuildContext context) {
  if (GameState().player.isAlive()) {
    if (GameState().selectedInJobs!.finished) {
      GameState().availableJobs.deselectAllJobs();
      GameState().selectedInJobs = null;
      switchToScreen(Game(), context);
    } else {
      startFight(context, GameState().selectedInJobs! );
    }
  } else {
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
void startFight(BuildContext context, Job job) {
  // ----------- TEMPORARY - INITIALIZE WAVE OF ENEMIES -----------------
  List<Being> enemies = [];

  JobStep step = job.currentStep!;
  enemies.addAll(step.attackers);

  /*
  GameState().turnOrderState.update();
  GameState().lowerButtonsState.update();
  GameState().optionButtonState.update();
  GameState().update();

  enemies.add(Being(SpeciesType.darkwizard));
  enemies.add(Being(SpeciesType.acidblob));
  enemies.add(Being(SpeciesType.angrywasp));
  enemies.add(Being(SpeciesType.tentacleeye));
  enemies.add(Being(SpeciesType.bloodbat));
*/
  // --------------------------------------------------------------------------

  CurrentFight().begin(enemies);
  switchToScreen(Fight(), context);
}

// -------------------------------------------
// Performs attacks by player and enemies
// -------------------------------------------
executeCombatTurn(BuildContext context) {
  if (CurrentFight().selectedAttack == null ||
      CurrentFight().selectedTarget == null) {
    return;
  }
  if (CurrentFight().selectedTarget != null) {
    attackTarget(GameState().player, CurrentFight().selectedTarget!,
        CurrentFight().selectedAttack!);
  }

  jumpToNewScreenAfterFight(context);

  if (CurrentFight().selectedTarget != null) {
    if (CurrentFight().selectedTarget!.isAlive()) {
      // Re-select target to enforce update of affected targets
      CurrentFight().selectAttackTarget(CurrentFight().selectedTarget!);
    }
  }

  if (!GameState().player.isAlive()) {
    CurrentFight().aborted;
  }
}

// -------------------------------------------
// Stop fighting and run...
// -------------------------------------------
void flee(BuildContext context) {
  CurrentFight().aborted = true;
  jumpToNewScreenAfterFight(context);
}

// -----------------------------------------------
// Continue to another screen once fight is over
// -----------------------------------------------
void jumpToNewScreenAfterFight(BuildContext context) {
  if (CurrentFight().finished()) {
    if (GameState().player.isAlive()) {
      GameState().selectedInJobs!.nextStep();
      if (GameState().selectedInJobs!.finished) {
        switchToScreen(FightOverScaffold('JOB COMPLETED!!'), context);
      } else {
        switchToScreen(FightOverScaffold('VICTORY!'), context);
      }
    } else {
      switchToScreen(FightOverScaffold('DEFEAT!'), context);
    }
  }
}

// -------------------------------------------
// Selects the group of attacks to be used
// -------------------------------------------
selectOptionGroup(SelectedOptionGroup optionGroup) {
  CurrentFight().selectedOptionGroup = optionGroup;
  CurrentFight().selectedAttack = null;
  CurrentFight().selectedAction = null;
  CurrentFight().selectedTarget = null;
  CurrentFight().deselectTargets();
  CurrentFight().deaffectTargets();
  CurrentFight().updateTargets();
  GameState().optionButtonState.update();
  GameState().hintState.update();
  GameState().lowerButtonsState.update();
}

// ---------------------------------------------------
// Select the special action (Spy etc.)
// ---------------------------------------------------
void selectAction(GameAction action) {
  CurrentFight().selectedAction = action;
  CurrentFight().selectedAttack = null;
  GameState().lowerButtonsState.update();
  GameState().hintState.update();
}

// ---------------------------------------------------
// Select the actual attack (Hit, Swing, Fireball...)
// ---------------------------------------------------
void selectAttack(Attack attack) {
  CurrentFight().selectedAction = null;
  CurrentFight().selectedAttack = attack;
  CurrentFight().deaffectTargets();
  if (CurrentFight().selectedTarget != null) {
    // Re-select target to enforce update of affected targets
    CurrentFight().selectAttackTarget(CurrentFight().selectedTarget!);
  }
  CurrentFight().updateTargets();
  GameState().hintState.update();
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
        child: FightScaffold(gameStateNotifier: GameState()));
  }
}

// -----------------------------------------------
// Fight
// -----------------------------------------------
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
      onWillPop: _onWillPop, // disable 'back' button
      child: Scaffold(
        appBar: getAppBar('!! Combat !!'),

        // ********** Actual combat screen part **********
        body: Center(
          child: fightScreen(context),
        ),

        // ------------------- execute / flee buttons ----------
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListenableBuilder(
                  listenable: GameState().lowerButtonsState,
                  builder: (BuildContext context, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          getButtonsOrInfoLabel(context),
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
List<Widget> getButtonsOrInfoLabel(BuildContext context) {
  List<Widget> widgets = [];
  if (CurrentFight().enemyTurn) {
    widgets.add(wrapButtonsOrInfoLabel(Center(
        child: Text('ENEMY TURN',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))));
  } else {
    widgets.add(BaseButton.withImageAndText(
        'RUN', GameIconAsset.flee.filename(), (context) => flee(context)));
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
      child: Padding(padding: const EdgeInsets.all(16), child: content),
    ),
  );
}

// --------------------------------------------------------------------
// Fight screen parts (enemy display, action buttons etc.)
// --------------------------------------------------------------------
Column fightScreen(BuildContext context) {
  return Column(
    children: [
      // ------------- player status widget ----------
      PlayerWidget(),
      // ------------- enemies display panel -------------
      enemyDisplay(context),
      // ------------- turn order list widget ----------
      getTurnOrderList(),
      // ---------------- attack / magic selection panel ----------
      getActionButtonsOrEnemyActions(context),
    ],
  );
}

// --------------------------------------------------------------------
// Renders the turn order list
// --------------------------------------------------------------------
Widget getTurnOrderList() {
  List<Widget> entries = [];

  entries.add(Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [Text('TURN'), Text('ORDER')],
      )));

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
  return ListenableBuilder(
    listenable: GameState().turnOrderState,
    builder: (BuildContext context, Widget? child) {
      return Row(
        children: entries,
      );
    },
  );
}

Widget getTurnEntry(Being being, BoxDecoration? border) {
  Widget imageWidget = being.species == SpeciesType.player
      ? GameNpcImageAsset.player.getNpcImage()
      : GameMonsterImageAsset.monster.getMonsterImage();
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
Widget getActionButtonsOrEnemyActions(BuildContext context) {
  return Expanded(
      // fill vertically
      child: Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            BaseButton.withImageAndText('Attack', GameIconAsset.attack.filename(),
                (context) => selectOptionGroup(SelectedOptionGroup.attack)),
            BaseButton.withImageAndText('Magic', GameIconAsset.magic.filename(),
                (context) => selectOptionGroup(SelectedOptionGroup.magic)),
            BaseButton.withImageAndText('Skill', GameIconAsset.skill.filename(),
                (context) => selectOptionGroup(SelectedOptionGroup.skill)),
            BaseButton.withImageAndText('Special', GameIconAsset.special.filename(),
                (context) => selectOptionGroup(SelectedOptionGroup.special)),
          ],
        ),
        ListenableBuilder(
          listenable: GameState().optionButtonState,
          builder: (BuildContext context, Widget? child) {
            return Expanded(
              child: Column(
                children: getActionOptions(),
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

  if (CurrentFight().selectedOptionGroup == SelectedOptionGroup.skill) {

  } else if (CurrentFight().selectedOptionGroup == SelectedOptionGroup.special) {
      print(">>>>>>> SPECIAL action selektiert");
      if (CurrentFight().selectedAction != null && CurrentFight().selectedAction!.runtimeType == Spy ) {
        BaseButton button = BaseButton.withImageAndText('LOOK', GameIconAsset.spy.filename(),
                (context) => CurrentFight().selectedAction!.perform() );
        if (CurrentFight().selectedTarget == null) {
          button.enabled = false;
        }
        return button;
      }
  }

  // attack and magic
  BaseButton button = BaseButton.withImageAndText('FIGHT',
      GameIconAsset.fight.filename(), (context) => executeCombatTurn(context));
  print("> execution button / selected target: " +
      CurrentFight().selectedTarget.toString());
  if (CurrentFight().selectedTarget == null ||
      CurrentFight().selectedAttack == null) {
    button.enabled = false;
  }
  return button;
}

// ---------------------------------------------------
// Create list of available attack options
// ---------------------------------------------------
List<Widget> getActionOptions() {
  List<Widget> options = [];
  if (CurrentFight().selectedOptionGroup == SelectedOptionGroup.magic) {
    for (Spell spell in GameState().player.availableSpells) {
      options.add(BaseButton.textOnly(spell.name(), (p0) { selectAttack(spell); }));
    }
  } else if (CurrentFight().selectedOptionGroup == SelectedOptionGroup.attack) {
    for (Attack attack in GameState().player.availableAttacks) {
      options.add(BaseButton.textOnly(attack.name(), (p0) { selectAttack(attack); }));
    }
  } else if (CurrentFight().selectedOptionGroup == SelectedOptionGroup.special) {
    options.add(BaseButton.textOnly('Spy', (p0) { selectAction(Spy()); }));
    options.add(BaseButton.textOnly('Steal', (p0) { print('> steal <'); }));
  }

  return options;
}

// *****************************************************************************
// Fight over screen (won / lost)
// *****************************************************************************

class FightOverScaffold extends StatelessWidget {

  final String appBarTitle;

  const FightOverScaffold(this.appBarTitle);

  Future<bool> _onWillPop() async {
    // disable "back" button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: getAppBar(appBarTitle),

        // ********** Actual combat screen part **********
        body: Center(
          child: Placeholder(),
        ),

        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseButton.withImageOnly('assets/button-back.png',
                    (context) => continueAfterFight(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
