// GameLocation: the lowest level of the map, one grid cell within a region.
// See region.dart for GameRegion (the level above) and point_of_interest.dart
// for the shops/taverns/etc. a location can contain. Region/location
// generation logic itself lives in generators/region_generator.dart.
import 'dart:math';

import 'package:e_ink_rpg/assets.dart';

import 'exploration.dart';
import 'point_of_interest.dart';
import 'region.dart';

const int MAX_LOCATIONS_PER_REGION = 81;
const int COLUMNS_PER_REGION = 9;
const int ROWS_PER_REGION = 9;

enum ConnectionsDirection {
  north,
  south,
  west,
  east
  ;

  ConnectionsDirection get opposite {
    switch (this) {
      case ConnectionsDirection.north: return ConnectionsDirection.south;
      case ConnectionsDirection.south: return ConnectionsDirection.north;
      case ConnectionsDirection.west: return ConnectionsDirection.east;
      case ConnectionsDirection.east: return ConnectionsDirection.west;
    }
  }
}

// -----------------------------------------------------------------------------
// Points of interest per region (e.g. villages, dungeons, castles etc.)
// -----------------------------------------------------------------------------
enum GameLocationType {
  empty(GameImageAsset.map_tile_empty),
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
  // At most one direction: set when this location is where the region's path
  // network reaches the border and continues into an adjoining region.
  Set<ConnectionsDirection> regionExits = {};
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

  // ---------------------------------------------------------------------------
  // Whether this location is reachable from an unlocked one via an actual
  // carved path edge - grid adjacency alone ("connectedLocations") isn't
  // enough, since two path locations can sit next to each other without a
  // path ever having been carved between them.
  // ---------------------------------------------------------------------------
  bool isConnectedToUnlockedLocation() {
    for (ConnectionsDirection direction in pathConnections) {
      GameLocation? neighbor = connectedLocations[direction];
      if (neighbor != null && neighbor.unlocked) {
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
