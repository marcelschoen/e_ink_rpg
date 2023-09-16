// -----------------------------------------------------------------------------
//
// Attributes are single values representing a certain aspect of a being,
// such as the current level, speed etc. There is no upper limit.
//
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------
// Types of attributes
// -----------------------------------------------------------------------------
enum AttributeType {
  defense,        // defense value
  money,          // amount of money possessed
  killXp,         // XP that the opposing party receives upon successful kill
  level,          // player level
  speed,          // speed / affects combat turn order
  speedCounter,   // used for speed / turn calculations

  attackPower,    // attack power of weapons

  price,          // purchase price of item
}

// -----------------------------------------------------------------------------
// Holds information about one attribute
// -----------------------------------------------------------------------------
class Attribute {

  AttributeType type;
  double _value = 0;

  Attribute(this.type);

  Attribute.withValue(this.type, this._value);

  increaseValueBy(double addition) {
    _value += addition;
  }

  setValueTo(double value) {
    _value = value;
  }

  double value() {
    return _value;
  }
}
