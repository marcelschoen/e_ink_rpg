


import 'dart:math';

import '../assets.dart';

class Exploration {
  List<ExplorationStep> steps;
  int _currentStep = 0;
  Exploration(Random locationRandom, int explorationSteps) : steps = ExplorationStepFactory.createExplorationSteps(locationRandom, explorationSteps);

  ExplorationStep currentStep() {
    return steps[_currentStep];
  }

  nextStep() {
    _currentStep ++;
  }

  bool isComplete() {
    return _currentStep >= steps.length;
  }
}

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
    GameImageAsset.map_loc_hill_1,
    GameImageAsset.map_loc_hill_2,
    GameImageAsset.map_loc_hill_3,
    GameImageAsset.map_loc_hill_4,
    GameImageAsset.map_loc_hill_5,
    GameImageAsset.map_loc_hill_6,
  ];

  List<GameImageAsset> gameImageAssets;

  ExplorationStep(Random loctionRandom) : gameImageAssets = createListOfImages(loctionRandom) {}

  static List<GameImageAsset> createListOfImages(Random random) {
    List<GameImageAsset> images = [];
    for (int i = 0; i < 5; i++) {
      images.add(ExplorationImages[random.nextInt(ExplorationImages.length)]);
    }
    return images;
  }
}

class ExplorationStepFactory {
  static List<ExplorationStep> createExplorationSteps(Random locationRandom, int number) {
    List<ExplorationStep> steps = [];
    for (int i = 0; i < number; i++) {
      steps.add(ExplorationStep(locationRandom));
    }
    return steps;
  }
}