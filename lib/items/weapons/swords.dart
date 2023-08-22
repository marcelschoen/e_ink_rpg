import 'package:e_ink_rpg/models/attack.dart';

import '../../assets.dart';
import '../../models/item.dart';

class RustyShortSword extends Weapon {
  RustyShortSword() : super() {
    description = 'A bit rusty and pretty weak, but it can still do some damage.';
    name = 'Rusty short sword';
    availableAttacks.add(Hit());
    availableAttacks.add(Swing());
    price = 50;
    itemAsset = GameItemAsset.shortSword;
  }
}