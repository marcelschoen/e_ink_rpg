// Bandit related jobs


import '../../models/jobs.dart';

class EliminateBandit extends Job {
  EliminateBandit(String label, String description) : super(label, description, JobType.hunterguild);
}