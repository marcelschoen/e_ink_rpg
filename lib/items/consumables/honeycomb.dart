
import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';

class Honeycomb extends GameItem with Consumable {
  Honeycomb() : super() {
    this.name = 'Honeycomb';
    this.description = 'Restores 1 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 1, 1));
    this.itemAsset = GameItemAsset.honeycomb;
  }
}
