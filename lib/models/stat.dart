// -----------------------------------------------------------------------------
//
// Stats are single values representing a certain aspect of a being,
// such as its current health points, speed etc. There is no upper limit.
//
// -----------------------------------------------------------------------------

enum StatType {
  health, // health points
  mana,   // needed to perform magic
  focus,  // needed to perform special melee attacks / recharges automatically
  xp,     // fills up from 0 - n, and wenn full, the player gains a level
}

/**
 * Implements handling of character stats (attributes) used
 * for things like combat / damage calculations etc.
 */
class Stat {

  StatType statType;
  double _value = 0;
  double _maxValue;

  Stat(StatType statType, double maxValue) : statType = statType, _maxValue = maxValue {
  }

  Stat.withValue(StatType statType, double value, double maxValue) : statType = statType, _value = value, _maxValue = maxValue {
  }

  double maxValue() {
    return _maxValue;
  }

  double value() {
//    print("...../ stat: " + statType.name + " / value: " + _value.toString());
    return _value;
  }

  bool isFull() {
    return _value >= _maxValue;
  }

  double progressBarValue() {
    if (_value <= 0) {
      return 0;
    }
    return 1.0 / (_maxValue.toDouble() / _value.toDouble());
  }

  void setValueTo(double newValue) {
    _value = newValue;
  }

  void setMaxValueTo(double newMaxValue) {
    _maxValue = newMaxValue;
  }

  void deplete() {
    _value = 0;
  }

  void decreaseBy(double value) {
    _value -= value;
    _value = _value < 0 ? 0 : _value;
  }

  void increaseMaxValueBy(double increase) {
    _maxValue += increase;
  }

  void restoreBy(double restoreValue) {
    _value += restoreValue;
    _value = _value > _maxValue ? _maxValue : _value;
  }

  void restore() {
    _value = _maxValue;
  }
}
