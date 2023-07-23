import 'package:flutter/foundation.dart';

import 'models/beings.dart';

class GameState with ChangeNotifier {

  // singleton instance
  static final GameState _instance = GameState._internal();

  Player player = Player();

  GameState._internal() {
  }

  factory GameState() {
    return _instance;
  }

  update() {
    notifyListeners();
  }

  @override
  void dispose() {
    // NOTE: For some reason, someone is invoking this "dispose", which destroys
    // our singleton player state holder.
    //super.dispose();
  }
}