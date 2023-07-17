

enum StatType {
  health,
  strength,
  defense,
}

class Stat {

  StatType statType;
  var _value = 0;
  var _maxValue;

  Stat(StatType statType, int maxValue) : statType = statType, _maxValue = maxValue {
  }

  int value() {
    return _value;
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