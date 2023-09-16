// Abstract base class for physical attacks
import 'package:e_ink_rpg/combat.dart';
import 'package:e_ink_rpg/models/attribute.dart';
import 'package:e_ink_rpg/models/skill.dart';
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

  static double getMeleeDamage(double attackPower, double skillLevel, double attackerLevel, double targetDefense, double targetLevel) {
    return ( (((attackPower * (skillLevel / 2)) * (attackerLevel / 4)) * 1.5) - ((targetDefense / 1.5) * (targetLevel / 4)) ) * 1.6;
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

  double attackPower = attacker.getAttackPower();
  double skillLevel = attacker.getSkill(SkillType.Combat).getLevel();
  double attackerLevel = attacker.attrValue(AttributeType.level);
  double targetDefense = target.attrValue(AttributeType.defense);
  double targetLevel = target.attrValue(AttributeType.level);

  double damage = Attack.getMeleeDamage(attackPower, skillLevel, attackerLevel, targetDefense, targetLevel);

  print("> target health: " + target.health().toString());
  print("> final damage: " + damage.round().toString());
  target.damageBy(damage);
  for (Being enemy in CurrentCombat().enemies()) {
    if (enemy != target && enemy.state().affected) {
      double affectedDamage = damage * 0.7;
      print(">> damage affected enemy: " + enemy.getSpecies());
      enemy.damageBy(affectedDamage);
    }
  }

  if (attack is Spell && attacker == Player()) {
    GameState().player.decreaseStatBy(StatType.mana, (attack as Spell).manaUsage);
    GameState().playerState.update();
  }

  if (!target.isAlive()) {
    GameState().player.increaseXp(target.attrValue(AttributeType.killXp));
    CurrentCombat().selectedTarget = null;
    CurrentCombat().deselectTargets();
    CurrentCombat().deaffectTargets();
    CurrentCombat().updateTargets();
    GameState().update();
  }
}
