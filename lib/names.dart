import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';

class NameGeneratorException implements Exception {

  String cause;

  NameGeneratorException(this.cause);
  
  String toString() {
    return 'Error caused by ' + cause;
  }
}

enum NameGroup {
  all,
  elven,
  fantasy,
  goblin,
  roman
}

class NewNameGenerator {

  static String vocals = 'aeiouy' ;
  static String consonants = 'bcdfghjklmnpqrstvwxy' ;

  Random random = new Random();

  List<String> pre = [];
  List<String> mid = [];
  List<String> sur = [];

  String syllablesFile = '';
  String content = '';
  NameGroup group;

  NewNameGenerator(this.group) {
    loadAssets();
  }

  loadAssets() async {
    print('-------------> Loading text assets for: ' + this.group.toString() + ' ...');
    syllablesFile = this.group.name + '.txt';
    content = await loadAsset(syllablesFile);
    List<String> _lines = LineSplitter().convert(content);
    for (String line in _lines) {
      if (line != null && line != "") {
        if (line[0] == '-') {
          pre.add(line.substring(1).toLowerCase());
        } else if (line[0] == '+') {
          sur.add(line.substring(1).toLowerCase());
        } else {
          mid.add(line.toLowerCase());
        }
      }
    }
    print('-------------> Text assets loaded.');
  }

  Future<String> loadAsset(String filename) async {
    return await rootBundle.loadString('assets/names/' + filename);
  }

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

  String compose(int syllables) {
    if (syllables > 2 && mid.length == 0)
      throw new NameGeneratorException("You are trying to create a name with more than 3 parts, which requires middle parts, " +
          "which you have none in the file " + syllablesFile + ". You should add some. Every word, which doesn't have + or - for a prefix is counted as a middle part.");
    if (pre.length == 0)
      throw new NameGeneratorException("You have no prefixes to start creating a name. add some and use \"-\" prefix, to identify it as a prefix for a name. (example: -asd)");
    if (sur.length == 0)
      throw new NameGeneratorException("You have no suffixes to end a name. add some and use \"+\" prefix, to identify it as a suffix for a name. (example: +asd)");
    if (syllables < 1) throw new NameGeneratorException("compose(int syls) can't have less than 1 syllable");
    int expecting = 0; // 1 for vocal, 2 for consonant
    int last = 0; // 1 for vocal, 2 for consonant
    String name;
    int a = random.nextInt(pre.length);

    if (vocalLast(pureSyl(pre[a]))) last = 1;
    else last = 2;

    if (syllables > 2) {
      if (expectsVocal(pre[a])) {
        expecting = 1;
        if (containsVocFirst(mid) == false)
          throw new NameGeneratorException("Expecting \"middle\" part starting with vocal, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
      if (expectsConsonant(pre[a])) {
        expecting = 2;
        if (containsConsFirst(mid) == false)
          throw new NameGeneratorException("Expecting \"middle\" part starting with consonant, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
    } else {
      if (expectsVocal(pre[a])) {
        expecting = 1;
        if (containsVocFirst(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part starting with vocal, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
      if (expectsConsonant(pre[a])) {
        expecting = 2;
        if (containsConsFirst(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part starting with consonant, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
    }
    if (vocalLast(pureSyl(pre[a])) && allowVocs(mid) == false)
      throw new NameGeneratorException("Expecting \"middle\" part that allows last character of prefix to be a vocal, " +
          "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the prefix used, was : \"" + pre[a] + "\", which" +
          "means there should be a part available, that has \"-v\" requirement or no requirements for previous syllables at all.");

    if (consonantLast(pureSyl(pre[a])) && allowCons(mid) == false)
      throw new NameGeneratorException("Expecting \"middle\" part that allows last character of prefix to be a consonant, " +
          "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the prefix used, was : \"" + pre[a] + "\", which" +
          "means there should be a part available, that has \"-c\" requirement or no requirements for previous syllables at all.");

    List<int> b = [syllables];
    for (int i = 0; i < b.length - 2; i++) {

      do {
        b[i] = random.nextInt(mid.length);
        //System.out.println("exp " +expecting+" vocalF:"+vocalFirst(mid.get(b[i]))+" syl: "+mid.get(b[i]));
      }
      while (expecting == 1 && vocalFirst(pureSyl(mid[b[i]])) == false || expecting == 2 && consonantFirst(pureSyl(mid[b[i]])) == false
          || last == 1 && hatesPreviousVocals(mid[b[i]]) || last == 2 && hatesPreviousConsonants(mid[b[i]]));

      expecting = 0;
      if (expectsVocal(mid[b[i]])) {
        expecting = 1;
        if (i < b.length - 3 && containsVocFirst(mid) == false)
          throw new NameGeneratorException("Expecting \"middle\" part starting with vocal, " +
              "but there is none. You should add one, or remove requirement for one.. ");
        if (i == b.length - 3 && containsVocFirst(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part starting with vocal, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
      if (expectsConsonant(mid[b[i]])) {
        expecting = 2;
        if (i < b.length - 3 && containsConsFirst(mid) == false)
          throw new NameGeneratorException("Expecting \"middle\" part starting with consonant, " +
              "but there is none. You should add one, or remove requirement for one.. ");
        if (i == b.length - 3 && containsConsFirst(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part starting with consonant, " +
              "but there is none. You should add one, or remove requirement for one.. ");
      }
      if (vocalLast(pureSyl(mid[b[i]])) && allowVocs(mid) == false && syllables > 3)
        throw new NameGeneratorException("Expecting \"middle\" part that allows last character of last syllable to be a vocal, " +
            "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the part used, was : \"" + mid[b[i]] + "\", which " +
            "means there should be a part available, that has \"-v\" requirement or no requirements for previous syllables at all.");

      if (consonantLast(pureSyl(mid[b[i]])) && allowCons(mid) == false && syllables > 3)
        throw new NameGeneratorException("Expecting \"middle\" part that allows last character of last syllable to be a consonant, " +
            "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the part used, was : \"" + mid[b[i]] + "\", which " +
            "means there should be a part available, that has \"-c\" requirement or no requirements for previous syllables at all.");
      if (i == b.length - 3) {
        if (vocalLast(pureSyl(mid[b[i]])) && allowVocs(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part that allows last character of last syllable to be a vocal, " +
              "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the part used, was : \"" + mid[b[i]] + "\", which " +
              "means there should be a suffix available, that has \"-v\" requirement or no requirements for previous syllables at all.");

        if (consonantLast(pureSyl(mid[b[i]])) && allowCons(sur) == false)
          throw new NameGeneratorException("Expecting \"suffix\" part that allows last character of last syllable to be a consonant, " +
              "but there is none. You should add one, or remove requirements that cannot be fulfilled.. the part used, was : \"" + mid[b[i]] + "\", which " +
              "means there should be a suffix available, that has \"-c\" requirement or no requirements for previous syllables at all.");
      }
      if (vocalLast(pureSyl(mid[b[i]]))) {
        last = 1;
      }
      else {
        last = 2;
      }
    }

    int c;
    do {
      c = random.nextInt(sur.length);
    }
    while (expecting == 1 && vocalFirst(pureSyl(sur[c])) == false || expecting == 2 && consonantFirst(pureSyl(sur[c])) == false
        || last == 1 && hatesPreviousVocals(sur[c]) || last == 2 && hatesPreviousConsonants(sur[c]));

    name = upper(pureSyl(pre[a].toLowerCase()));
    for (int i = 0; i < b.length - 2; i++) {
      name = name + pureSyl(mid[b[i]].toLowerCase());
    }
    if (syllables > 1)
      name = name + pureSyl(sur[c].toLowerCase());
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }
}

class NameHandler {

  static NewNameGenerator allNames = NewNameGenerator(NameGroup.all);
  static NewNameGenerator elvenNames = NewNameGenerator(NameGroup.elven);
  static NewNameGenerator fantasyNames = NewNameGenerator(NameGroup.fantasy);
  static NewNameGenerator goblinNames = NewNameGenerator(NameGroup.goblin);
  static NewNameGenerator romanNames = NewNameGenerator(NameGroup.roman);

  // singleton instance
  static final NameHandler _instance = NameHandler._internal();

  NameHandler._internal() {
  }

  factory NameHandler() {
    Future<String> getFileData(String path) async {
      return await rootBundle.loadString(path);
    }

    return _instance;
  }

}
