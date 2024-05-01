
import 'package:e_ink_rpg/models/item.dart';

import '../../assets.dart';

class GoldPile extends GameItem {
  GoldPile() : super.fromAsset(GameItemAsset.gold_pile) {
    name = 'Gold pile';
    description = 'Restores 0 HP';
  }
}
