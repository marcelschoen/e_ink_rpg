

class Being {
  var health = 0;

  bool isAlive() {
    return this.health > 0;
  }

  die() {
    this.health = 0;
  }
}

class Humanoid extends Being {
  var money = 0;

}

class Player extends Humanoid {
  var experience = 0;
}