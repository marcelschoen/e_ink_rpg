import 'package:flutter/foundation.dart';

import 'models/attack.dart';
import 'models/beings.dart';

// ---------------------------------------------
// Singleton game state holder.
// ---------------------------------------------
class GameState with ChangeNotifier {

  // singleton instance
  static final GameState _instance = GameState._internal();

  final Player player = Player();

  GameState._internal() {
  }

  factory GameState() {
    return _instance;
  }

  update() {
    notifyListeners();
  }

  @override
  void dispose() {
    // NOTE: For some reason, someone is invoking this "dispose", which destroys
    // our singleton player state holder (which this method prevents).
    //super.dispose();
  }
}

// ---------------------------------------------
// Being state holder (per being instance)
// ---------------------------------------------
class BeingState with ChangeNotifier {

  final Being _being;
  int position = 0;
  bool selected = false;
  bool affected = false;

  BeingState(Being being) : _being = being {}

  Being being() {
    return _being;
  }

  update() {
    notifyListeners();
  }
}

enum SelectedAction {
  attack,
  magic,
  skill,
  spy
}

// ---------------------------------------------
// Singleton holder for state of current fight
// ---------------------------------------------
class CurrentFight {
  // instance variables
  List<Being> _enemies = [];
  bool fightRunning = false;
  SelectedAction selectedAction = SelectedAction.attack;
  Attack? selectedAttack = null;
  Being? selectedTarget = null;

  List<Being> turnOrder = [];

  bool enemyTurn = false;


  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  CurrentFight._internal() {}

  factory CurrentFight() {
    return _instance;
  }

  // ---------------------------------------------------------
  // Decides whos' turn it is next, based on regular turn
  // order, character speed attributes and other factors.
  // ---------------------------------------------------------
  void updateTurnList() {
    List<Being> beingsInTurn = [];
    beingsInTurn.add(Player());
    beingsInTurn.addAll(_enemies);
print("> beings in turn order: " + beingsInTurn.length.toString());
    turnOrder = [];

    const turnEntries = 7;
    const speedLimit = 5;

    // Always calculate 7 turns
    while (turnOrder.length < turnEntries) {
      print ("-------------> turn order result length: " + turnOrder.length.toString());
      for (Being being in beingsInTurn) {
        print ("> process being: " + being.getSpecies());
        bool found = false;
        while (!found && turnOrder.length < turnEntries) {
          being.speedCounter += being.speed;
          if (being.speedCounter > speedLimit) {
            print("========> Adding entry to turn order...");
            found = true;
            being.speedCounter -= speedLimit;
            turnOrder.add(being);
          }
        }
      }
    }
    print(">>>> TURN ORDER LENGTH: " + turnOrder.length.toString());
  }

  // ---------------------------------------------------------
  // Sets conditions to start fight against wave of enemies
  // ---------------------------------------------------------
  void begin(List<Being> enemies) {
    GameState().player.heal();
    setEnemies(enemies);
    selectedTarget = null;
    selectedAction = SelectedAction.attack;
    selectedAttack = Hit();

    updateTurnList();
  }

  // ---------------------------------------
  // Updates all enemy targets
  // ---------------------------------------
  void updateTargets() {
    for (Being being in _enemies) {
      being.state().update();
    }
  }

  // ---------------------------------------
  // Deselects all enemy targets
  // ---------------------------------------
  void deselectTargets() {
    for (Being being in _enemies) {
      being.state().selected = false;
    }
  }

  // ---------------------------------------
  // De-affects all enemy targets
  // ---------------------------------------
  void deaffectTargets() {
    for (Being being in _enemies) {
      being.state().affected = false;
    }
  }

  // ---------------------------------------
  // Selects an attack target
  // ---------------------------------------
  void selectAttackTarget(Being being) {

    if (!being.isAlive()) {
      print (">> target is already dead!");
      return;
    }

    // deselect all enemies first
    // then select new target
    deselectTargets();
    deaffectTargets();

    selectedTarget = being;
    selectedTarget!.state().selected = true;

    markAffectedTargets();

    updateTargets();
  }

  // ------------------------------------------------------------
  // marks all targets affected by the currently selected attack
  // ------------------------------------------------------------
  void markAffectedTargets() {
    if (selectedTarget != null && selectedAttack != null && selectedAttack!.affectedTargets > 1) {

      int startPosition = selectedTarget!.state().position - (selectedAttack!.affectedTargets ~/ 2);
      int endPosition = startPosition + selectedAttack!.affectedTargets - 1;
      if (startPosition < 0) {
        startPosition = 0;
      }
      if (endPosition >= enemies().length) {
        endPosition = enemies().length - 1;
      }

      print("> affected targets: " + selectedAttack!.affectedTargets.toString());
      print("> startPosition: " + startPosition.toString());
      print("> endPosition: " + endPosition.toString());

      for (int pos = startPosition; pos < endPosition + 1; pos ++) {
        Being enemy = enemies().elementAt(pos);
        print ("> enemy at pos " + pos.toString() + ": " + enemy.getSpecies());
        if (enemy.isAlive() && enemy != selectedTarget) {
          enemy.state().affected = true;
        }
      }
    }
  }

  void markTargetAsAffected(int position) {
    if (position < 0 || position >= enemies().length || position == selectedTarget!.state().position) {
      return;
    }
    enemies().elementAt(position).state().affected = true;
  }

  void setEnemies(List<Being> enemies) {
    this._enemies = enemies;
    // assign position to each enemy; this is necessary to be able
    // to determine who's affected by AoE attacks.
    for (int i = 0; i < this._enemies.length; i++) {
      this._enemies[i].state().position = i;
    }
  }

  List<Being> enemies() {
    return this._enemies;
  }

  bool finished() {
    if(!GameState().player.isAlive()) {
      return true;
    }

    for(Being enemy in this._enemies) {
      if(enemy.isAlive()) {
        return false;
      }
    }
    return true;
  }

  /**
   * Implements an actual physical attack on enemies
   */
  void attackEnemyPhysical(Being enemy, Attack attack) {
    attackTarget(GameState().player, enemy, attack);
  }

  void attackEnemiesWithMagic() {
    // TBD
  }

  /**
   * Enemies turn / they attack the player.
   */
  void enemiesAttackPlayer() {
    for (Being enemy in this._enemies) {
      attackTarget(enemy, GameState().player, Hit());
    }
    GameState().update();
  }
}
