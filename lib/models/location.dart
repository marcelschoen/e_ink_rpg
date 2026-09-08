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

const int MAX_LOCATIONS_PER_REGION = 81;
const int START_LOCATION = 40;
const int COLUMNS_PER_REGION = 9;
const int ROWS_PER_REGION = 9;

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
  bool path = false;
  // Directions in which "path" actually carves an edge to a neighbor, as
  // opposed to merely being grid-adjacent to another path location. This is
  // what the map renders segments for.
  Set<ConnectionsDirection> pathConnections = {};
  GameLocationType locationType;
  List<LocalPointOfInterest> localPointsOfInterest = [];
  String name;
  Map<ConnectionsDirection, GameLocation> connectedLocations = {};
  Exploration? exploration;

  GameLocation(this.locationType, this.name, this.index)
      : locationRandom = Random(), mapColumn = index - ((index ~/ COLUMNS_PER_REGION) * COLUMNS_PER_REGION),
        mapRow = index ~/ COLUMNS_PER_REGION
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
      if (mapRow == 0) {
        // this location is at the upper border of the region
        return null;
      }
      offset = -COLUMNS_PER_REGION;
    } else if (direction == ConnectionsDirection.south) {
      if (mapRow == ROWS_PER_REGION - 1) {
        // this location is at the lower border of the region
        return null;
      }
      offset = COLUMNS_PER_REGION;
    } else if (direction == ConnectionsDirection.east) {
      if (mapColumn == COLUMNS_PER_REGION - 1) {
        // this location is at the right border of the region
        return null;
      }
      offset = 1;
    } else if (direction == ConnectionsDirection.west) {
      if (mapColumn == 0) {
        // this location is at the left border of the region
        return null;
      }
      offset = -1;
    }
    int targetIndex = index + offset;
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
    for (GameLocation loc in locations) {
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
    String name = NameHandler.fantasyNames.compose(3);
    return GameLocation(GameLocationType.cottage, name, index);
  }

  // ---------------------------------------------------------------------------
  // Generates the local points of interest (shop, tavern etc.) for a
  // location. Only called for path locations - non-path locations are
  // decoration only and are never entered, so they don't need any.
  // ---------------------------------------------------------------------------
  static void populatePointsOfInterest(GameLocation location) {
    int numberOfPoIs = GameState().gameRandom.nextInt(3) + 1;
    if (numberOfPoIs < 0) {
      numberOfPoIs = 0;
    }

    numberOfPoIs += 2;  // TEMPORARY

    List<int> usedIndexes = [];
    for (int i = 0; i < numberOfPoIs; i++) {

      // TODO - GENERATE POIs (Shop, Tavern etc.)
      int fieldNumber = GameState().gameRandom.nextInt(25);
      while (usedIndexes.contains(fieldNumber)) {
        fieldNumber = GameState().gameRandom.nextInt(25);
      }
      usedIndexes.add(fieldNumber);

      LocalPointOfInterest localPointOfInterest = LocalPointOfInterestFactory.create(fieldNumber);
      location.localPointsOfInterest.add(localPointOfInterest);
    }
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
    print("Created " + locations.length.toString() + " locations.");
    int currentLocationIndex = MAX_LOCATIONS_PER_REGION ~/ 2;
    GameRegion region = GameRegion(name, locations, locations[currentLocationIndex]);


    // Then connect them with each other
    for (GameLocation location in region.locations) {
      location.connectToAdjoiningLocations();
    }

    _carvePaths(locations[START_LOCATION]);

    for (GameLocation location in locations) {
      if (location.path) {
        LocationFactory.populatePointsOfInterest(location);
      }
    }

    locations[START_LOCATION].unlocked = true;
    region.setCurrentLocationTo(locations[START_LOCATION]);

    return region;
  }

  // ---------------------------------------------------------------------------
  // Carves a single connected, branching path network through the region's
  // grid via randomized Prim's-style frontier growth, starting at "start".
  // Locations the growth never reaches stay "path == false" (available for
  // decoration such as trees, rather than being walkable/explorable).
  // ---------------------------------------------------------------------------
  static void _carvePaths(GameLocation start) {
    int minPathLocations = (MAX_LOCATIONS_PER_REGION * 0.4).round();
    int maxPathLocations = (MAX_LOCATIONS_PER_REGION * 0.6).round();
    int targetPathCount = minPathLocations + GameState().gameRandom.nextInt(maxPathLocations - minPathLocations + 1);

    start.path = true;
    int pathCount = 1;

    List<MapEntry<GameLocation, GameLocation>> frontier = start.connectedLocations.values
        .map((neighbor) => MapEntry(start, neighbor))
        .toList();

    while (frontier.isNotEmpty && pathCount < targetPathCount) {
      MapEntry<GameLocation, GameLocation> edge = frontier.removeAt(GameState().gameRandom.nextInt(frontier.length));
      GameLocation from = edge.key;
      GameLocation to = edge.value;
      if (to.path) {
        continue;
      }
      to.path = true;
      pathCount++;
      _connectPath(from, to);

      for (GameLocation neighbor in to.connectedLocations.values) {
        if (!neighbor.path) {
          frontier.add(MapEntry(to, neighbor));
        }
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Marks the edge between two adjoining locations as an actual carved path
  // (on both sides), rather than mere grid adjacency.
  // ---------------------------------------------------------------------------
  static void _connectPath(GameLocation from, GameLocation to) {
    from.connectedLocations.forEach((direction, location) {
      if (location == to) {
        from.pathConnections.add(direction);
      }
    });
    to.connectedLocations.forEach((direction, location) {
      if (location == from) {
        to.pathConnections.add(direction);
      }
    });
  }
}
