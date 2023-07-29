import 'package:flutter/foundation.dart';

import 'models/attack.dart';
import 'models/beings.dart';

/**
 * Singleton game state holder.
 */
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
    print("******************** DISPOSE GAME STATE ********************");
    // NOTE: For some reason, someone is invoking this "dispose", which destroys
    // our singleton player state holder.
    //super.dispose();
  }
}



/**
 * Singleton game state holder.
 */
class MonsterState with ChangeNotifier {

  final Being _monster;

  MonsterState(Being monster) : _monster = monster {}

  Being monster() {
    return _monster;
  }

  update() {
    notifyListeners();
  }
}



class CurrentFight {
  // instance variables
  List<Being> _enemies = [];
  bool fightRunning = false;

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

  /**
   * Performs a physical attack from one attacker on one target being.
   */
  void attackTarget(Being attacker, Being target, Attack attack) {
    print("------> attack target");
    int attackPower = attacker.strength();
    print("------> attacker strength: " + attackPower.toString());
    print("------> attack damage factor: " +
        attack.damagePerTargetFactor.toString());
    var damage =
        (attack.damagePerTargetFactor * attackPower) - target.defense();
    print("------> dish out damage: " + damage.round().toString());
    target.damageBy(damage.round());
  }
}
