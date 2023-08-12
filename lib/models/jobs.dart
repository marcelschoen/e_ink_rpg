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
class Job {
  String label = '';
  String description = '';
  List<JobStep> jobSteps = [];
  List<GameItem> receiveUponCompletion = [];
  List<Stat> requiredStats = [];
  JobType jobType = JobType.hunterguild;
  GameIconAsset iconAsset = GameIconAsset.scrollWithFeather;

  bool selected = false;

  Job(this.label, this.description, this.jobType);
}

// ----------------------------------------------------------
// Base class for job steps
// ----------------------------------------------------------
abstract class JobStep {
  List<GameItem> receiveUponCompletion = [];
}

// ----------------------------------------------------------
// One single wave of 1 - 5 attackers
// ----------------------------------------------------------
class AttackWave extends JobStep {
  List<Being> attackers = [];
  int level = 0;
}