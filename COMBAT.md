# Notes about combat mechanics / formulas

## Involved attributes / stats

### Item Attributes

* attackPower

### Player Attributes

* defense, // defense value
* level,   // player level
* speed,   // speed / affects combat turn order
* speedCounter,

### Stats

* mana,   // needed to perform magic
* focus,  // needed to perform special melee attacks / recharges automatically

### Skills

* Combat
* Archery
* Magic

## Damage calculation

### Melee

(((weapon.attackPower * (skill.level / 2)) * (attacker.level / 4)) * 1.5) - ((target.defense / 1.5) * (target.level / 4)
((22 * (3 / 2)) * (15 / 4)) - (45 * (13 / 4))
      33        *  3.75     -  45 *  3.25
              123.75        -    146.25        =  



(A) damage = (((weapon.attackPower * skill.level) * attacker.level / 2 ) - (target.defense * target.level / 2)) * random.boost
(B) damage = (weapon.attackPower * skill.level - target.defense) * random.boost
(C) damage = (weapon.attackPower - target.defense)
(D) damage = (((((2 * attacker.level) / 5) + 2) * skill.level * (weapon.attackPower / target.level) ) / 50 + 2) * random.boost
(E) damage = (((((2 * attacker.level) / 5) + 2) * skill.level * (weapon.attackPower / target.defense) ) / + 4) * random.boost

### Example

ASSUMPTION: HP of target and attacker: 100 / defense is deducted from damage
Random boost ("random.boost"): between 1.1 and 1.7

* *BOTH STARTING LEVELS*
* weapon.attackPower: 16
* skill.level: 1
* attacker.level: 1
* target.defense: 9
* target.level: 1
* random.boost: 1.4

(A) ((16 * 1) * 1 / 2) - (9 * 1) / 2) = 36
(B) 16 * 1 - 9 = 7
(D) (((((2 * 1) / 5) + 2) * 1 * (16 / 9) ) / 50 + 2) * 1.4 = 2.84
2.4 * 1.77 = 4.26       0.426 + 2     2.426

* *ATTACKER HIGHER LEVEL*
* weapon.attackPower: 22
* skill.level: 3
* attacker.level: 15
* target.defense: 45
* target.level: 13

(A) ((22 * 3) * 15 / 2) - (45 * 13 / 2) = 495 - 337.5 = 157.5
(B) 22 * 3 - 45 = 66 - 45 = 21
(E) damage = (((((2 * 15) / 5) + 2) * 3 * (22 / 45) ) + 4) * 1.4  = 22
24 * 

* *BOTH EQUAL LEVELS*
* weapon.attackPower: 15
* skill.level: 3
* attacker.level: 15
* target.defense: 45
* target.level: 15

(A) ((15 * 3) * 15 / 2) - (45 * 15 / 2) = 337.5 - 337.5 = 0
(B) 15 * 3 - 45 = 0
(E) damage = (((((2 * 15) / 5) + 2) * 3 * (15 / 45) ) / + 4) * 1.4

### Magic

damage = ((spell.attackPower * skill.level) * attacker.level / 2 ) - (target.defense * target.level)
