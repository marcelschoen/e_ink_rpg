
// ---------------------------------------------
// Singleton holder for state of current fight
// ---------------------------------------------
import 'package:e_ink_rpg/models/action.dart';
import 'package:e_ink_rpg/models/attack.dart';
import 'package:e_ink_rpg/models/attribute.dart';
import 'package:e_ink_rpg/models/beings.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';

class CurrentCombat {
  // instance variables
  List<Being> _enemies = [];
  SelectedOptionGroup selectedOptionGroup = SelectedOptionGroup.attack;
  GameAction? selectedAction = null;
  Attack? selectedAttack = null;
  Being? selectedTarget = null;
  bool aborted = false;

  List<Being> turnOrder = [];

  bool enemyTurn = false;


  // singleton instance
  static final CurrentCombat _instance = CurrentCombat._internal();

  CurrentCombat._internal() {}

  factory CurrentCombat() {
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
    turnOrder = [];

    const turnEntries = 7;
    const speedLimit = 5;

    // Always calculate 7 turns
    while (turnOrder.length < turnEntries) {
      for (Being being in beingsInTurn) {
        bool found = false;
        while (!found && turnOrder.length < turnEntries) {
          being.increaseAttrValueBy(AttributeType.speedCounter, being.attrValue(AttributeType.speed));
          if (being.attrValue(AttributeType.speedCounter) > speedLimit) {
            found = true;
            being.increaseAttrValueBy(AttributeType.speedCounter, speedLimit * -1);
            turnOrder.add(being);
          }
        }
      }
    }

    print(">>>> TURN ORDER LENGTH: " + turnOrder.length.toString());
    int i = 0;
    for (Being being in turnOrder) {
      print ('>> Being turn' + i.toString() + ': ' + being.species.name());
      i ++;
    }

    GameState().turnOrderState.update();
  }

  // ---------------------------------------------------------
  // Sets conditions to start fight against wave of enemies
  // ---------------------------------------------------------
  void begin(List<Being> enemies) {
    GameState().player.heal();
    GameState().player.restoreStat(StatType.mana);
    setEnemies(enemies);
    aborted = false;
    selectedTarget = null;
    selectedOptionGroup = SelectedOptionGroup.attack;

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
    GameState().hintState.update();
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
    if(!GameState().player.isAlive() || aborted) {
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
