
import 'package:e_ink_rpg/models/stat.dart';

// ----------------------------------------------------
// Special skill that the player can learn
// ----------------------------------------------------
class Skill {

  List<Stat> _requiredStats = [];
  String _name;
  String _description;

  Skill(this._name, this._description);

  String get description => _description;

  String get name => _name;

  List<Stat> get requiredStats => _requiredStats;
}

class Combat extends Skill {
  Combat() : super('Combat', 'Ability to fight with melee weapons.');
}

class Archery extends Skill {
  Archery() : super('Archery', 'Ability to use ranged weapons.');
}

class Survival extends Skill {
  Survival() : super('Survival', 'Ability to make the most from collected loot.');
}

//Stat minWhirlwindStat = Stat.withValue(StatType.strength, 100, 100);
//Skill Whirlwind = Skill('Whirlwind', [ minWhirlwindStat ], 3.5, 'A whirlwind attack');