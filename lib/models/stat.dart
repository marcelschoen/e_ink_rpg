enum StatType {
  health,
  strength,
  defense,
}

/**
 * Implements handling of character stats (attributes) used
 * for things like combat / damage calculations etc.
 */
class Stat {

  StatType statType;
  var _value = 0;
  var _maxValue;

  Stat(StatType statType, int maxValue) : statType = statType, _maxValue = maxValue {
  }

  Stat.withValue(StatType statType, int value, int maxValue) : statType = statType, _value = value, _maxValue = maxValue {
  }

  int maxValue() {
    return _maxValue;
  }

  int value() {
//    print("...../ stat: " + statType.name + " / value: " + _value.toString());
    return _value;
  }

  void setValueTo(int newValue) {
    _value = newValue;
  }

  void setMaxValueTo(int newMaxValue) {
    _maxValue = newMaxValue;
  }

  void deplete() {
    _value = 0;
  }

  void decreaseBy(int value) {
    _value -= value;
    _value = _value < 0 ? 0 : _value;
  }

  void increaseMaxValueBy(int increase) {
    _maxValue += increase;
  }

  void restoreBy(int restoreValue) {
    _value += restoreValue;
    _value = _value > _maxValue ? _maxValue : _value;
  }

  void restore() {
    _value = _maxValue;
  }
}
