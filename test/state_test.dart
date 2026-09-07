import 'package:e_ink_rpg/models/location.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter_test/flutter_test.dart';

// Builds a region by hand (rather than via RegionFactory) so the test doesn't
// depend on the fantasy-name asset bundle, which needs a Flutter binding.
GameRegion buildTestRegion() {
  List<GameLocation> locations = [];
  for (int i = 0; i < MAX_LOCATIONS_PER_REGION; i++) {
    GameLocation location = GameLocation(GameLocationType.village, 'Location $i', i);
    location.unlocked = i.isEven;
    location.localPointsOfInterest.add(LocalPointOfInterest(LocalPointOfInterestType.tavern, 'Tavern $i', 0));
    location.localPointsOfInterest.add(LocalPointOfInterest(LocalPointOfInterestType.pond, 'Pond $i', 1));
    locations.add(location);
  }
  return GameRegion('Test Region', locations, locations[START_LOCATION]);
}

void main() {
  test('regionToJson / regionFromJson round-trip', () {
    GameRegion region = buildTestRegion();

    String json = GameState().regionToJson(region);
    GameRegion restored = GameState().regionFromJson(json);

    expect(restored.name, region.name);
    expect(restored.currentLocation().index, region.currentLocation().index);
    expect(restored.locations.length, region.locations.length);

    for (int i = 0; i < region.locations.length; i++) {
      GameLocation original = region.locations[i];
      GameLocation copy = restored.locations[i];

      expect(copy.index, original.index);
      expect(copy.name, original.name);
      expect(copy.locationType, original.locationType);
      expect(copy.unlocked, original.unlocked);
      expect(copy.localPointsOfInterest.length, original.localPointsOfInterest.length);

      for (int j = 0; j < original.localPointsOfInterest.length; j++) {
        LocalPointOfInterest originalPoi = original.localPointsOfInterest[j];
        LocalPointOfInterest copyPoi = copy.localPointsOfInterest[j];
        expect(copyPoi.index, originalPoi.index);
        expect(copyPoi.name, originalPoi.name);
        expect(copyPoi.pointOfInterestType, originalPoi.pointOfInterestType);
      }
    }
  });
}
