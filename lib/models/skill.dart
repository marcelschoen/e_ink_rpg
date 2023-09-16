import 'package:e_ink_rpg/models/stat.dart';

// -----------------------------------------------------------------------------
//
// A skill has a level from 1 - 10 and directly boosts a certain aspect of the
// player, e.g. certain damage types, or amount of items received for some
// action etc.
//
// Special skills unlock special actions or rewards.
//
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Level of skills
// -----------------------------------------------------------------------------
enum SkillLevel {
  Ultimate(10),
  Superior(9),
  Master(8),
  Advanced(7),
  Proficient(6),
  Experienced(5),
  Enthusiast(4),
  Average(3),
  Regular(2),
  Beginner(1)
  ;

  final double level;

  const SkillLevel(this.level);
}

// -----------------------------------------------------------------------------
// Types of skills
// -----------------------------------------------------------------------------
enum SkillType {
  Combat('Boosts damage of melee weapon attacks.'),
  Archery('Boosts damage of archery weapon attacks.'),
  Magic('Boosts damage of magic attacks.'),
  Stealth('Boosts efficiency of stealth and sneaking actions.'),
  Fishing('Affects fishing efficiency.'),
  Gardening('Affects gardening efficiency.'),
  ;

  final String description;

  const SkillType(this.description);
}

// -----------------------------------------------------------------------------
// Special skill that the player can learn
// -----------------------------------------------------------------------------
class Skill {

  List<Stat> _requiredStats = [];
  String _name;
  String _details;
  SkillLevel _level;
  SkillType _type;
  List<Skill> extraSkillsLeft = [];
  List<Skill> extraSkillsRight = [];

  Skill(this._name, this._details, this._level, this._type);

  String get description => _details;

  String get name => _name;

  List<Stat> get requiredStats => _requiredStats;

  addSpecialSkill(bool left, String name, String details) {
    Skill specialSkill = _specialSkill(name, details, _level, _type);
    if (left) {
      extraSkillsLeft.add(specialSkill);
    } else {
      extraSkillsRight.add(specialSkill);
    }
  }

  double getLevel() {
    return _level.level;
  }

  static Skill _specialSkill(String name, String details, SkillLevel level, SkillType type) {
    return Skill(name, details, level, type);
  }

}


// -----------------------------------------------------------------------------
// A skill tree
// -----------------------------------------------------------------------------
class SkillTree {

  Map<SkillLevel, Skill> skills = {};
  SkillLevel unlockedLevel = SkillLevel.Beginner;

  SkillTree(SkillType type) {
    for (SkillLevel level in SkillLevel.values) {
      skills[level] = Skill(type.name, '', level, type);
    }
  }

  Skill getCoreSkill() {
    return skills[unlockedLevel]!;
  }
}

// -----------------------------------------------------------------------------
// Creates skill trees
// -----------------------------------------------------------------------------
class SkillTreeFactory {
  static SkillTree createSkillTree(SkillType type) {
    SkillTree tree = SkillTree(type);

    if (type == SkillType.Combat) {

      tree.skills[SkillLevel.Regular]!.addSpecialSkill(true, 'Swing', 'Broad swing which hits multiple targets.');
      tree.skills[SkillLevel.Average]!.addSpecialSkill(false, 'Parry', 'Attempts to deflect the next enemy attack.');
      tree.skills[SkillLevel.Average]!.addSpecialSkill(false, 'Kick', 'May knock out an enemy for a moment.');
      tree.skills[SkillLevel.Proficient]!.addSpecialSkill(true, 'Barrage', 'Delivers multiple hits at one target.');

    } else if (type == SkillType.Archery) {


    } else if (type == SkillType.Magic) {


    } else if (type == SkillType.Stealth) {


    } else if (type == SkillType.Fishing) {

      tree.skills[SkillLevel.Regular]!.addSpecialSkill(false, 'Tinkerer', 'Build better lures (increase change of catch by 20%).');
      tree.skills[SkillLevel.Regular]!.addSpecialSkill(false, 'Masterworker', 'Build premium lures (increase change of catch by 40%).');

      tree.skills[SkillLevel.Average]!.addSpecialSkill(true, 'Collector', '5% Chance of getting treasure.');
      tree.skills[SkillLevel.Average]!.addSpecialSkill(true, 'Looter', '15% Chance of getting treasure.');
      tree.skills[SkillLevel.Average]!.addSpecialSkill(true, 'Treasure Hunter', '25% Chance of getting treasure.');

      tree.skills[SkillLevel.Enthusiast]!.addSpecialSkill(false, 'Ice Driller', 'Enables fishing at frozen lakes.');

      tree.skills[SkillLevel.Proficient]!.addSpecialSkill(true, 'Sonar', 'Enables spotting fish in the water.');

    } else if (type == SkillType.Gardening) {

    }
    return tree;
  }
}




//Stat minWhirlwindStat = Stat.withValue(StatType.strength, 100, 100);
//Skill Whirlwind = Skill('Whirlwind', [ minWhirlwindStat ], 3.5, 'A whirlwind attack');