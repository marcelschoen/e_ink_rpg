
import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/stat.dart';

import '../../assets.dart';

class TinyHealingPotion extends GameItem with Consumable {
  TinyHealingPotion() {
    this.name = 'Tiny Healing Potion';
    this.description = 'Restores 5 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 5, 5));
    this.itemAsset = GameItemAsset.potion;
  }
}

class SmallHealingPotion extends GameItem with Consumable {
  SmallHealingPotion() {
    this.name = '(S) Health Potion';
    this.description = 'Restores 10 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 10, 10));
    this.itemAsset = GameItemAsset.potion;
  }
}

class HealingPotion extends GameItem with Consumable {
  HealingPotion() {
    this.name = 'Health Potion';
    this.description = 'Restores 20 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 30, 30));
    this.itemAsset = GameItemAsset.potion;
  }
}

class LargeHealingPotion extends GameItem with Consumable {
  LargeHealingPotion() {
    this.name = '(L) Health Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 60, 60));
    this.itemAsset = GameItemAsset.potion;
  }
}

class HugeHealingPotion extends GameItem with Consumable {
  LargeHealingPotion() {
    this.name = 'XL Health Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 150, 150));
    this.itemAsset = GameItemAsset.potion;
  }
}

class MaximumHealingPotion extends GameItem with Consumable {
  MaximumHealingPotion() {
    this.name = 'Restore Potion';
    this.description = 'Restores all HP';
    this.statRestoreOnConsume.add(Stat.withValue(StatType.health, 0, 0));
    this.itemAsset = GameItemAsset.potion;
  }
}
