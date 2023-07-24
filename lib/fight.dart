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

  print(">> created monster has strength: " + monsterOne.hasStat(StatType.strength).toString());
  print(">> created monster strength: " + monsterOne.stat(StatType.strength)!.value().toString());

  CurrentFight().setEnemies(enemies);
  CurrentFight().begin();

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
        create: (context) => GameState(),
        child: FightScaffold()
    );
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
      Expanded(
          child: PlayerWidget(gameStateNotifier: GameState()),
      ),
      Expanded( // fill vertically
//        child: Placeholder()
          child: enemyDisplay(context),
      ),
      Expanded( // fill vertically
          child: Row(
            children: [
              BaseButton.textOnly('FIGHT', (context) => executeCombatTurn()),

            ],
          )
      ),
      Expanded( // fill vertically
          child: Placeholder()
      ),
    ],
  );
}

executeCombatTurn() {
  CurrentFight().enemiesAttackPlayer();
  for (Being enemy in CurrentFight().enemies()) {
    CurrentFight().attackTarget(GameState().player, enemy, Hit());
  }
}

// Enemies display
Widget enemyDisplay(BuildContext context) {

  List<Text> onScreen = [];
  for (Being enemy in CurrentFight().enemies()) {
    onScreen.add(Text('*** Enemy: ' + enemy.getSpecies() ));
  }

  List<Widget> enemies = [];
  for (Being enemy in CurrentFight().enemies()) {
    enemies.add(EnemyWidget(monsterStateNotifier: enemy.state()));
  }

  return

    Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: enemies,
//                children: onScreen,
              )
            ),
          ),
        ),
      ],
    );
}

class EnemyWidget extends StatelessWidget {


  const EnemyWidget({super.key, required this.monsterStateNotifier});

  final MonsterState monsterStateNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: monsterStateNotifier,
      builder: (BuildContext context, Widget? child) {
        return
          Container(
            height: 64,
            foregroundDecoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
            ),
            child: Row(
              children: [
                Image(image: AssetImage('assets/monster/RPG_Monster_123-3.png')),
                Text(' HEALTH: ' + monsterStateNotifier.monster().health().toString() ),
              ],
            )
          );
      },
    );
  }
}


class CurrentFight {

  // instance variables
  List<Being> _enemies = [];
  bool fightRunning = false;

  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  CurrentFight._internal() {
  }

  factory CurrentFight() {
    return _instance;
  }

  void setEnemies(List<Being> enemies) {
    this._enemies = enemies;
  }

  List<Being> enemies() {
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

  /**
   * Implements an actual physical attack on enemies
   */
  void attackEnemyPhysical(Being enemy, Attack attack) {
    attackTarget(Player(), enemy, attack);
  }

  void attackEnemiesWithMagic() {
    // TBD
  }

  /**
   * Enemies turn / they attack the player.
   */
  void enemiesAttackPlayer() {
    print("---> enemies attack player <---");
    for (Being enemy in this._enemies) {
      attackTarget(enemy, GameState().player, Hit());
    }
    GameState().update();
  }

  /**
   * Performs a physical attack from one attacker on one target being.
   */
  void attackTarget(Being attacker, Being target, Attack attack) {
    print("------> attack target");
    int attackPower = attacker.strength();
    print("------> attacker strength: " + attackPower.toString());
    print("------> attack damage factor: " + attack.damagePerTargetFactor.toString());
    var damage = (attack.damagePerTargetFactor * attackPower) - target.defense();
    print("------> dish out damage: " + damage.round().toString());
    target.damageBy(damage.round());
  }
}