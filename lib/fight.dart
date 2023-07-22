import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

import 'models/attack.dart';
import 'models/beings.dart';

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
      Expanded(
          child: PlayerWidget(),
      ),
      Expanded( // fill vertically
//        child: Placeholder()
          child: enemyDisplay(context),
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

// Enemies display
Widget enemyDisplay(BuildContext context) {

  List<Text> onScreen = [];
  for (Being enemy in CurrentFight().enemies()) {
    onScreen.add(Text('*** Enemy: ' + enemy.getSpecies() ));
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
              )
            ),
          ),
        ),
      ],
    );
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
    for (Being enemy in this._enemies) {
      attackTarget(enemy, Player(), Hit());
    }
  }

  /**
   * Performs a physical attack from one attacker on one target being.
   */
  void attackTarget(Being attacker, Being target, Attack attack) {
    int attackPower = attacker.strength();
    var damage = (attack.damagePerTargetFactor * attackPower) - target.defense();
    target.damageBy(damage as int);
  }
}