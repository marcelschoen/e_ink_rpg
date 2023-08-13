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

  bool selected = false;

  Job(this.label, this.description, this.jobType) {
    jobSteps.addAll(getJobSteps());
    currentStep = jobSteps.first;
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
}
