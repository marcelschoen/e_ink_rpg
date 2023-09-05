import 'dart:math';

import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';

import '../equip.dart';
import '../inventory.dart';
import 'attack.dart';
import 'location.dart';
import 'magic.dart';

/**
 * Base class for any living being.
 */
class Being {

  int killXp = 10;
  int level = 1;
  BeingState? _state;
  Map<StatType, Stat> _stats = {};
  SpeciesType species;
  bool selected = false;
  Inventory inventory = Inventory();

  final _random = new Random();

  // speed and speed counter used for turn order
  double speedCounter = 0.0;
  double speed = 1.0;

  Being.player() : this(SpeciesType.player);

  Being(SpeciesType monsterType) : species = monsterType {
    int maxHealth = monsterType.maxHealth();
    Stat statHealth = Stat(StatType.health, maxHealth);
    statHealth.setValueTo(maxHealth);
    setStat(statHealth);
//    addStat(Stat.withValue(StatType.health, 5 + _random.nextInt(9) * 10, 100));
    setStat(Stat.withValue(StatType.strength, 10, 10));
    setStat(Stat.withValue(StatType.defense, 5, 5));
    setStat(Stat.withValue(StatType.mana, 20, 20));
    setStat(Stat.withValue(StatType.skillpoints, 0, 5));
    setStat(Stat.withValue(StatType.xp, 0, 100));
    _state = BeingState(this);

    if (species == SpeciesType.player) {
      speed = 2;
      print("************* SET PLAYER SPEED TO 2");
    }
  }

  BeingState state() {
    return this._state!;
  }

  int maxHealth() {
    return _stats[StatType.health]!.maxValue();
  }

  int health() {
    return _stats[StatType.health]!.value();
  }

  int maxMana() {
    return _stats[StatType.mana]!.maxValue();
  }

  int mana() {
    return _stats[StatType.mana]!.value();
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
/*
  Stat? stat(StatType statType) {
    return _stats[statType];
  }
*/
  void restoreStat(StatType statType) {
    if (_stats.containsKey(statType)) {
      _stats[statType]!.restore();
    }
  }

  bool statIsFull(StatType statType) {
    if (_stats.containsKey(statType)) {
      return _stats[statType]!.value() >= _stats[statType]!.maxValue();
    }
    return false;
  }

  void restoreStatBy(StatType statType, int restoreValue) {
    if (_stats.containsKey(statType)) {
      _stats[statType]!.restoreBy(restoreValue);
    }
  }

  void decreaseStatBy(StatType statType, int decreaseValue) {
    if (_stats.containsKey(statType)) {
      _stats[statType]!.decreaseBy(decreaseValue);
    }
  }

  void depleteStat(StatType statType) {
    if (_stats.containsKey(statType)) {
      _stats[statType]!.deplete();
    }
  }

  double progressBarValue(StatType statType) {
    return _stats.containsKey(statType) ? _stats[statType]!.progressBarValue() : 0;
  }

  int statValue(StatType statType) {
    return _stats.containsKey(statType) ? _stats[statType]!.value() : 0;
  }

  int statMaxValue(StatType statType) {
    return _stats.containsKey(statType) ? _stats[statType]!.maxValue() : 0;
  }

  void setStat(Stat stat) {
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
  angrywasp('Angry Wasp', 80, 'angrywasp.png'),
  darkwizard('Dark Wizard', 180, 'darkwizard.png'),
  tentacleeye('Evil Eye', 130, 'tentacleeye.png'),
  bloodbat('Blood Bat', 50, 'bloodbat.png'),
  acidblob('Acid Blob', 100, 'blob.png'),

  npc('NPC', 100, 'RPG_Monster_123-3.png'),
  player('Player', 100, '')
  ;

  const SpeciesType(this._name, this._maxHealth, this.filename);

  final String _name;
  final int _maxHealth;
  final String filename;

  String name() {
    return _name;
  }

  int maxHealth() {
    return this._maxHealth;
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

  Set<Attack> availableAttacks = {};
  Set<Spell> availableSpells = {};
  GameRegion? _currentRegion;
  final Equipment equipment = Equipment();

  // singleton instance
  static final Player _instance = Player._internal();

  Player._internal() : super.player() {
    reset();
  }

  factory Player() {
    return _instance;
  }

  createNewRegion() {
    _currentRegion = RegionFactory.create();
  }

  GameRegion currentRegion() {
    return _currentRegion!;
  }

  setCurrentRegionTo(GameRegion region) {
    _currentRegion = region;
  }

  setCurrentLocationTo(GameLocation location) {
    _currentRegion!.setCurrentLocationTo(location);
  }

  GameLocation currentLocation() {
    return _currentRegion!.currentLocation();
  }

  reset() {
    print ("-------------------------- RESET --------------------------");
    inventory.reset();
    level = 1;
    setStatValue(StatType.strength, 10);
    setStatValue(StatType.health, 100);
    setStatValue(StatType.skillpoints, 0);
    setStatValue(StatType.xp, 0);
    money = 0;
    name = 'Harribo';
    availableAttacks = { Hit(), Swing() };
    availableSpells = { Fireball() };
  }

  increaseXp(int increase) {
    restoreStatBy(StatType.xp, increase);
    if (statIsFull(StatType.xp)) {
      level ++;
      depleteStat(StatType.xp);
    }
  }

  unlockAttack(Attack attack) {
    availableAttacks.add(attack);
  }

  @override
  damageBy(int value) {
    super.damageBy(value);
  }
}
