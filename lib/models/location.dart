// All major classes related to handling the map / regions. The hierarchy is:
//
// Region -> contains links to other regions and multiple locations
//    +- Location -> Contains 1-n local points of interest (taverns, shops etc.)
//          +- Point of Interest (tavern, shop etc.)

// Map zoom levels:
// local - shows local points of interest on map (tavern, shops etc.)
// region - shows locations on map (current location marked/selected)
// world - shows explored regions

// -----------------------------------------------------------------------------
// Points of interest in the current location (e.g. shops, taverns etc.)
// -----------------------------------------------------------------------------
import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/names.dart';

import '../shared.dart';

final int MAX_LOCATIONS_PER_REGION = 25;

enum LocalPointOfInterestType {
  generalGoodsStore,
  weaponSmith,
  armorSmith,
  tavern,
  pond,
  garden
}

class LocalPointOfInterest {
  int index;
  LocalPointOfInterestType pointOfInterestType;
  String name;

  LocalPointOfInterest(this.pointOfInterestType, this.name, this.index);
}

// -----------------------------------------------------------------------------
// Points of interest per region (e.g. villages, dungeons, castles etc.)
// -----------------------------------------------------------------------------
enum GameLocationType {
  village(GameImageAsset.map_icon_hamlet),
  dungeon(GameImageAsset.map_icon_custom_dungeon_entrance),
  cottage(GameImageAsset.map_icon_hamlet),
  farm(GameImageAsset.map_icon_hamlet),
  bridge(GameImageAsset.map_icon_bridge_north_south),
  encampment(GameImageAsset.map_icon_walled_enclosure),
  castle(GameImageAsset.map_icon_castle),
  fortress(GameImageAsset.map_icon_fortress),
  ;

  final GameImageAsset imageAsset;

  const GameLocationType(this.imageAsset);
}

class GameLocation {
  int index;
  GameLocationType locationType;
  List<LocalPointOfInterest> localPointsOfInterest = [];
  String name;

  GameLocation(this.locationType, this.name, this.index);
}

// -----------------------------------------------------------------------------
// Region (mid-level of map, contains multiple PoI, like villages etc.)
// -----------------------------------------------------------------------------
class GameRegion {
  List<GameLocation> locations = [];
  String name;

  GameRegion(this.name);
}

// -----------------------------------------------------------------------------
// Generates local points of interest
// -----------------------------------------------------------------------------
class LocalPointOfInterestFactory {
  static LocalPointOfInterest create(int index) {
    LocalPointOfInterestType type = LocalPointOfInterestType.tavern;
    String name = NameHandler.fantasyNames.compose(3);
    return LocalPointOfInterest(type, name, index);
  }
}

// -----------------------------------------------------------------------------
// Generates local location
// -----------------------------------------------------------------------------
class LocationFactory {

  static GameLocation create(int index) {
    int numberOfPoIs = gameRandom.nextInt(10) - 6;
    if (numberOfPoIs < 1) {
      numberOfPoIs = 1;
    }
    String name = NameHandler.fantasyNames.compose(3);
    GameLocation location = GameLocation(GameLocationType.cottage, name, index);

    for (int index = 0; index < numberOfPoIs; index++) {
      name = NameHandler.fantasyNames.compose(3);
      LocalPointOfInterest localPointOfInterest = LocalPointOfInterestFactory.create(index);
      location.localPointsOfInterest.add(localPointOfInterest);
    }
    return location;
  }
}

// -----------------------------------------------------------------------------
// Generates region
// -----------------------------------------------------------------------------
class RegionFactory {
  static GameRegion create() {
    String name = NameHandler.fantasyNames.compose(3);
    GameRegion region = GameRegion(name);
    for (int index = 0; index < MAX_LOCATIONS_PER_REGION; index ++) {
      GameLocation location = LocationFactory.create(index);
      region.locations.add(location);
    }
    return region;
  }
}

