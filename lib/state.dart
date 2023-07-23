import 'package:flutter/foundation.dart';

import 'models/beings.dart';

/**
 * Singleton game state holder.
 */
class GameState with ChangeNotifier {

  // singleton instance
  static final GameState _instance = GameState._internal();

  final Player player = Player();

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
    print("******************** DISPOSE GAME STATE ********************");
    // NOTE: For some reason, someone is invoking this "dispose", which destroys
    // our singleton player state holder.
    //super.dispose();
  }
}



/**
 * Singleton game state holder.
 */
class MonsterState with ChangeNotifier {

  final Being _monster;

  MonsterState(Being monster) : _monster = monster {}

  Being monster() {
    return _monster;
  }

  update() {
    notifyListeners();
  }
}