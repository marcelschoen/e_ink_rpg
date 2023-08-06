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

// ----------------------------------------------
// Optional additional spell(s) can be enabled
// when certain runes are used in combination
// ----------------------------------------------
class SpecialSpellEnabling {
  List<Rune> requiredRunes = [];
  List<Spell> spells = [];
}


// ------------------------------------------
// Simple fireball rune
// ------------------------------------------
class RuneRagnor extends Rune {
  RuneRagnor() {
    this.name = 'Rune of Ragnor';
    this.description = 'Old rune with a simple fireball spell.';
    this.spells.add(Fireball());
  }
}