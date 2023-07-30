// Abstract base class for physical attacks
import 'beings.dart';

abstract class Attack {

  double damagePerTargetFactor = 0.0;

  Attack(this.damagePerTargetFactor) {
  }

  String name() {
    return runtimeType.toString();
  }
}

class None extends Attack {
  None() : super(0.0) ;
}

// Simple single-hit attack
class Hit extends Attack {
  Hit() : super(1.0) ;
}

// jump-hit attack
class Jump extends Attack {
  Jump() : super(1.5) ;
}

// multi-target attack
class Swing extends Attack {
  Swing() : super(0.9) ;
}



/**
 * Performs a physical attack from one attacker on one target being.
 */
void attackTarget(Being attacker, Being target, Attack attack) {
  print("****> attacker " + attacker.getSpecies() + " attacks target: " + target.species.name() + " / attack: " + attack.name());
  double attackPower = attacker.strength().toDouble();
  print("------> attacker strength: " + attackPower.toString());
  print("------> attack damage factor: " + attack.damagePerTargetFactor.toString());
  double damage = attack.damagePerTargetFactor * attackPower;
  if (damage > 0) {
    damage -= target.defense();
  }
  print("------> dish out damage: " + damage.round().toString());
  target.damageBy(damage.round());
}
