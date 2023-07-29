// Abstract base class for magic spells
abstract class Spell {

  var damagePerTargetFactor = 0.0;

  Spell(this.damagePerTargetFactor) {
  }

  String name() {
    return runtimeType.toString();
  }
}

// Single-hit fireball attack
class Fireball extends Spell {
  Fireball() : super(1.0) ;
}
