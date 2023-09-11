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
import 'dart:math';

import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/names.dart';

import '../state.dart';
import 'exploration.dart';

final int MAX_LOCATIONS_PER_REGION = 25;
final int COLUMNS_PER_REGION = 5;
final int ROWS_PER_REGION = 5;

enum ConnectionsDirection {
  north,
  south,
  west,
  east
  ;
}

enum LocalPointOfInterestType {
  generalGoodsStore(GameImageAsset.map_poi_shop_interior, 'General Goods'),
  weaponSmith(GameImageAsset.map_poi_shop_interior, 'Weapon Smith'),
  armorSmith(GameImageAsset.map_poi_shop_interior, 'Armor Smith'),
  tavern(GameImageAsset.map_loc_hamlet, 'Tavern'),
  pond(GameImageAsset.map_loc_monolith, 'Pond'),
  garden(GameImageAsset.map_loc_ruin_small, 'Garden'),
  ;

  final GameImageAsset imageAsset;
  final String label;

  const LocalPointOfInterestType(this.imageAsset, this.label);

}

// -----------------------------------------------------------------------------
// Local point of view within a location (e.g. shop, tavern, pond...)
// -----------------------------------------------------------------------------
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
  village(GameImageAsset.map_loc_hamlet),
  dungeon(GameImageAsset.map_loc_custom_dungeon_entrance),
  cottage(GameImageAsset.map_loc_hamlet),
  farm(GameImageAsset.map_loc_hamlet),
  bridge(GameImageAsset.map_loc_bridge_north_south),
  encampment(GameImageAsset.map_loc_walled_enclosure),
  castle(GameImageAsset.map_loc_castle),
  fortress(GameImageAsset.map_loc_fortress),
  ;

  final GameImageAsset imageAsset;

  const GameLocationType(this.imageAsset);
}

// -----------------------------------------------------------------------------
// Location (lowest level of map, contains multiple PoI, like villages etc.)
// -----------------------------------------------------------------------------
class GameLocation {
  GameRegion? parentRegion;
  Random locationRandom;
  int index;
  int mapColumn;
  int mapRow;
  bool unlocked = false;
  GameLocationType locationType;
  List<LocalPointOfInterest> localPointsOfInterest = [];
  String name;
  Map<ConnectionsDirection, GameLocation> connectedLocations = {};
  Exploration? exploration;

  GameLocation(this.locationType, this.name, this.index)
      : this.locationRandom = Random(), this.mapColumn = index - ((index ~/ COLUMNS_PER_REGION) * COLUMNS_PER_REGION),
        this.mapRow = index ~/ COLUMNS_PER_REGION
  {
    exploration = Exploration(locationRandom, locationRandom.nextInt(5) + 4);
  }

  bool isConnectedToUnlockedLocation() {
    for (GameLocation location in connectedLocations.values) {
      if (location.unlocked) {
        return true;
      }
    }
    return false;
  }

  connectToAdjoiningLocations() {
    for (ConnectionsDirection direction in ConnectionsDirection.values) {
      GameLocation? adjoiningLocation = getLocationInDirection(direction);
      if (adjoiningLocation != null) {
        connectedLocations[direction] = adjoiningLocation;
      }
    }
  }

  GameLocation? getLocationInDirection(ConnectionsDirection direction) {
    int offset = 0;
    if (direction == ConnectionsDirection.north) {
      if (this.mapRow == 0) {
        // this location is at the upper border of the region
        return null;
      }
      offset = -COLUMNS_PER_REGION;
    } else if (direction == ConnectionsDirection.south) {
      if (this.mapRow == ROWS_PER_REGION - 1) {
        // this location is at the lower border of the region
        return null;
      }
      offset = COLUMNS_PER_REGION;
    } else if (direction == ConnectionsDirection.east) {
      if (this.mapColumn == 0) {
        // this location is at the left border of the region
        return null;
      }
      offset = 1;
    } else if (direction == ConnectionsDirection.west) {
      if (this.mapColumn == COLUMNS_PER_REGION - 1) {
        // this location is at the right border of the region
        return null;
      }
      offset = -1;
    }
    int targetIndex = this.index + offset;
    if (targetIndex > -1 && targetIndex < MAX_LOCATIONS_PER_REGION) {
      return parentRegion!.locations[targetIndex];
    }
    return null;
  }

}

// -----------------------------------------------------------------------------
// Region (mid-level of map, contains multiple locations)
// -----------------------------------------------------------------------------
class GameRegion {
  List<GameLocation> locations;
  String name;
  GameLocation? _currentLocation;
  Map<ConnectionsDirection, GameRegion> adjoiningRegions = {};

  GameRegion(this.name, this.locations, this._currentLocation) {
    for (GameLocation loc in this.locations) {
      loc.parentRegion = this;
    }
  }

  setCurrentLocationTo(GameLocation location) {
    _currentLocation = location;
  }

  GameLocation currentLocation() {
    return _currentLocation!;
  }
}

// *****************************************************************************
//
// FACTORIES
//
// *****************************************************************************


// -----------------------------------------------------------------------------
// Generates local points of interest
// -----------------------------------------------------------------------------
class LocalPointOfInterestFactory {
  static LocalPointOfInterest create(int index) {

    // TODO - CREATE ACTUAL POIs
    int poiType = GameState().gameRandom.nextInt(LocalPointOfInterestType.values.length);
//    print ("> generate random POI of type: " + LocalPointOfInterestType.values[poiType].name);

    LocalPointOfInterestType type = LocalPointOfInterestType.values[poiType];
    String name = NameHandler.fantasyNames.compose(3);
    return LocalPointOfInterest(type, name, index);
  }
}

// -----------------------------------------------------------------------------
// Generates local location
// -----------------------------------------------------------------------------
class LocationFactory {

  static GameLocation create(int index) {
    int numberOfPoIs = GameState().gameRandom.nextInt(3) + 1;
    if (numberOfPoIs < 0) {
      numberOfPoIs = 0;
    }

    numberOfPoIs += 2;  // TEMPORARY

    String name = NameHandler.fantasyNames.compose(3);
    GameLocation location = GameLocation(GameLocationType.cottage, name, index);

    List<int> usedIndexes = [];
    for (int i = 0; i < numberOfPoIs; i++) {

      // TODO - GENERATE POIs (Shop, Tavern etc.)
      int fieldNumber = GameState().gameRandom.nextInt(25);
      while (usedIndexes.contains(fieldNumber)) {
        fieldNumber = GameState().gameRandom.nextInt(25);
      }
      usedIndexes.add(fieldNumber);

      name = NameHandler.fantasyNames.compose(3);
      LocalPointOfInterest localPointOfInterest = LocalPointOfInterestFactory.create(fieldNumber);
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
    // Generate all locations in the region
    List<GameLocation> locations = [];
    for (int index = 0; index < MAX_LOCATIONS_PER_REGION; index ++) {
      GameLocation location = LocationFactory.create(index);
      locations.add(location);
    }
    int currentLocationIndex = MAX_LOCATIONS_PER_REGION ~/ 2;
    GameRegion region = GameRegion(name, locations, locations[currentLocationIndex]);


    // Then connect them with each other
    for (GameLocation location in region.locations) {
      location.connectToAdjoiningLocations();
    }
    return region;
  }
}
