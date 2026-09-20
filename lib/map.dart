import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/explore.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/location.dart';
import 'models/map_zoom_level.dart';
import 'widgets/map_grid.dart';

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
                alignment: const Alignment(-.2, 0),
                image: AssetImage(GameImageAsset.map_paper_background_bw_transparent.filename()),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.only(top: 40),
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
                children: getMapButtons(context),
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
    details = getDetailText(GameState().selectedPoiInMap!.pointOfInterestType.label,
        GameState().selectedPoiInMap!.name, 'Check out this point of interest!');
  } else if (GameState().selectedLocationInMap != null) {
      if (GameState().selectedLocationInMap!.unlocked) {
        details = getDetailText(GameState().selectedLocationInMap!.locationType.name,
            GameState().selectedLocationInMap!.name, 'This location was explored by you already.');
      } else {
        details = getDetailText('Location',
            'Unknown', 'Explore this location to unlock it');
      }
  } else if (GameState().mapZoomLevel == MapZoomLevel.region) {
    details = getDetailText(GameState().player.currentRegion().currentLocation().locationType.name,
        GameState().player.currentRegion().currentLocation().name, 'This location was explored by you already.');
  }
  return SizedBox(width: MediaQuery.of(context).size.width / 4,
    height: MediaQuery.of(context).size.height / 5,
    child: getCardWithRoundedBorder(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: details,
      )
    )
  );
}

// -----------------------------------------------------------------------------
// Text content for box with details about selected location / poi
// -----------------------------------------------------------------------------
Column getDetailText(String label, String title, String description) {
  return Column(
    children: [
      Text(label, style: getTitleTextStyle(14)),
      Text(title, style: getTitleTextStyle(18)),
      vGap(6),
      Text(description, style: getRegularTextStyle(12)),
    ],
  );
}

// -----------------------------------------------------------------------------
// List of map context buttons
// -----------------------------------------------------------------------------
List<Widget> getMapButtons(BuildContext context) {
  List<Widget> buttons = [];
  if (GameState().selectedLocationInMap != null) {
    print ('>>> selected location in map: ${GameState().selectedLocationInMap!.name}, unlocked: ${GameState().selectedLocationInMap!.unlocked}');
    if (!GameState().selectedLocationInMap!.unlocked) {
      buttons.add(getExploreButton(context));
//    } else if (GameState().selectedLocationInMap == GameState().player.currentLocation()) {
    }
  } else {
    // Add "Visit" button for currently occupied location
    buttons.add(getVisitButton());
  }
  return buttons;
}

// -----------------------------------------------------------------------------
// Button for going to selected unlocked location
// -----------------------------------------------------------------------------
Widget getVisitButton() {
  return BaseButton.textOnlyWithSizes('Visit', (p0) {
    GameLocation location = GameState().selectedLocationInMap!;
    visitPlace(location);
  }, 18, 140, 20);
}

// -----------------------------------------------------------------------------
// Button for exploring selected location
// -----------------------------------------------------------------------------
Widget getExploreButton(BuildContext context) {
  return BaseButton.textOnlyWithSizes('Explore', (p0) {
      print('explore location ${GameState().selectedLocationInMap!.name}');
      beginExploring(GameState().selectedLocationInMap!, context);
    }, 18, 140, 20);
}

// -----------------------------------------------------------------------------
// Returns the main map contents
// -----------------------------------------------------------------------------
Widget getMapContents(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Title and zoom-in and zoom-out buttons
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 20),
            getZoomButton(false),
            Center(child: getMapTitle()),
            getZoomButton(true),
            const SizedBox(width: 20),
          ],
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16),
          // Actual map with locations
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: getMapGridContents(context)),
        ),
      ),
      Row(
        // The home / back button
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 60),
          getHomeButton()
        ],
      ),
      const SizedBox(height: 50,)
    ],
  );
}

// -----------------------------------------------------------------------------
// Title of map based on zoom-level
// -----------------------------------------------------------------------------
Widget getMapTitle() {
  if (GameState().mapZoomLevel == MapZoomLevel.world) {
    return Column(
      children: [
        getOutlinedText('World', 16, 1, Colors.black, Colors.white)
      ],
    );
  } else if (GameState().mapZoomLevel == MapZoomLevel.region) {
    return Column(children: [
      getOutlinedText('Region', 16, 1, Colors.black, Colors.white),
      getOutlinedText(GameState().player.currentRegion().name, 20, 1, Colors.black, Colors.white)
    ],
    );
  }
  return Column(
    children: [
      getOutlinedText('Location', 16, 1, Colors.black, Colors.white),
      getOutlinedText(GameState().player.currentRegion().currentLocation().name, 20, 1, Colors.black, Colors.white)
    ],
  );
}

// -----------------------------------------------------------------------------
// Reset view back to where we currently are
// -----------------------------------------------------------------------------
Widget getHomeButton() {
  return InkWell(
    onTap: () {
      GameState().mapZoomLevel = MapZoomLevel.location;
      GameState().selectedLocationInMap = GameState().player.currentLocation();
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
        } else if (currentLevel == MapZoomLevel.region) {
          GameState().mapZoomLevel = MapZoomLevel.world;
        }
      }
      GameState().selectedPoiInMap = null;
      GameState().selectedLocationInMap = null;
      GameState().mapState.update();
    },
    child: Image.asset(GameIconAsset.search.filename()),
  );
}
