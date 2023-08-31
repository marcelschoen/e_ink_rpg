import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/location.dart';

enum MapZoomLevel {
  world,
  region,
  location
}

List<GameImageAsset> locationImage = [
  GameImageAsset.map_loc_custom_dungeon_entrance,

  GameImageAsset.map_loc_bridge_east_west,
  GameImageAsset.map_loc_bridge_north_south,
  GameImageAsset.map_loc_castle,
  GameImageAsset.map_loc_castle_2,
  GameImageAsset.map_loc_city,
  GameImageAsset.map_loc_city_2,
  GameImageAsset.map_loc_crevasse,
  GameImageAsset.map_loc_dead_tree_1,
  GameImageAsset.map_loc_dead_tree_2,
  GameImageAsset.map_loc_dunes,
  GameImageAsset.map_loc_fortress,
  GameImageAsset.map_loc_hamlet,
  GameImageAsset.map_loc_hill_1,

  GameImageAsset.map_loc_jungle_tree_1,

  GameImageAsset.map_loc_marsh,

  GameImageAsset.map_loc_mesa_1,
  GameImageAsset.map_loc_mesa_2,

  GameImageAsset.map_loc_monolith,

  GameImageAsset.map_loc_mountain_1,
  GameImageAsset.map_loc_mountain_2,
  GameImageAsset.map_loc_mountain_3,
  GameImageAsset.map_loc_mountain_4,
  GameImageAsset.map_loc_mountain_5,
  GameImageAsset.map_loc_mountain_6,
  GameImageAsset.map_loc_mountain_large_1,
  GameImageAsset.map_loc_mountain_large_2,
  GameImageAsset.map_loc_mountain_large_3,
  GameImageAsset.map_loc_mountain_large_4,
  GameImageAsset.map_loc_oasis,
  GameImageAsset.map_loc_mountain_peak_1,
  GameImageAsset.map_loc_mountain_peak_2,
  GameImageAsset.map_loc_pine_tree_1,
  GameImageAsset.map_loc_pine_tree_2,
  GameImageAsset.map_loc_pine_tree_3,
  GameImageAsset.map_loc_pine_tree_4,
  GameImageAsset.map_loc_pine_tree_5,
  GameImageAsset.map_loc_pine_tree_6,
  GameImageAsset.map_loc_ridge,
  GameImageAsset.map_loc_ruin_large,
  GameImageAsset.map_loc_ruin_small,
  GameImageAsset.map_loc_square_tower,
  GameImageAsset.map_loc_standing_stones,
  GameImageAsset.map_loc_mesa_1,
  GameImageAsset.map_loc_mesa_2,
];

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------
Widget getMapScreen(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-.2, 0),
                image: AssetImage(GameImageAsset.map_paper_background_bw_transparent.filename()),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 40),
          child: ListenableBuilder(
              listenable: GameState().mapState,
              builder: (BuildContext context, Widget? child) {
                return getMapContents(context);
              },
            ),
        ),
      ),
      ListenableBuilder(
        listenable: GameState().mapState,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children:[
              getDetailInfos(context),
              Column(
                children: getMapButtons(),
              )
            ]
          );
        },
      )
    ],
  );
}

// -----------------------------------------------------------------------------
// Box for details about selected location / poi
// -----------------------------------------------------------------------------
Widget getDetailInfos(BuildContext context) {
  Widget details = Container();
  if (GameState().selectedPoiInMap != null) {
    details = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(GameState().selectedPoiInMap!.pointOfInterestType.label, style: getTitleTextStyle(14)),
          Text(GameState().selectedPoiInMap!.name, style: getTitleTextStyle(18)),
          vGap(6),
          Text('Some description goes here because anyway', style: getRegularTextStyle(12)),
        ],
      ),
    );
  }
  return SizedBox(width: MediaQuery.of(context).size.width / 4,
    height: MediaQuery.of(context).size.height / 5,
    child: getCardWithRoundedBorder(
      details
    )
  );
}


// -----------------------------------------------------------------------------
// List of map context buttons
// -----------------------------------------------------------------------------
List<Widget> getMapButtons() {
  List<Widget> buttons = [];
  if (GameState().selectedLocationInMap != null) {
    if (!GameState().selectedLocationInMap!.unlocked) {
      buttons.add(getSelectedPlaceButton());
    } else {
      /*
      for ( LocalPointOfInterest poi in GameState().selectedLocationInMap!.localPointsOfInterest) {
        buttons.add(BaseButton.textOnlyWithSizes(poi.name, (p0) { print('go to: ' + poi.name); }, 18, 160, 30));
      }

       */
    }
  }
  return buttons;
}

// -----------------------------------------------------------------------------
// Button for interaction with selected map location
// -----------------------------------------------------------------------------
Widget getSelectedPlaceButton() {
  return BaseButton.textOnlyWithSizes('Explore', (p0) { print('explore location ' + GameState().selectedLocationInMap!.name); }, 18, 140, 20);
}

// -----------------------------------------------------------------------------
// Returns the main map contents
// -----------------------------------------------------------------------------
Widget getMapContents(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 20),
            getZoomButton(false),
            getMapTitle(),
            getZoomButton(true),
            SizedBox(width: 20),
          ],
        ),
      ),
      Expanded(child: getMapGridContents(context)),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 60),
          getHomeButton()
        ],
      ),
      SizedBox(height: 50,)
    ],
  );
}

// -----------------------------------------------------------------------------
// Title of map based on zoom-level
// -----------------------------------------------------------------------------
Widget getMapTitle() {
  if (GameState().mapZoomLevel == MapZoomLevel.world) {
    return getOutlinedText('World', 24, 1, Colors.black, Colors.white);
  } else if (GameState().mapZoomLevel == MapZoomLevel.region) {
    return getOutlinedText('Region: ' + GameState().currentRegion.name, 24, 1, Colors.black, Colors.white);
  }
  return getOutlinedText('Location: ' + GameState().currentRegion.currentLocation!.name, 24, 1, Colors.black, Colors.white);
}

// -----------------------------------------------------------------------------
// Reset view back to where we currently are
// -----------------------------------------------------------------------------
Widget getHomeButton() {
  return InkWell(
    onTap: () {
      GameState().mapZoomLevel = MapZoomLevel.location;
      GameState().selectedLocationInMap = GameState().currentRegion.currentLocation;
      GameState().mapState.update();
    },
    child: Image.asset(GameIconAsset.goback.filename()),
  );
}

// -----------------------------------------------------------------------------
// Map zoom level buttons
// -----------------------------------------------------------------------------
Widget getZoomButton(bool zoomIn) {
  MapZoomLevel currentLevel = GameState().mapZoomLevel;
  return InkWell(
    onTap: () {
      if (zoomIn) {
        if (currentLevel == MapZoomLevel.region) {
          GameState().mapZoomLevel = MapZoomLevel.location;
        } else if (currentLevel == MapZoomLevel.world) {
          GameState().mapZoomLevel = MapZoomLevel.region;
        }
      } else {
        if (currentLevel == MapZoomLevel.location) {
          GameState().mapZoomLevel = MapZoomLevel.region;
          GameState().selectedPoiInMap = null;
        } else if (currentLevel == MapZoomLevel.region) {
          GameState().mapZoomLevel = MapZoomLevel.world;
        }
      }
      GameState().mapState.update();
    },
    child: Image.asset(GameIconAsset.search.filename()),
  );
}

// -----------------------------------------------------------------------------
// Returns the map grid, based on zoom level
// -----------------------------------------------------------------------------
Widget getMapGridContents(BuildContext context) {
  List<Widget> mapGridWidgets = [];
  if (GameState().mapZoomLevel == MapZoomLevel.region) {
    mapGridWidgets = getLocations(context);
  } else if (GameState().mapZoomLevel == MapZoomLevel.world) {
  } else {
    mapGridWidgets = getPointsOfInterest(context);
  }
  return Padding(
    padding: const EdgeInsets.only(left:80, top: 30, right: 50),
    child: GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        // Generate 100 widgets that display their index in the List.
        children:mapGridWidgets
    ),
  );
}

// -----------------------------------------------------------------------------
// Returns grid widget with all the point of interest of the current location
// -----------------------------------------------------------------------------
List<Widget> getPointsOfInterest(BuildContext context) {
  if (GameState().currentRegion.currentLocation == null) {
    return [];
  }
  List<LocalPointOfInterest>? pois = GameState().currentRegion.currentLocation!.localPointsOfInterest;
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
          print('> tapped: ' + poi.name);
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
  print ('get locations in map...');
  List<GameLocation> locations = GameState().currentRegion.locations;
  List<Widget> locationWidgets = [];
  for (GameLocation location in locations) {
    if (!location.unlocked && !location.isConnectedToUnlockedLocation() ) {
      locationWidgets.add(getEmptyField());
    } else {
      // TODO
      locationWidgets.add(getLocation(location));
    }
  }
  return locationWidgets;
}

// -----------------------------------------------------------------------------
// Gets a single location as a widget
// -----------------------------------------------------------------------------
Widget getLocation(GameLocation location) {
  Widget locationWidget = location.unlocked ?
    Image.asset(GameImageAsset.map_loc_hamlet.filename()) :
    Image.asset(GameImageAsset.map_icon_question_mark.filename());

  if (GameState().currentRegion.currentLocation == location) {
    locationWidget = Image.asset(GameImageAsset.map_loc_hamlet.filename());
  }

  if (location.unlocked || location.isConnectedToUnlockedLocation()) {
    locationWidget = InkWell(
        onTap: () {
          print('> tapped: ' + location.name + ', unlocked: ' + location.unlocked.toString());
          GameState().selectedLocationInMap = location;
          GameState().mapState.update();
        },
        child: locationWidget
    );
  }

  if (location == GameState().currentRegion.currentLocation) {
    return SizedBox(width: 25, child: getCardWithRoundedBorder(locationWidget));
  }
  return SizedBox(width: 25, child: locationWidget);
}

// -----------------------------------------------------------------------------
// Gets a question mark or empty widget for unlocked loc
// -----------------------------------------------------------------------------
Widget getEmptyField() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(),
  );
}

