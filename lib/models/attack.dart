// Abstract base class for physical attacks
import 'package:e_ink_rpg/state.dart';

import 'beings.dart';

abstract class Attack {

  double damagePerTargetFactor;
  final int affectedTargets;

  Attack(this.damagePerTargetFactor, this.affectedTargets) {
  }

  String name() {
    return runtimeType.toString();
  }
}

// Simple single-hit attack
class Hit extends Attack {
  Hit() : super(1.0, 1) ;
}

// jump-hit attack
class Jump extends Attack {
  Jump() : super(1.5, 1) ;
}

// multi-target attack
class Swing extends Attack {
  Swing() : super(0.9, 2) ;
}



/**
 * Performs a physical attack from one attacker on one target being.
 */
void attackTarget(Being attacker, Being target, Attack attack) {
  print("****> attacker " + attacker.getSpecies() + " attacks target: " + target.species.name() + " / attack: " + attack.name());
  double attackPower = attacker.strength().toDouble();
  print("> attack power: " + attackPower.toString());
  print("> attack damage per target factor: " + attack.damagePerTargetFactor.toString());
  double damage = attack.damagePerTargetFactor * attackPower;
  print("> damage: " + damage.toString());
  if (damage > 0) {
    damage -= target.defense();
  }
  print("> target health: " + target.health().toString());
  print("> final damage: " + damage.round().toString());
  target.damageBy(damage.round());
  if (!target.isAlive()) {
    CurrentFight().selectedTarget = null;
    GameState().update();
  }
}
