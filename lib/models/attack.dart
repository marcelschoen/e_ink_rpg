// Abstract base class for physical attacks
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';

import 'beings.dart';
import 'magic.dart';

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
  Swing() : super(0.9, 3) ;
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
  double affectedDamage = damage;
  print("> damage: " + damage.toString());
  if (damage > 0) {
    damage -= target.defense();
    affectedDamage = damage * 3 / 5; // 60% damage for affected targets
  }
  print("> target health: " + target.health().toString());
  print("> final damage: " + damage.round().toString());
  target.damageBy(damage.round());
  for (Being enemy in CurrentFight().enemies()) {
    if (enemy != target && enemy.state().affected) {
      print(">> damage affected enemy: " + enemy.getSpecies());
      enemy.damageBy(affectedDamage.round());
    }

  }

  if (attack is Spell && attacker == Player()) {
    int manaUsage = (attack as Spell).manaUsage.toInt();
    GameState().player.stat(StatType.mana)!.decreaseBy( manaUsage );
    print("> player max mana: " + GameState().player.stat(StatType.mana)!.maxValue().toString());
    print("> player mana: " + GameState().player.stat(StatType.mana)!.value().toString());
    print("> player mana %: " + GameState().player.stat(StatType.mana)!.progressBarValue().toString());
    GameState().update();
  }

  if (!target.isAlive()) {
    CurrentFight().selectedTarget = null;
    CurrentFight().deselectTargets();
    CurrentFight().deaffectTargets();
    CurrentFight().updateTargets();
    GameState().update();
  }
}
