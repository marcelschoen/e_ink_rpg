import 'package:e_ink_rpg/daytime.dart';
import 'package:e_ink_rpg/equip.dart';
import 'package:e_ink_rpg/items/armor/ironArmor.dart';
import 'package:e_ink_rpg/items/consumables/apricot.dart';
import 'package:e_ink_rpg/items/consumables/banana.dart';
import 'package:e_ink_rpg/items/consumables/beef_jerky.dart';
import 'package:e_ink_rpg/items/consumables/cheese.dart';
import 'package:e_ink_rpg/items/consumables/choko.dart';
import 'package:e_ink_rpg/items/consumables/grape.dart';
import 'package:e_ink_rpg/items/consumables/healingPotions.dart';
import 'package:e_ink_rpg/items/consumables/honeycomb.dart';
import 'package:e_ink_rpg/items/consumables/orange.dart';
import 'package:e_ink_rpg/items/consumables/pear.dart';
import 'package:e_ink_rpg/items/consumables/sausage.dart';
import 'package:e_ink_rpg/items/consumables/snozzcumber.dart';
import 'package:e_ink_rpg/items/consumables/strawberry.dart';
import 'package:e_ink_rpg/items/consumables/sultana.dart';
import 'package:e_ink_rpg/items/valuables/gold_pile.dart';
import 'package:e_ink_rpg/items/weapons/ItemRustyShortSword.dart';
import 'package:e_ink_rpg/jobs/kills/bandits.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

import 'fight.dart';
import 'game.dart';
import 'inventory.dart';
import 'items/consumables/apple.dart';
import 'items/consumables/bone.dart';
import 'items/consumables/bread_ration.dart';
import 'items/consumables/fruit.dart';
import 'items/consumables/lemon.dart';
import 'jobs.dart';
import 'models/action.dart';
import 'models/attack.dart';
import 'models/beings.dart';
import 'models/item.dart';
import 'models/jobs.dart';

// ---------------------------------------------
// General state change notifier
// ---------------------------------------------
class GeneralState with ChangeNotifier {
  update() {
    notifyListeners();
  }
}

enum AppBarSections {
  jobs,
  shop,
  inventory,
  equip,
  skills
  ;
}

class AppBarState with ChangeNotifier {

  AppBarSections sections = AppBarSections.jobs;

  void section(AppBarSections section) {
    this.sections = section;
    update();
  }

  update() {
    notifyListeners();
  }
}

// --------------------------------------------------
// Game difficulty levels
// --------------------------------------------------
enum Difficulty {
  easy,
  normal,
  hard
}

enum ScreenType {
  jobs,
  shop,
  inventory,
  equipment,
  skills,
  title,
  fight,
  flight,
}

// --------------------------------------------------
// Singleton game state holder and change notifier.
// --------------------------------------------------
class GameState with ChangeNotifier {

  // singleton instance
  static final GameState _instance = GameState._internal();

  final Player player = Player();
  final BeingState playerState;
  final GeneralState hintState = GeneralState();
  final GeneralState turnOrderState = GeneralState();
  final GeneralState lowerButtonsState = GeneralState();
  final GeneralState optionButtonState = GeneralState();
  final GeneralState appBarTitleState = GeneralState();
  final GeneralState inventorySelectionState = GeneralState();
  final GeneralState jobSelectionState = GeneralState();
  final GeneralState jobsButtonState = GeneralState();
  final GeneralState equipState = GeneralState();

  final GameDaytime daytime = GameDaytime();
  final Equipment equipment = Equipment();

  ScreenType _screenType = ScreenType.title;
  Difficulty difficulty = Difficulty.normal;

  AvailableJobs availableJobs = AvailableJobs();

  GameItem? selectedInEquipment = null;
  InventoryGameItemStack? selectedInInventory = null;
  Job? selectedInJobs = null;

  GameState._internal() : playerState = BeingState(Player()) {
  }

  factory GameState() {
    return _instance;
  }

  ScreenType screenType() {
    return this._screenType;
  }

  void setScreenByWidget(Widget widget) {
    print (">> set screen by widget: " + widget.runtimeType.toString());
    if (widget.runtimeType == MonsterSlayerTitle) {
      setScreenType(ScreenType.title);
    } else if (widget.runtimeType == Fight) {
      setScreenType(ScreenType.fight);
    } else if (widget.runtimeType == Game) {
      setScreenType(ScreenType.jobs);
    }
  }

  void setScreenTypeByNumber(int tabIndex) {
    switch (tabIndex) {
      case 1:
        GameState().availableJobs.deselectAllJobs();
        GameState().selectedInJobs = null;
        GameState().jobSelectionState.update();
        setScreenType(ScreenType.shop);
        break;
      case 2:
        GameState().player.inventory.deselectAllStacks();
        GameState().selectedInInventory = null;
        GameState().inventorySelectionState.update();
        setScreenType(ScreenType.inventory);
        break;
      case 3:
        setScreenType(ScreenType.equipment);
        break;
      case 4:
        setScreenType(ScreenType.skills);
        break;
      default:
        setScreenType(ScreenType.jobs);
    }
  }

  void setScreenType(ScreenType type) {
    this._screenType = type;
    appBarTitleState.update();
  }

  update() {
    notifyListeners();
  }

  void beginGame() {
    Player().reset();
    Player().inventory.reset();
    GameState().availableJobs.reset();
    GameState().daytime.reset();

    selectedInInventory = null;
    selectedInJobs = null;

    Player().inventory.addItem(IronHelmet());
    Player().inventory.addItem(IronBreastPlate());
    Player().inventory.addItems(SmallHealingPotion(), 150);
    Player().inventory.addItem(RustyShortSword());
    Player().inventory.addItems(IronGloves(), 8);
    Player().inventory.addItem(MaximumHealingPotion());
    Player().inventory.addItems(Apple(), 8);
    Player().inventory.addItems(Banana(), 8);
    Player().inventory.addItems(BeefJerky(), 8);
    Player().inventory.addItems(Cheese(), 8);
    Player().inventory.addItems(Grape(), 8);
    Player().inventory.addItems(Lemon(), 8);
    Player().inventory.addItems(Grape(), 8);

    Player().inventory.addItems(Bone(), 8);
    Player().inventory.addItems(BreadRation(), 8);
    Player().inventory.addItems(Fruit(), 8);
    Player().inventory.addItems(Honeycomb(), 8);
    Player().inventory.addItems(Orange(), 8);
    Player().inventory.addItems(Pear(), 8);
    Player().inventory.addItems(Sausage(), 8);
    Player().inventory.addItems(Strawberry(), 8);
    Player().inventory.addItems(Apricot(), 8);
    Player().inventory.addItems(Choko(), 8);
    Player().inventory.addItems(Snozzcumber(), 8);
    Player().inventory.addItems(Sultana(), 8);

    Player().inventory.addItems(GoldPile(), 50);


    EliminateBandit job = new EliminateBandit('Lone Thief', 'A thief is harassing the locals. Eliminate him!', 0);

    JobStep waveOne = JobStep();
    waveOne.attackers.add(AngryWasp());
    waveOne.attackers.add(AngryWasp());
    job.addStep(waveOne);

    JobStep waveTwo = JobStep();
    waveTwo.attackers.add(Bandit());
    job.addStep(waveTwo);

    availableJobs.add(job);

//    availableJobs.add(new EliminateBandit('Lone Thief', 'A thief is harassing the locals. Eliminate him!', 1));
    availableJobs.add(new EliminateBandit('Bandit Duo', 'Deal with the bandit duo breaking in houses everywhere.', 2));
    availableJobs.add(new EliminateBandit('The Rats', 'The bandit group called "The Rats" has murdered several traders; get rid of them!', 4));
  }

  @override
  void dispose() {
    // NOTE: For some reason, someone is invoking this "dispose", which destroys
    // our singleton player state holder (which this method prevents).
    //super.dispose();
  }
}

// ---------------------------------------------
// Being state holder (per being instance)
// ---------------------------------------------
class BeingState with ChangeNotifier {

  final Being _being;
  int position = 0;
  bool selected = false;
  bool affected = false;

  BeingState(Being being) : _being = being {}

  Being being() {
    return _being;
  }

  update() {
    notifyListeners();
  }
}

// ---------------------------------------------------
// Group of action options selected on the left side
// ---------------------------------------------------
enum SelectedOptionGroup {
  attack,
  magic,
  skill,
  special
}

// ---------------------------------------------
// Singleton holder for state of current fight
// ---------------------------------------------
class CurrentFight {
  // instance variables
  List<Being> _enemies = [];
  SelectedOptionGroup selectedOptionGroup = SelectedOptionGroup.attack;
  GameAction? selectedAction = null;
  Attack? selectedAttack = null;
  Being? selectedTarget = null;
  bool aborted = false;

  List<Being> turnOrder = [];

  bool enemyTurn = false;


  // singleton instance
  static final CurrentFight _instance = CurrentFight._internal();

  CurrentFight._internal() {}

  factory CurrentFight() {
    return _instance;
  }

  // ---------------------------------------------------------
  // Decides whos' turn it is next, based on regular turn
  // order, character speed attributes and other factors.
  // ---------------------------------------------------------
  void updateTurnList() {
    List<Being> beingsInTurn = [];
    beingsInTurn.add(Player());
    beingsInTurn.addAll(_enemies);
print("> beings in turn order: " + beingsInTurn.length.toString());
    turnOrder = [];

    const turnEntries = 7;
    const speedLimit = 5;

    // Always calculate 7 turns
    while (turnOrder.length < turnEntries) {
      print ("-------------> turn order result length: " + turnOrder.length.toString());
      for (Being being in beingsInTurn) {
        print ("> process being: " + being.getSpecies());
        bool found = false;
        while (!found && turnOrder.length < turnEntries) {
          being.speedCounter += being.speed;
          if (being.speedCounter > speedLimit) {
            print("========> Adding entry to turn order...");
            found = true;
            being.speedCounter -= speedLimit;
            turnOrder.add(being);
          }
        }
      }
    }

    GameState().turnOrderState.update();
    print(">>>> TURN ORDER LENGTH: " + turnOrder.length.toString());
  }

  // ---------------------------------------------------------
  // Sets conditions to start fight against wave of enemies
  // ---------------------------------------------------------
  void begin(List<Being> enemies) {
    GameState().player.heal();
    GameState().player.restoreStat(StatType.mana);
    setEnemies(enemies);
    aborted = false;
    selectedTarget = null;
    selectedOptionGroup = SelectedOptionGroup.attack;

    selectedAttack = Hit();

    updateTurnList();
  }

  // ---------------------------------------
  // Updates all enemy targets
  // ---------------------------------------
  void updateTargets() {
    for (Being being in _enemies) {
      being.state().update();
    }
  }

  // ---------------------------------------
  // Deselects all enemy targets
  // ---------------------------------------
  void deselectTargets() {
    for (Being being in _enemies) {
      being.state().selected = false;
    }
  }

  // ---------------------------------------
  // De-affects all enemy targets
  // ---------------------------------------
  void deaffectTargets() {
    for (Being being in _enemies) {
      being.state().affected = false;
    }
  }

  // ---------------------------------------
  // Selects an attack target
  // ---------------------------------------
  void selectAttackTarget(Being being) {

    if (!being.isAlive()) {
      print (">> target is already dead!");
      return;
    }

    // deselect all enemies first
    // then select new target
    deselectTargets();
    deaffectTargets();

    selectedTarget = being;
    selectedTarget!.state().selected = true;

    markAffectedTargets();

    updateTargets();
    GameState().hintState.update();
  }

  // ------------------------------------------------------------
  // marks all targets affected by the currently selected attack
  // ------------------------------------------------------------
  void markAffectedTargets() {
    if (selectedTarget != null && selectedAttack != null && selectedAttack!.affectedTargets > 1) {

      int startPosition = selectedTarget!.state().position - (selectedAttack!.affectedTargets ~/ 2);
      int endPosition = startPosition + selectedAttack!.affectedTargets - 1;
      if (startPosition < 0) {
        startPosition = 0;
      }
      if (endPosition >= enemies().length) {
        endPosition = enemies().length - 1;
      }

      print("> affected targets: " + selectedAttack!.affectedTargets.toString());
      print("> startPosition: " + startPosition.toString());
      print("> endPosition: " + endPosition.toString());

      for (int pos = startPosition; pos < endPosition + 1; pos ++) {
        Being enemy = enemies().elementAt(pos);
        print ("> enemy at pos " + pos.toString() + ": " + enemy.getSpecies());
        if (enemy.isAlive() && enemy != selectedTarget) {
          enemy.state().affected = true;
        }
      }
    }
  }

  void markTargetAsAffected(int position) {
    if (position < 0 || position >= enemies().length || position == selectedTarget!.state().position) {
      return;
    }
    enemies().elementAt(position).state().affected = true;
  }

  void setEnemies(List<Being> enemies) {
    this._enemies = enemies;
    // assign position to each enemy; this is necessary to be able
    // to determine who's affected by AoE attacks.
    for (int i = 0; i < this._enemies.length; i++) {
      this._enemies[i].state().position = i;
    }
  }

  List<Being> enemies() {
    return this._enemies;
  }

  bool finished() {
    if(!GameState().player.isAlive() || aborted) {
      return true;
    }

    for(Being enemy in this._enemies) {
      if(enemy.isAlive()) {
        return false;
      }
    }
    return true;
  }

  /**
   * Implements an actual physical attack on enemies
   */
  void attackEnemyPhysical(Being enemy, Attack attack) {
    attackTarget(GameState().player, enemy, attack);
  }

  void attackEnemiesWithMagic() {
    // TBD
  }

  /**
   * Enemies turn / they attack the player.
   */
  void enemiesAttackPlayer() {
    for (Being enemy in this._enemies) {
      attackTarget(enemy, GameState().player, Hit());
    }
    GameState().update();
  }
}
