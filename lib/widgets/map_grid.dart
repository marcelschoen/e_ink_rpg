import 'package:dotted_border/dotted_border.dart';
import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import '../generators/region_generator.dart';
import '../models/location.dart';
import '../models/map_zoom_level.dart';
import '../models/point_of_interest.dart';
import '../models/region.dart';
import 'map_tile.dart';

// -----------------------------------------------------------------------------
// Returns the map grid, based on zoom level
// -----------------------------------------------------------------------------
Widget getMapGridContents(BuildContext context) {
  List<Widget> mapGridWidgets = [];
  if (GameState().mapZoomLevel == MapZoomLevel.region) {
    mapGridWidgets = getLocations(context);
  } else if (GameState().mapZoomLevel == MapZoomLevel.world) {

    // TODO

  } else {
    mapGridWidgets = getPointsOfInterest(context);
  }

  List<Widget> rows = [];
  int index = 0;
  for (int row = 0; row < ROWS_PER_REGION; row ++) {
    List<Widget> columns = [];
    for (int column = 0; column < COLUMNS_PER_REGION; column ++) {
      columns.add( Expanded(child: mapGridWidgets[index++]));
    }
    rows.add(IntrinsicWidth(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: columns,),
    ));
  }
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 20),
    child: Column(
      children: rows ,
    ),
  );
}

// -----------------------------------------------------------------------------
// Returns grid widget with all the point of interest of the current location
// -----------------------------------------------------------------------------
List<Widget> getPointsOfInterest(BuildContext context) {
  if (GameState().player.currentLocation() == null) {
    return [];
  }
  List<LocalPointOfInterest>? pois = GameState().player.currentLocation().localPointsOfInterest;
  if (pois == null) {
    return [];
  }
  List<Widget> poiWidgets = [];
  for (int index = 0; index < MAX_LOCATIONS_PER_REGION; index ++) {
    bool found = false;
    for (LocalPointOfInterest poi in pois) {
      if (poi.index == index) {
        found = true;
        poiWidgets.add(getLocalPointOfInterest(poi));
      }
    }
    if (!found) {
      poiWidgets.add(Container());
    }
  }
  return poiWidgets;
}

// -----------------------------------------------------------------------------
// Gets a single point of interest as a widget
// -----------------------------------------------------------------------------
Widget getLocalPointOfInterest(LocalPointOfInterest poi) {
  Widget poiWidget = Image.asset(poi.pointOfInterestType.imageAsset.filename());  // TODO
  poiWidget = SizedBox(width: 25, child: InkWell(
        onTap: () {
          print('> tapped: ${poi.name}');
          GameState().selectedPoiInMap = poi;
          GameState().mapState.update();
        },
        child: poiWidget
    )
  );
  if (poi == GameState().selectedPoiInMap) {
    return getCardWithRoundedBorder(poiWidget);
  }
  return poiWidget;
}

// -----------------------------------------------------------------------------
// Returns grid widget with all the locations of the current region
// -----------------------------------------------------------------------------
List<Widget> getLocations(BuildContext context) {
  List<GameLocation> locations = GameState().player.currentRegion().locations;
  List<Widget> locationWidgets = [];
  for (GameLocation location in locations) {
    if (location == GameState().selectedLocationInMap) {
      locationWidgets.add(getSelectedLocationBorder(getLocationTile(location)));
    } else {
      locationWidgets.add(getLocation(location));
    }
  }
  return locationWidgets;
}

// -----------------------------------------------------------------------------
// Gets a single location as a widget
// -----------------------------------------------------------------------------
Widget getLocation(GameLocation location) {
  Widget locationWidget = getLocationTile(location);

  if (location.path && (location.unlocked || location.isConnectedToUnlockedLocation())) {
    locationWidget = InkWell(
        onTap: () {
//          print('> tapped: ${location.name}, unlocked: ${location.unlocked}');
          if (location != GameState().player.currentLocation()) {
            if (location.unlocked) {
              visitPlace(location);
            } else {
              GameState().selectedLocationInMap = location;
              GameState().mapState.update();
            }
          }
        },
        child: locationWidget
    );
  }
  return locationWidget;
}

void visitPlace(GameLocation location) {
  if (location.regionExits.isNotEmpty) {
    print('cross into adjoining region from ${location.name}');
    GameRegion newRegion = RegionFactory.crossInto(GameState().player.currentRegion(), location);
    GameState().player.setCurrentRegionTo(newRegion);
    GameState().player.setCurrentLocationTo(newRegion.currentLocation());
  } else {
    print('go to location ${location.name}');
    GameState().player.setCurrentLocationTo(location);
  }
  GameState().selectedLocationInMap = null;
  GameState().mapState.update();
}

// Background decoration variants for non-path tiles. Picked deterministically
// per location (by index) rather than randomly on each build, so a tile's
// background doesn't change across rebuilds.
const List<GameImageAsset> pineTreeBackgroundTiles = [
  GameImageAsset.map_tile_bg_pinetrees_1,
  GameImageAsset.map_tile_bg_pinetrees_2,
  GameImageAsset.map_tile_bg_pinetrees_3,
  GameImageAsset.map_tile_bg_pinetrees_4,
  GameImageAsset.map_tile_bg_pinetrees_5,
];

const List<GameImageAsset> leafTreeBackgroundTiles = [
  GameImageAsset.map_tile_bg_leaftrees_1,
  GameImageAsset.map_tile_bg_leaftrees_2,
  GameImageAsset.map_tile_bg_leaftrees_3,
  GameImageAsset.map_tile_bg_leaftrees_4,
  GameImageAsset.map_tile_bg_leaftrees_5,
];

// -----------------------------------------------------------------------------
// Builds a single map tile: layered path segment images toward path-connected
// neighbors, with the discovered/undiscovered/region-exit icon on top.
// Locations without a path render a plain background decoration instead.
// -----------------------------------------------------------------------------
Widget getLocationTile(GameLocation location) {
  if (!location.path) {
    // TODO: pick pine vs. leaf (or other biome-specific set) based on the
    // region's biome type once that exists. Hardcoded to leaf trees for now.
    GameImageAsset bg = leafTreeBackgroundTiles[location.index % leafTreeBackgroundTiles.length];
    return getMapPathTile([bg]);
  }
  List<GameImageAsset> pathImages = getPathSegmentImages(location);
  return getMapPathTile(pathImages);
}

// -----------------------------------------------------------------------------
// The "center-*" path segment images to layer for a location, one per
// direction the generator actually carved an edge through (location.
// pathConnections) - not just any grid-adjacent path-flagged neighbor.
// -----------------------------------------------------------------------------
List<GameImageAsset> getPathSegmentImages(GameLocation location) {
  List<GameImageAsset> segments = [];

  if (location.pathConnections.contains(ConnectionsDirection.north)) {
    segments.add(GameImageAsset.map_tile_center_up);
  }
  if (location.pathConnections.contains(ConnectionsDirection.south)) {
    segments.add(GameImageAsset.map_tile_center_down);
  }
  if (location.pathConnections.contains(ConnectionsDirection.west)) {
    segments.add(GameImageAsset.map_tile_center_left);
  }
  if (location.pathConnections.contains(ConnectionsDirection.east)) {
    segments.add(GameImageAsset.map_tile_center_right);
  }

  if (location.regionExits.isNotEmpty) {
    segments.add(GameImageAsset.map_tile_region);
  } else if (location.unlocked) {

    // TODO - draw different image based on type of location
    if (location.locationType == GameLocationType.village) {
      segments.add(GameImageAsset.map_tile_poi_village);
    } else {
      segments.add(GameImageAsset.map_tile_center_location);
    }


  } else {
    segments.add(GameImageAsset.map_tile_center_question_mark);
  }

  if (location == GameState().player.currentRegion().currentLocation()) {
    segments.add(GameImageAsset.map_player_position);
  }

  return segments;
}

// -----------------------------------------------------------------------------
// Get dotted border for selected, but not current, location
// -----------------------------------------------------------------------------
DottedBorder getSelectedLocationBorder(Widget content) {
  Color borderColor = Colors.white;
  double borderWidth = 0;
  //BorderStyle borderStyle = BorderStyle.solid;
  borderColor = Colors.black45;
  borderWidth = 5;
  return DottedBorder(
    borderType: BorderType.RRect,
    strokeWidth: borderWidth,
    color: borderColor,
    radius: const Radius.circular(8),
    child: content,
  );
//  return Border.all(color: borderColor, width: borderWidth);
}
