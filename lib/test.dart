

void main() {

  double attackPower = 16;
  double skillLevel = 1;
  double attackerLevel = 1;
  double targetDefense = 9;
  double targetLevel = 1;

  double randomBoost = 1.6;

  double damage = getDamage(attackPower, skillLevel, attackerLevel, targetDefense, targetLevel);


  print('>> DAMAGE 1: ' + damage.toString());

  // Attacker slightly higher level
  attackPower = 32;
  skillLevel = 2;
  attackerLevel = 5;
  targetDefense = 42;
  targetLevel = 3;
  damage = damage = getDamage(attackPower, skillLevel, attackerLevel, targetDefense, targetLevel);
  print('>> DAMAGE 2: ' + damage.toString());


  // Attacker much higher level
  attackPower = 55;
  skillLevel = 6;
  attackerLevel = 45;
  targetDefense = 42;
  targetLevel = 3;

  damage = damage = getDamage(attackPower, skillLevel, attackerLevel, targetDefense, targetLevel);
  print('>> DAMAGE 3: ' + damage.toString());


  // Attacker much lower level
  attackPower = 25;
  skillLevel = 2;
  attackerLevel = 3;
  targetDefense = 42;
  targetLevel = 8;

  damage = damage = getDamage(attackPower, skillLevel, attackerLevel, targetDefense, targetLevel);
  print('>> DAMAGE 4: ' + damage.toString());

  /*
  * weapon.attackPower: 16
  * skill.level: 1
  * attacker.level: 1
  * target.defense: 9
  * target.level: 1
  * random.boost: 1.4
  */
}

double getDamage(double attackPower, double skillLevel, double attackerLevel, double targetDefense, double targetLevel) {
  return ( (((attackPower * (skillLevel / 2)) * (attackerLevel / 4)) * 1.5) - ((targetDefense / 1.5) * (targetLevel / 4)) ) * 1.6;
}
