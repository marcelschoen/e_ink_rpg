// Abstract base class for physical attacks
abstract class Attack {

  var damagePerTargetFactor = 0.0;

  Attack(this.damagePerTargetFactor) {
  }

  String name() {
    return runtimeType.toString();
  }
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
