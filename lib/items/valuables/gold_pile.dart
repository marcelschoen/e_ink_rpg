
import 'package:e_ink_rpg/models/item.dart';

import '../../assets.dart';

class GoldPile extends GameItem {
  GoldPile() {
    this.name = 'Gold pile';
    this.description = 'Restores 0 HP';
    this.itemAsset = GameItemAsset.gold_pile;
  }
}
