import 'package:e_ink_rpg/models/stat.dart';

import '../assets.dart';
import 'beings.dart';
import 'item.dart';

// ----------------------------------------------------------
// ----------------------------------------------------------
enum JobType {
  hunterguild,
  city,
  npc
}

// ----------------------------------------------------------
// A job (aka quest) which contains of 1-n attack waves
// ----------------------------------------------------------
abstract class Job {
  String label = '';
  String description = '';
  List<JobStep> jobSteps = [];
  JobStep? currentStep = null;
  List<GameItem> receiveUponCompletion = [];
  List<Stat> requiredStats = [];
  JobType jobType = JobType.hunterguild;
  GameIconAsset iconAsset = GameIconAsset.scrollWithFeather;

  bool finished = false;
  bool selected = false;

  // bounty for getting job done
  int xp = 10;
  List<GameItem> loot = [];

  Job(this.label, this.description, this.jobType, this.xp) {
    JobStep? lastStep = null;
    for (JobStep step in getJobSteps()) {
      jobSteps.add(step);
      if (lastStep != null) {
        lastStep.nextStep = step;
      }
    }
    if (!jobSteps.isEmpty) {
      currentStep = jobSteps.first;
    }
  }

  nextStep() {
    currentStep = currentStep!.nextStep;
    if (currentStep == null) {
      // last step was completed
      finished = true;
    }
  }

  addStep(JobStep step) {
    if (!jobSteps.isEmpty) {
      jobSteps.last.nextStep = step;
    }
    jobSteps.add(step);
    if (currentStep == null) {
      currentStep = step;
    }
  }

  List<JobStep> getJobSteps();
}

// ----------------------------------------------------------
// Base class for job steps
// ----------------------------------------------------------
class JobStep {
  List<GameItem> receiveUponCompletion = [];
  List<Being> attackers = [];
  int level = 0;
  JobStep? nextStep = null;
}
