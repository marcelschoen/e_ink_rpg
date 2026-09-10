// ----------------------------------------------
// Runes provide magic abilities and attacks.
// They can be equiped with special gear.
// ----------------------------------------------

import 'magic.dart';

// ----------------------------------------------
// Base class for all runes
// ----------------------------------------------
abstract class Rune {
  String name = 'rune';
  String description = '';
  List<Spell> spells = [];
}

// ------------------------------------------
// Simple fireball rune
// ------------------------------------------
class RuneRagnor extends Rune {
  RuneRagnor() {
    name = 'Rune of Ragnor';
    description = 'Old rune with a simple fireball spell.';
    spells.add(Fireball());
  }
}