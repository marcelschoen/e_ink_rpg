import 'dart:convert';
import 'dart:math';

import 'package:e_ink_rpg/daytime.dart';
import 'package:e_ink_rpg/items/valuables/gold_pile.dart';
import 'package:e_ink_rpg/jobs/kills/bandits.dart';
import 'package:e_ink_rpg/map.dart';
import 'package:e_ink_rpg/models/location.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

import 'fight.dart';
import 'game.dart';
import 'inventory.dart';
import 'jobs.dart';
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
    sections = section;
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
  exploration,
}

// --------------------------------------------------
// Singleton game state holder and change notifier.
// --------------------------------------------------
class GameState with ChangeNotifier {

  // *******************************************************
  // persisted variables
  // *******************************************************

  final Player player = Player();

  int gameRandomSeed = 0;
  Random gameRandom = Random(0);

  AvailableJobs availableJobs = AvailableJobs();
  Difficulty difficulty = Difficulty.normal;
  String? selectedGameSave;
  GameLocation? currentlyExploring;

  // *******************************************************
  // transient variables
  // *******************************************************

  final BeingState playerState;
  final GeneralState titleState = GeneralState();
  final GeneralState hintState = GeneralState();
  final GeneralState turnOrderState = GeneralState();
  final GeneralState lowerButtonsState = GeneralState();
  final GeneralState optionButtonState = GeneralState();
  final GeneralState appBarTitleState = GeneralState();
  final GeneralState inventorySelectionState = GeneralState();
  final GeneralState jobSelectionState = GeneralState();
  final GeneralState jobsButtonState = GeneralState();
  final GeneralState equipState = GeneralState();
  final GeneralState mapState = GeneralState();
  final GeneralState saveState = GeneralState();
  final GeneralState explorationState = GeneralState();

  final GameDaytime daytime = GameDaytime();

  ScreenType _screenType = ScreenType.title;

  MapZoomLevel mapZoomLevel = MapZoomLevel.location;
  GameLocation? selectedLocationInMap;
  LocalPointOfInterest? selectedPoiInMap;
  GameItem? selectedInEquipment;
  InventoryGameItemStack? selectedInInventory;
  Job? selectedInJobs;

  // singleton instance
  static final GameState _instance = GameState._internal();

  GameState._internal() : playerState = BeingState(Player());

  factory GameState() {
    return _instance;
  }

  // ---------------------------------------------------------------------------
  // RESETS everything - the player state and the game state
  // ---------------------------------------------------------------------------
  reset() {
    Player().reset();
    availableJobs.reset();
    daytime.reset();
    gameRandom = Random(gameRandomSeed);

    GameState().mapZoomLevel = MapZoomLevel.region;

    GameState().player.createNewRegion();  // TEMPORARY

//    GameState().debugUnlockAllLocations();

    selectedInInventory = null;
    selectedInJobs = null;
    selectedLocationInMap = null;
    selectedPoiInMap = null;
    selectedInInventory = null;
    selectedInEquipment = null;

    EliminateBandit job = EliminateBandit('Lone Thief', 'A thief is harassing the locals. Eliminate him!', 0);

    JobStep waveOne = JobStep();
    waveOne.attackers.add(AngryWasp());
    waveOne.attackers.add(AngryWasp());
    job.addStep(waveOne);

    JobStep waveTwo = JobStep();
    waveTwo.attackers.add(Bandit());
    job.addStep(waveTwo);

    availableJobs.add(job);

//    availableJobs.add(new EliminateBandit('Lone Thief', 'A thief is harassing the locals. Eliminate him!', 1));
    availableJobs.add(EliminateBandit('Bandit Duo', 'Deal with the bandit duo breaking in houses everywhere.', 2));
    availableJobs.add(EliminateBandit('The Rats', 'The bandit group called "The Rats" has murdered several traders; get rid of them!', 4));
  }

  ScreenType screenType() {
    return _screenType;
  }

  void setScreenByWidget(Widget widget) {
    if (widget.runtimeType == MonsterSlayerTitle) {
      setScreenType(ScreenType.title);
    } else if (widget.runtimeType == Fight) {
      setScreenType(ScreenType.fight);
    } else if (widget.runtimeType == Game) {
      setScreenType(ScreenType.jobs);
    }
  }

  // ---------------------------------------------------------------------------
  // FOR DEBUGGING / DEVELOPMENT PURPOSES ONLY
  // ---------------------------------------------------------------------------
  void debugUnlockAllLocations() {
    for (GameLocation location in player.currentRegion().locations) {
      if (gameRandom.nextBool()) {
        location.unlocked = true;
      }
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
    _screenType = type;
    appBarTitleState.update();
  }

  update() {
    notifyListeners();
  }

  void beginNewGame() {
    gameRandomSeed = Random().nextInt(999999);

    GameState().reset();

    // TEMPORARY
    Player().inventory.addItem(ItemRegistry.getItem('Leather Helmet'));
    Player().inventory.addItem(ItemRegistry.getItem('Leather Breastplate'));
    Player().inventory.addItem(ItemRegistry.getItem('Iron Chain Mail'));

    Player().inventory.addItem((ItemRegistry.getItem('Iron Helmet')));

    Player().inventory.addItem((ItemRegistry.getItem('Old Leather Gloves')));
    Player().inventory.addItems((ItemRegistry.getItem('Iron Gloves')), 2);

    Player().inventory.addItem((ItemRegistry.getItem('Leather Boots')));
    Player().inventory.addItem((ItemRegistry.getItem('Iron Boots')));

    Player().inventory.addItem(ItemRegistry.getItem('Rusty Shortsword'));

    Player().inventory.addItems(ItemRegistry.getItem('Apple'), 7);
    Player().inventory.addItems(ItemRegistry.getItem('Restore Potion'), 50);
    Player().inventory.addItems(ItemRegistry.getItem('Banana'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Beef Jerky'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Cheese'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Grape'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Lemon'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Bone'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Bread Ration'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Fruit'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Honeycomb'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Orange'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Pear'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Sausage'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Strawberry'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Apricot'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Choko'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Snozzcumber'), 8);
    Player().inventory.addItems(ItemRegistry.getItem('Sultana'), 8);

    Player().inventory.addItems(GoldPile(), 50);

//    GameState().player.currentRegion().locations[12].unlocked = true;  // Starting location center of map
  }

  // ---------------------------------------------------------------------------
  // Converts the current state into a JSON string.
  // ---------------------------------------------------------------------------
  String toJson() {
    Map<String, dynamic> data = {};

    data['gameRandomSeed'] = gameRandomSeed;
    data['region'] = GameState().regionToJson(GameState().player.currentRegion());

    for (Stat stat in GameState().player.getStats().values) {
      String name = stat.statType.name;
      data['player.stat.$name.value'] = stat.value();
      data['player.stat.$name.maxValue'] = stat.maxValue();
    }

    for (InventoryGameItemStack stack in GameState().player.inventory.itemStacks) {
      if (stack.item != null) {
        data['items.${stack.item!.id}'] = stack.stackSize;
      }
    }


    return jsonEncode(data);
  }

  // ---------------------------------------------------------------------------
  // Initializes the current state from a JSON string.
  // ---------------------------------------------------------------------------
  fromJson(String json) {
    var data = jsonDecode(json);

    GameState().gameRandomSeed = data['gameRandomSeed'];
    GameState().reset();

    String? regionJson = data['region'];
    if (regionJson != null) {
      GameState().player.setCurrentRegionTo(GameState().regionFromJson(regionJson));
    }

    for (StatType statType in StatType.values) {
      var statValue = data['player.stat.${statType.name}.value'];
      if (statValue != null) {
        GameState().player.setStatValue(statType, statValue);
      }
      var statMaxValue = data['player.stat.${statType.name}.maxValue'];
      if (statMaxValue != null) {
        GameState().player.setStatMaxValue(statType, statMaxValue);
      }
    }

    String itemPrefix = 'items.';
    for (int itemId in ItemRegistry.getRegisteredIds()) {
      String itemKey = itemPrefix + itemId.toString();
      var itemStackSize = data[itemKey];
      if (itemStackSize != null && itemStackSize > 0) {
        GameState().player.inventory.addItems(ItemRegistry.getItemById(itemId), itemStackSize);
      }
    }


    /*
    _updateStatIfExists(Being being, StatType statType, int value, int maxValue) {
      if (being.getStats().containsKey(statType) && value != null) {
        being.setStatValue(statType, value);
      }
      if (being.getStats().containsKey(statType) && value != null) {
        being.setStatValue(statType, value);
      }
    }
*/
  }

  String regionToJson(GameRegion region) {
    Map<String, dynamic> data = {};

    data['name'] = region.name;
    data['currentLocationIndex'] = region.currentLocation().index;
    data['locations'] = region.locations.map((location) => {
      'index': location.index,
      'name': location.name,
      'locationType': location.locationType.name,
      'unlocked': location.unlocked,
      'path': location.path,
      'pathConnections': location.pathConnections.map((direction) => direction.name).toList(),
      'regionExits': location.regionExits.map((direction) => direction.name).toList(),
      'localPointsOfInterest': location.localPointsOfInterest.map((poi) => {
        'index': poi.index,
        'pointOfInterestType': poi.pointOfInterestType.name,
        'name': poi.name,
      }).toList(),
    }).toList();

    return jsonEncode(data);
  }

  // ---------------------------------------------------------------------------
  // Reconstructs a region (and its locations) from a JSON string previously
  // produced by "regionToJson". Adjoining locations are re-linked afterwards,
  // since they aren't part of the serialized data.
  // ---------------------------------------------------------------------------
  GameRegion regionFromJson(String json) {
    var data = jsonDecode(json);

    List<GameLocation> locations = [];
    for (var locationData in data['locations']) {
      GameLocationType locationType = GameLocationType.values.byName(locationData['locationType']);
      GameLocation location = GameLocation(locationType, locationData['name'], locationData['index']);
      location.unlocked = locationData['unlocked'];
      location.path = locationData['path'];
      location.pathConnections = (locationData['pathConnections'] as List)
          .map((name) => ConnectionsDirection.values.byName(name))
          .toSet();
      location.regionExits = (locationData['regionExits'] as List)
          .map((name) => ConnectionsDirection.values.byName(name))
          .toSet();

      for (var poiData in locationData['localPointsOfInterest']) {
        LocalPointOfInterestType poiType = LocalPointOfInterestType.values.byName(poiData['pointOfInterestType']);
        location.localPointsOfInterest.add(LocalPointOfInterest(poiType, poiData['name'], poiData['index']));
      }

      locations.add(location);
    }

    GameRegion region = GameRegion(data['name'], locations, locations[data['currentLocationIndex']]);

    for (GameLocation location in region.locations) {
      location.connectToAdjoiningLocations();
    }

    return region;
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

  BeingState(Being being) : _being = being;

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
