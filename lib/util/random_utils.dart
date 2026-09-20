import 'dart:math';

// -----------------------------------------------------------------------------
// Picks a random key from a map of relative weights (weights don't need to
// sum to any particular total, they're just proportions relative to each other).
// -----------------------------------------------------------------------------
T weightedRandom<T>(Map<T, num> weights, Random random) {
  final total = weights.values.fold<num>(0, (sum, w) => sum + w);
  num roll = random.nextDouble() * total;
  for (final entry in weights.entries) {
    if (roll < entry.value) {
      return entry.key;
    }
    roll -= entry.value;
  }
  return weights.keys.last; // floating-point fallback, should rarely trigger
}
