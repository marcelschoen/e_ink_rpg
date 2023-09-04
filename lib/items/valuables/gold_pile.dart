
import 'package:e_ink_rpg/models/item.dart';

import '../../assets.dart';

class GoldPile extends GameItem {
  GoldPile() : super.fromAsset(GameItemAsset.gold_pile) {
    this.name = 'Gold pile';
    this.description = 'Restores 0 HP';
  }
}
