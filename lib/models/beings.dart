import 'dart:math';

import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';

/**
 * Base class for any living being.
 */
class Being {

  MonsterState? _state;
  Map<StatType, Stat> _stats = {};
  SpeciesType species;
  final _random = new Random();

  Being(SpeciesType monsterType) : species = monsterType {
    addStat(Stat.withValue(StatType.health, _random.nextInt(10) * 10, 100));
    addStat(Stat.withValue(StatType.strength, 10, 10));
    addStat(Stat.withValue(StatType.defense, 5, 5));
    _state = MonsterState(this);
    print(">>> monster state: " + _state.toString());
  }

  MonsterState state() {
    return this._state!;
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

  void setStatValue(StatType statType, int newValue) {
    _stats[statType]!.setValueTo(newValue);
    _state!.update();
  }

  void setStatMaxValue(StatType statType, int newMaxValue) {
    _stats[statType]!.setMaxValueTo(newMaxValue);
  }

  bool isAlive() {
    return _stats[StatType.health]!.value() > 0;
  }

  heal() {
    _stats[StatType.health]!.restore();
    _state!.update();
  }

  healBy(int value) {
    _stats[StatType.health]!.restoreBy(value);
    _state!.update();
  }

  damageBy(int value) {
    _stats[StatType.health]!.decreaseBy(value);
    _state!.update();
  }

  die() {
    _stats[StatType.health]!.deplete();
    _state!.update();
  }

  String getSpecies() {
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
mixin Humanoid {
  var money = 0;
  var name = '<UNKNOWN>';
}

/**
 * Player subclass for humanoid, with all the attributes etc.
 * that are only relevant to the player character.
 */
class Player extends Being with Humanoid {
//  var experience = 0;

  Player() : super(SpeciesType.player) {
    setStatValue(StatType.strength, 10);
    setStatValue(StatType.health, 100);
    money = 0;
    name = 'Harribo';
  }

  @override
  damageBy(int value) {
    super.damageBy(value);
  }
}