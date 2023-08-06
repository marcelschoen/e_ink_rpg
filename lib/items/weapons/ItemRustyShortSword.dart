import 'package:e_ink_rpg/models/attack.dart';

import '../../assets.dart';
import '../../models/item.dart';

class RustyShortSword extends GameItem with Weapon {

  RustyShortSword() {
    this.description = 'A bit rusty and pretty weak.';
    this.name = 'Rusty short sword';
    this.availableAttacks.add(Hit());
    this.availableAttacks.add(Swing());
    this.price = 50;
    this.itemAsset = GameItemAsset.rustyShortSword;
  }

}