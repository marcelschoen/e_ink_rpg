
enum AttributeType {
  defense,
  money,
  level,   // player level
}

class Attribute {

  AttributeType type;
  int _value = 0;

  Attribute(this.type);

  Attribute.withValue(this.type, this._value);

  increaseValueBy(int addition) {
    _value += addition;
  }

  setValueTo(int value) {
    _value = value;
  }

  int value() {
    return _value;
  }
}
