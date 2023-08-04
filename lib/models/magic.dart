// Abstract base class for magic spells
import 'attack.dart';

abstract class Spell extends Attack {

  double manaUsage;

  Spell(super.damagePerTargetFactor, super.affectedTargets, this.manaUsage);
}

// Single-hit fireball attack
class Fireball extends Spell {
  Fireball() : super(5.0, 1, 5) ;
}
