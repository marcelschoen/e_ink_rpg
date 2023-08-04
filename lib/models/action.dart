

import '../assets.dart';

// ---------------------------------------------------------------
// Base class for actions (not attacks or spells)
// ---------------------------------------------------------------
abstract class GameAction {

  String iconFilename = '';

  GameAction(this.iconFilename);

  perform() {}
}

// ---------------------------------------------------------------
// Spying on enemy to retrieve information about weaknesses etc.
// ---------------------------------------------------------------
class Spy extends GameAction {

  Spy() : super(GameIcon.spy.filename()) ;

  perform() {
    print(">>> SPY <<<");
  }
}