import 'location.dart';

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

enum GameRegionBiome {
  plain,
  desert,
  rocky,
  mountains,
  snowy,
  icy,
  jungle,
  forest
}
