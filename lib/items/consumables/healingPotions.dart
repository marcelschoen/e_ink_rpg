
import 'package:e_ink_rpg/models/item.dart';
import 'package:e_ink_rpg/models/stat.dart';

class TinyHealingPotion extends GameItem with Consumable {
  TinyHealingPotion() {
    this.name = 'Tiny Healing Potion';
    this.description = 'Restores 5 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 5, 5));
  }
}

class SmallHealingPotion extends GameItem with Consumable {
  SmallHealingPotion() {
    this.name = 'Small Healing Potion';
    this.description = 'Restores 10 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 10, 10));
  }
}

class HealingPotion extends GameItem with Consumable {
  HealingPotion() {
    this.name = 'Healing Potion';
    this.description = 'Restores 20 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 30, 30));
  }
}

class LargeHealingPotion extends GameItem with Consumable {
  LargeHealingPotion() {
    this.name = 'Large Healing Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 60, 60));
  }
}

class HugeHealingPotion extends GameItem with Consumable {
  LargeHealingPotion() {
    this.name = 'Large Healing Potion';
    this.description = 'Restores 35 HP';
    this.statValueBoostsOnConsume.add(Stat.withValue(StatType.health, 150, 150));
  }
}

class MaximumHealingPotion extends GameItem with Consumable {
  LargeHealingPotion() {
    this.name = 'Maximum Healing Potion';
    this.description = 'Restores all HP';
    this.statRestoreOnConsume.add(Stat.withValue(StatType.health, 0, 0));
  }
}
