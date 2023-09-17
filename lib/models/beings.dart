import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/skill.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';

import '../equip.dart';
import '../inventory.dart';
import 'attack.dart';
import 'attribute.dart';
import 'location.dart';
import 'magic.dart';

/**
 * Base class for any living being.
 */
class Being {

  BeingState? _state;

  Map<AttributeType, Attribute> _attrs = {};
  Map<StatType, Stat> _stats = {};
  Map<SkillType, SkillTree> skillTrees = {};

  SpeciesType species;
  bool selected = false;
  Inventory inventory = Inventory();

  // speed and speed counter used for turn order
  //double speedCounter = 0.0;
  //double speed = 1.0;

  Being.player() : this(SpeciesType.player);

  Being(SpeciesType monsterType) : species = monsterType {
    // Stats
    setStat(Stat.withValue(StatType.health, monsterType.maxHealth(), monsterType.maxHealth()));
    setAttrValue(AttributeType.speed, 1);
    setAttrValue(AttributeType.attackPower, 0);
    addSKill(SkillType.Combat);
    _state = BeingState(this);
  }

  BeingState state() {
    return this._state!;
  }

  addSKill(SkillType type) {
    skillTrees.putIfAbsent(type, () => SkillTreeFactory.createSkillTree(type));
  }

  Skill getSkill(SkillType type) {
    return skillTrees[type]!.getCoreSkill();
  }

  double maxHealth() {
    return _stats[StatType.health]!.maxValue();
  }

  double health() {
    return _stats[StatType.health]!.value();
  }

  double maxMana() {
    return _stats[StatType.mana]!.maxValue();
  }

  double mana() {
    return _stats[StatType.mana]!.value();
  }

  double money() {
    return _attrs[AttributeType.money]!.value();
  }

  void addMoney(double value) {
    _attrs[AttributeType.money]!.increaseValueBy(value);
  }

  double defense() {
    return _attrs[AttributeType.defense]!.value();
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

  void restoreStatBy(StatType statType, double restoreValue) {
    if (_stats.containsKey(statType)) {
      _stats[statType]!.restoreBy(restoreValue);
    }
  }

  void decreaseStatBy(StatType statType, double decreaseValue) {
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

  increaseAttrValueBy(AttributeType type, double value) {
    if (!_attrs.containsKey(type)) {
      setAttribute(Attribute.withValue(type, value));
    } else {
      _attrs[type]!.increaseValueBy(value);
    }
  }

  double attrValue(AttributeType type) {
    return _attrs.containsKey(type) ? _attrs[type]!.value() : 0;
  }

  int attrValueInt(AttributeType type) {
    return _attrs.containsKey(type) ? _attrs[type]!.value().toInt() : 0;
  }

  Attribute getAttribute(AttributeType type) {
    return _attrs[type]!;
  }

  void setAttrValue(AttributeType type, double value) {
    if (!_attrs.containsKey(type)) {
      setAttribute(Attribute.withValue(type, value));
    } else {
      _attrs[type]!.setValueTo(value);
    }
  }

  void setAttribute(Attribute attr) {
    _attrs[attr.type] = attr;
  }

  double statValue(StatType statType) {
    return _stats.containsKey(statType) ? _stats[statType]!.value() : 0;
  }

  double statMaxValue(StatType statType) {
    return _stats.containsKey(statType) ? _stats[statType]!.maxValue() : 0;
  }

  void setStat(Stat stat) {
    _stats[stat.statType] = stat;
  }

  void setStatValue(StatType statType, double newValue) {
    if (!_stats.containsKey(statType)) {
      return;
    }
    _stats[statType]!.setValueTo(newValue);
    _state!.update();
  }

  void setStatMaxValue(StatType statType, double newMaxValue) {
    if (!_stats.containsKey(statType)) {
      return;
    }
    _stats[statType]!.setMaxValueTo(newMaxValue);
  }

  Map<StatType, Stat> getStats() {
    return _stats;
  }

  bool isAlive() {
    return _stats[StatType.health]!.value() > 0;
  }

  heal() {
    _stats[StatType.health]!.restore();
    _state!.update();
  }

  healBy(double value) {
    _stats[StatType.health]!.restoreBy(value);
    _state!.update();
  }

  damageBy(double value) {
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

  double getAttackPower() {
    return attrValue(AttributeType.attackPower);
  }
}

enum SpeciesType {
  angrywasp('Angry Wasp', 20, 'angrywasp.png'),
  darkwizard('Dark Wizard', 180, 'darkwizard.png'),
  tentacleeye('Evil Eye', 130, 'tentacleeye.png'),
  bloodbat('Blood Bat', 50, 'bloodbat.png'),
  acidblob('Acid Blob', 100, 'blob.png'),

  npc('NPC', 100, 'RPG_Monster_123-3.png'),
  player('Player', 100, '')
  ;

  const SpeciesType(this._name, this._maxHealth, this.filename);

  final String _name;
  final double _maxHealth;
  final String filename;

  String name() {
    return _name;
  }

  double maxHealth() {
    return this._maxHealth;
  }
}

/**
 * Base class for humanoid characters, the main difference
 * being that they can equip armor, use weapons, have an
 * inventory etc.
 */
class Humanoid extends Being {

  String name;
  Set<Attack> availableAttacks = {};
  Set<Spell> availableSpells = {};
  final Equipment equipment = Equipment();

  Humanoid(this.name) : super(SpeciesType.npc) {
    setAttrValue(AttributeType.attackPower, 5);
  }

  @override
  double getAttackPower() {
    Weapon? weapon = equipment.getWeapon();
    return weapon == null ? attrValue(AttributeType.attackPower) : weapon.getAttribute(AttributeType.attackPower).value();
  }
}

/**
 * Player subclass for humanoid, with all the attributes etc.
 * that are only relevant to the player character.
 */
class Player extends Humanoid {

  GameRegion? _currentRegion;

  // singleton instance
  static final Player _instance = Player._internal();

  Player._internal() : super('Player') {
    reset();
    species = SpeciesType.player;
    setAttrValue(AttributeType.speed, 2);
    setAttrValue(AttributeType.attackPower, 5);
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

    setStat(Stat.withValue(StatType.health, 100, 100));
    setStat(Stat.withValue(StatType.mana, 20, 20));
    setStat(Stat.withValue(StatType.focus, 20, 20));
    setStat(Stat.withValue(StatType.xp, 0, 100));

    // Attributes
    setAttribute(Attribute.withValue(AttributeType.level, 1));
    setAttribute(Attribute.withValue(AttributeType.defense, 5));
    // TODO - ADD ATTRIBUTE STRENGTH ?????
    setAttribute(Attribute.withValue(AttributeType.money, 500));

    name = 'Harribo';
    availableAttacks = { Hit(), Swing() };
    availableSpells = { Fireball() };
  }

  increaseXp(double increase) {
    restoreStatBy(StatType.xp, increase);
    if (statIsFull(StatType.xp)) {
      depleteStat(StatType.xp);
    }
  }

  unlockAttack(Attack attack) {
    availableAttacks.add(attack);
  }

  @override
  damageBy(double value) {
    super.damageBy(value);
  }
}
