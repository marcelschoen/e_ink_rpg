import 'package:e_ink_rpg/models/stat.dart';

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
  List<String> description = [];
  List<AttackWave> attackWaves = [];
  List<GameItem> receiveUponCompletion = [];
  List<Stat> requiredStats = [];
  JobType jobType = JobType.hunterguild;
}

// ----------------------------------------------------------
// One single wave of 1 - 5 attackers
// ----------------------------------------------------------
class AttackWave {
  List<Being> attackers = [];
  int level = 0;
  List<GameItem> receiveUponCompletion = [];

}