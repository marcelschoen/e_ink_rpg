import 'package:e_ink_rpg/models/stat.dart';

/**
 * Base class for any living being.
 */
class Being {

  Map<StatType, Stat> _stats = {};

  Being() {
    addStat(Stat(StatType.health, 100));
    addStat(Stat(StatType.strength, 10));
    addStat(Stat(StatType.defense, 5));
  }

  bool hasStat(StatType statType) {
    return _stats.containsKey(statType);
  }

  Stat? stat(StatType statType) {
    return _stats[statType];
  }

  void addStat(Stat stat) {
    _stats.putIfAbsent(stat.statType, () => stat);
  }

  bool isAlive() {
    return _stats[StatType.health]!.value() > 0;
  }

  heal() {
    _stats[StatType.health]!.restore();
  }

  healBy(int value) {
    _stats[StatType.health]!.restoreBy(value);
  }

  die() {
    _stats[StatType.health]!.deplete();
  }
}

/**
 * Base class for humanoid characters, the main difference
 * being that they can equip armor, use weapons, have an
 * inventory etc.
 */
class Humanoid extends Being {
  var money = 0;
  var name = '<UNKNOWN>';
}

/**
 * Player subclass for humanoid, with all the attributes etc.
 * that are only relevant to the player character.
 */
class Player extends Humanoid {
//  var experience = 0;
}