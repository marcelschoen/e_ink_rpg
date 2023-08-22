
import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';

class Choko extends GameItem with Consumable {
  Choko() : super() {
    this.name = 'Choko';
    this.description = 'Restores 1 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 1, 1));
    this.itemAsset = GameItemAsset.choko;
  }
}
