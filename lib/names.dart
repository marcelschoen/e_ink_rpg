import 'dart:core';

class NewNameGenerator {

  List<String> pre = [];
  List<String> mid = [];
  List<String> sur = [];

  static String vocals = 'aeiouy' ;
  static String consonants = 'bcdfghjklmnpqrstvwxy' ;


  String upper(String s) {
    return s.substring(0, 1).toUpperCase() + s.substring(1);
  }

  bool containsConsFirst(List<String> array) {
    for (String s in array) {
      if (consonantFirst(s)) return true;
    }
    return false;
  }

  bool containsVocFirst(List<String> array) {
    for (String s in array) {
      if (vocalFirst(s)) return true;
    }
    return false;
  }

  bool allowCons(List<String> array) {
    for (String s in array) {
      if (hatesPreviousVocals(s) || hatesPreviousConsonants(s) == false) return true;
    }
    return false;
  }

  bool allowVocs(List<String> array) {
    for (String s in array) {
      if (hatesPreviousConsonants(s) || hatesPreviousVocals(s) == false) return true;
    }
    return false;
  }

  bool expectsVocal(String s) {
    if (s.substring(1).contains("+v")) return true;
    else return false;
  }

  bool expectsConsonant(String s) {
    if (s.substring(1).contains("+c")) return true;
    else return false;
  }

  bool hatesPreviousVocals(String s) {
    if (s.substring(1).contains("-c")) return true;
    else return false;
  }

  bool hatesPreviousConsonants(String s) {
    if (s.substring(1).contains("-v")) return true;
    else return false;
  }

  String pureSyl(String s) {
    s = s.trim();
    if (s[0] == '+' || s[0] == '-') s = s.substring(1);
    return s.split(" ")[0];
  }

  bool vocalFirst(String s) {
    return vocals.contains(s[0].toLowerCase());
  }

  bool consonantFirst(String s) {
    return consonants.contains(s[0].toLowerCase());
  }

  bool vocalLast(String s) {
    return vocals.contains(s[(s.length - 1)].toLowerCase());
  }

  bool consonantLast(String s) {
    return consonants.contains(s[(s.length - 1)].toLowerCase());
  }

}
