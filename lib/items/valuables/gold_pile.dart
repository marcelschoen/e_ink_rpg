
import 'package:e_ink_rpg/models/item.dart';

import '../../assets.dart';

class GoldPile extends GameItem {
  // Reserved id, kept outside the ranges assigned to items loaded from JSON
  // assets (see ItemRegistry.loadJson), so it must be registered explicitly.
  static const int itemId = 1;

  GoldPile() : super.fromAsset(GameItemAsset.gold_pile) {
    id = itemId;
    name = 'Gold pile';
    description = 'Restores 0 HP';
  }
}
