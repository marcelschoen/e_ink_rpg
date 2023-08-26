
import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';

class TinyHealingPotion extends Consumable {
  TinyHealingPotion() : super(GameItemAsset.potion) {
    this.name = 'Tiny Healing Potion';
    this.description = 'Restores 5 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 5, 5));
  }
}

class SmallHealingPotion extends Consumable {
  SmallHealingPotion() : super(GameItemAsset.potion) {
    this.name = '(S) Health Potion';
    this.description = 'Restores 10 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 10, 10));
  }
}

class HealingPotion extends Consumable {
  HealingPotion() : super(GameItemAsset.potion) {
    this.name = 'Health Potion';
    this.description = 'Restores 20 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 30, 30));
  }
}

class LargeHealingPotion extends Consumable {
  LargeHealingPotion() : super(GameItemAsset.potion) {
    this.name = '(L) Health Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 60, 60));
  }
}

class HugeHealingPotion extends Consumable {
  HugeHealingPotion() : super(GameItemAsset.potion) {
    this.name = 'XL Health Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 150, 150));
  }
}

class MaximumHealingPotion extends Consumable {
  MaximumHealingPotion() : super(GameItemAsset.potion) {
    this.name = 'Restore Potion';
    this.description = 'Restores all HP';
    this.statRestoreOnConsume.add(Stat.withValue(StatType.health, 0, 0));
  }
}
