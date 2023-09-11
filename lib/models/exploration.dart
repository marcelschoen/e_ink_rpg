import 'dart:math';

import 'package:e_ink_rpg/daytime.dart';

import '../assets.dart';
import '../state.dart';

// -----------------------------------------------------------------------------
// Holds information about the current exploration
// -----------------------------------------------------------------------------
class Exploration {
  List<ExplorationStep> steps;
  int _currentStep = 0;
  Exploration(Random locationRandom, int explorationSteps) : steps = ExplorationStepFactory.createExplorationSteps(locationRandom, explorationSteps);

  ExplorationStep currentStep() {
    return steps[_currentStep];
  }

  double completionPercentage() {
    return (_currentStep * 100) / steps.length;
  }

  nextStep() {
    print('> current step: ' + _currentStep.toString());
    GameDaytime().advanceByMinutes(15);
    _currentStep ++;
    if (_currentStep < steps.length) {
      GameState().explorationState.update();
    }
  }

  bool isComplete() {
    return _currentStep >= steps.length;
  }
}

// -----------------------------------------------------------------------------
// Holds information about one step of the exploration
// -----------------------------------------------------------------------------
class ExplorationStep {

  static List<GameImageAsset> ExplorationImages = [
    GameImageAsset.map_loc_hill_1,
    GameImageAsset.map_loc_hill_2,
    GameImageAsset.map_loc_hill_3,
    GameImageAsset.map_loc_hill_4,
    GameImageAsset.map_loc_hill_5,
    GameImageAsset.map_loc_hill_6,
    GameImageAsset.map_loc_dead_tree_1,
    GameImageAsset.map_loc_dead_tree_2,
    GameImageAsset.map_loc_dunes,
    GameImageAsset.map_loc_pine_tree_1,
    GameImageAsset.map_loc_pine_tree_2,
    GameImageAsset.map_loc_pine_tree_3,
    GameImageAsset.map_loc_pine_tree_4,
    GameImageAsset.map_loc_pine_tree_5,
    GameImageAsset.map_loc_pine_tree_6,
  ];

  List<GameImageAsset> gameImageAssets;

  ExplorationStep(Random loctionRandom) : gameImageAssets = createListOfImages(loctionRandom) {}

  static List<GameImageAsset> createListOfImages(Random random) {
    List<GameImageAsset> images = [];
    for (int i = 0; i < 5; i++) {
      int imageIndex = random.nextInt(ExplorationImages.length);
      images.add(ExplorationImages[imageIndex]);
    }
    return images;
  }
}

// -----------------------------------------------------------------------------
// Creates exploration steps
// -----------------------------------------------------------------------------
class ExplorationStepFactory {
  static List<ExplorationStep> createExplorationSteps(Random locationRandom, int number) {
    List<ExplorationStep> steps = [];
    for (int i = 0; i < number; i++) {
      steps.add(ExplorationStep(locationRandom));
    }
    return steps;
  }
}