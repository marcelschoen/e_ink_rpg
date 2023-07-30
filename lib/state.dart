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
  Attack selectedAttack = None();
  Being? selectedTarget = null;

  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  CurrentFight._internal() {}

  factory CurrentFight() {
    return _instance;
  }

  void setEnemies(List<Being> enemies) {
    this._enemies = enemies;
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
    print("---> enemies attack player <---");
    for (Being enemy in this._enemies) {
      attackTarget(enemy, GameState().player, Hit());
    }
    GameState().update();
  }
}
