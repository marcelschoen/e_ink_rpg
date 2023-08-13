// Bandit related jobs


import 'package:e_ink_rpg/models/beings.dart';

import '../../models/jobs.dart';

class Bandit extends Being with Humanoid {
  Bandit() : super(SpeciesType.npc) ;
}

class EliminateBandit extends Job {

  final int numberOfBandits;

  EliminateBandit(String label, String description, this.numberOfBandits) : super(label, description, JobType.hunterguild);

  List<JobStep> getJobSteps() {
    List<JobStep> steps = [];

    JobStep bandit = JobStep();
    steps.add(bandit);
    int stepCounter = 0;
    for (int enemyNo = 0; enemyNo < numberOfBandits; enemyNo++) {
      bandit.attackers.add(Bandit());
      stepCounter ++;
      if (stepCounter == 5) {
        // One attack wave can have 5 enemies max
        bandit = JobStep();
        steps.add(bandit);
        stepCounter = 0;
      }
    }

    return steps;
  }
}