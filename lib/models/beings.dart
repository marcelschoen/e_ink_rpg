import 'package:e_ink_rpg/models/stat.dart';

/**
 * Base class for any living being.
 */
class Being {

  Map<StatType, Stat> _stats = {};
  SpeciesType species;

  Being(SpeciesType monsterType) : species = monsterType {
    addStat(Stat(StatType.health, 100));
    addStat(Stat(StatType.strength, 10));
    addStat(Stat(StatType.defense, 5));
  }

  int health() {
    return _stats[StatType.health]!.value();
  }

  int strength() {
    return _stats[StatType.strength]!.value();
  }

  int defense() {
    return _stats[StatType.defense]!.value();
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

  damageBy(int value) {
    _stats[StatType.health]!.decreaseBy(value);
  }

  die() {
    _stats[StatType.health]!.deplete();
  }

  String getSpecies() {
    print("-----> return species...");
    return species.name();
  }
}

enum SpeciesType {
  wolf('Wolf'),
  warg('Warg'),
  ghost('Ghost'),
  skeleton('Skeleton'),

  npc('NPC'),
  player('Player')
  ;

  const SpeciesType(this._name);

  final String _name;

  String name() {
    return _name;
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

  Humanoid() : super(SpeciesType.npc) {}

  Humanoid.withSpecies(SpeciesType speciesType) : super(speciesType) {}
}

/**
 * Player subclass for humanoid, with all the attributes etc.
 * that are only relevant to the player character.
 */
class Player extends Humanoid {
//  var experience = 0;

  // singleton instance
  static final Player _instance = Player._internal();

  Player._internal() : super.withSpecies(SpeciesType.player) {
    stat(StatType.strength);
  }

  factory Player() {
    return _instance;
  }
}