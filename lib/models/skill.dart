
import 'package:e_ink_rpg/models/stat.dart';

// ----------------------------------------------------
// Special skill that the player can learn
// ----------------------------------------------------
class Skill {

  List<Stat> _requiredStats;
  double _baseAttackPower;
  String _name;
  String _description;

  Skill(this._name, this._requiredStats, this._baseAttackPower, this._description);

  String get description => _description;

  String get name => _name;

  double get baseAttackPower => _baseAttackPower;

  List<Stat> get requiredStats => _requiredStats;
}

Stat minWhirlwindStat = Stat.withValue(StatType.strength, 100, 100);
Skill Whirlwind = Skill('Whirlwind', [ minWhirlwindStat ], 3.5, 'A whirlwind attack');