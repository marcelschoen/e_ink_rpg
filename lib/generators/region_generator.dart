import 'package:e_ink_rpg/names.dart';

import '../models/location.dart';
import '../models/point_of_interest.dart';
import '../models/region.dart';
import '../state.dart';

const int START_LOCATION = 40;

// -----------------------------------------------------------------------------
// Generates local points of interest
// -----------------------------------------------------------------------------
class LocalPointOfInterestFactory {
  static LocalPointOfInterest create(int index) {

    // TODO - CREATE ACTUAL POIs
    int poiType = GameState().gameRandom.nextInt(LocalPointOfInterestType.values.length);

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
/*
    final weights = <GameLocationType, num>{
      GameLocationType.empty: 5,
      GameLocationType.village: 2
    };
    GameLocationType type = weightedRandom(weights, GameState().gameRandom);
*/
    // 1st generate map without actual POIs so we can put things
    // like villages, castles etc. at the end of paths to avoid having
    // many paths ending in an empty location
    return GameLocation(GameLocationType.empty, name, index);
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
    return _generate(START_LOCATION, null);
  }

  // ---------------------------------------------------------------------------
  // Returns the region reachable from "exitLocation" (a location with a
  // region exit set by _pickRegionExits). The first crossing lazily generates
  // the adjoining region, entering at the point mirroring "exitLocation" on
  // the opposite border, and caches the link both ways so re-crossing (in
  // either direction) always returns to the same region.
  // ---------------------------------------------------------------------------
  static GameRegion crossInto(GameRegion fromRegion, GameLocation exitLocation) {
    ConnectionsDirection direction = exitLocation.regionExits.first;
    GameRegion? existing = fromRegion.adjoiningRegions[direction];
    if (existing != null) {
      return existing;
    }

    ConnectionsDirection backDirection = direction.opposite;
    GameRegion newRegion = _generate(_mirroredEntryIndex(exitLocation, direction), backDirection);

    fromRegion.adjoiningRegions[direction] = newRegion;
    newRegion.adjoiningRegions[backDirection] = fromRegion;
    return newRegion;
  }

  // ---------------------------------------------------------------------------
  // Generates a region. "startIndex" is where the path network is carved
  // from and where the player starts out (region-center for a brand new
  // region, or the mirrored entry point when crossing from an adjoining
  // region). "exitBackDirection", if given, is pre-marked as a region exit
  // pointing back the way the player came, guaranteeing the crossing is
  // reversible.
  // ---------------------------------------------------------------------------
  static GameRegion _generate(int startIndex, ConnectionsDirection? exitBackDirection) {
    String name = NameHandler.fantasyNames.compose(3);
    // Generate all locations in the region
    List<GameLocation> locations = [];
    for (int index = 0; index < MAX_LOCATIONS_PER_REGION; index ++) {
      GameLocation location = LocationFactory.create(index);
      locations.add(location);
    }
    print("Created " + locations.length.toString() + " locations.");

    // Clear the corners to make the map look a bit more "rounded"
    locations[0].locationType = GameLocationType.empty;
    locations[COLUMNS_PER_REGION - 1].locationType = GameLocationType.empty;
    locations[(locations.length - 1) - (COLUMNS_PER_REGION - 1)].locationType = GameLocationType.empty;
    locations[locations.length - 1].locationType = GameLocationType.empty;

    // Now fill convert some of those location to non-empty ones
    // - preferrably those at the end of a path
    // - but also a few in between
    // - the ones in between are either small hamlets, rarely villages,
    //   ponds or dungeons
    // - larger villages, castles, cities etc. should usually be at the end of a path




    GameRegion region = GameRegion(name, locations, locations[startIndex]);

    // Then connect them with each other
    for (GameLocation location in region.locations) {
      location.connectToAdjoiningLocations();
    }

    GameLocation start = locations[startIndex];
    if (exitBackDirection != null) {
      start.regionExits.add(exitBackDirection);
      start.pathConnections.add(exitBackDirection);
    }

    _carvePaths(start);
    _pickRegionExits(locations, excludeDirection: exitBackDirection);

    for (GameLocation location in locations) {
      if (location.path) {
        LocationFactory.populatePointsOfInterest(location);
      }
    }

    start.unlocked = true;
    region.setCurrentLocationTo(start);

    return region;
  }

  // ---------------------------------------------------------------------------
  // Carves a single connected, branching path network through the region's
  // grid via randomized Prim's-style frontier growth, starting at "start".
  // Locations the growth never reaches stay "path == false" (available for
  // decoration such as trees, rather than being walkable/explorable).
  // ---------------------------------------------------------------------------
  static void _carvePaths(GameLocation start) {
    int minPathLocations = (MAX_LOCATIONS_PER_REGION * 0.2).round();
    int maxPathLocations = (MAX_LOCATIONS_PER_REGION * 0.4).round();
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

  // ---------------------------------------------------------------------------
  // Picks, for each border direction not already spoken for, one path
  // location touching that border to be the region's exit in that direction
  // (marking it with a region exit and an outward path segment). A region
  // ends up with anywhere from 0 to 4 exits, entirely depending on whether
  // its path network happened to reach that border.
  // ---------------------------------------------------------------------------
  static void _pickRegionExits(List<GameLocation> locations, {ConnectionsDirection? excludeDirection}) {
    for (ConnectionsDirection direction in ConnectionsDirection.values) {
      if (direction == excludeDirection) {
        continue;
      }
      List<GameLocation> candidates = locations
          .where((location) => location.path && location.regionExits.isEmpty && _isOnBorder(location, direction))
          .toList();
      if (candidates.isEmpty) {
        continue;
      }
      GameLocation exit = candidates[GameState().gameRandom.nextInt(candidates.length)];
      exit.regionExits.add(direction);
      exit.pathConnections.add(direction);
    }
  }

  static bool _isOnBorder(GameLocation location, ConnectionsDirection direction) {
    switch (direction) {
      case ConnectionsDirection.north: return location.mapRow == 0;
      case ConnectionsDirection.south: return location.mapRow == ROWS_PER_REGION - 1;
      case ConnectionsDirection.west: return location.mapColumn == 0;
      case ConnectionsDirection.east: return location.mapColumn == COLUMNS_PER_REGION - 1;
    }
  }

  // ---------------------------------------------------------------------------
  // The grid index, in the adjoining region, that mirrors "exitLocation" on
  // the opposite border - e.g. crossing north lands at the same column on
  // the new region's south edge.
  // ---------------------------------------------------------------------------
  static int _mirroredEntryIndex(GameLocation exitLocation, ConnectionsDirection direction) {
    switch (direction) {
      case ConnectionsDirection.north:
        return (ROWS_PER_REGION - 1) * COLUMNS_PER_REGION + exitLocation.mapColumn;
      case ConnectionsDirection.south:
        return exitLocation.mapColumn;
      case ConnectionsDirection.east:
        return exitLocation.mapRow * COLUMNS_PER_REGION;
      case ConnectionsDirection.west:
        return exitLocation.mapRow * COLUMNS_PER_REGION + (COLUMNS_PER_REGION - 1);
    }
  }
}
