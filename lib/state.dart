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

  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  CurrentFight._internal() {}

  factory CurrentFight() {
    return _instance;
  }

  // ---------------------------------------------------------
  // Sets conditions to start fight against wave of enemies
  // ---------------------------------------------------------
  void begin(List<Being> enemies) {
    GameState().player.heal();
    CurrentFight().setEnemies(enemies);
    CurrentFight().selectedTarget = null;
    CurrentFight().selectedAction = SelectedAction.attack;
    CurrentFight().selectedAttack = Hit();
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
  // Selects an attack target
  // ---------------------------------------
  void selectAttackTarget(Being being) {
    print ("---------------- SELECT ATTACK TARGET --------------");
    // deselect all enemies first
    // then select new target
    deselectTargets();

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
      print("mark affected targets: " + selectedAttack!.affectedTargets.toString());
      int halfAffected = selectedAttack!.affectedTargets ~/ 2;
      print("half affected: " + halfAffected.toString());
      int startPosition = selectedTarget!.state().position - halfAffected;
      print("start position: " + startPosition.toString());
      if (startPosition < 0) {
        startPosition = 0;
      }
      int endPosition = selectedAttack!.affectedTargets - 1;
      print("end position: " + endPosition.toString());

      for (int pos = startPosition; pos < endPosition + 1; pos ++) {
        print("> set to affected: " + pos.toString());
        enemies().elementAt(pos).state().affected = true;
      }
    }
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
