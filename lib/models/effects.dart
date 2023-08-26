// TODO - decide if effects are necessary

enum EffectType {
  invisibility,
  invincibility,
}

// TODO - add cooldown / maybe special triggers? manual?

class Effect {
  bool unlimited = false;
  int effectCounter = 0;
  EffectType type;

  Effect(this.type, this.effectCounter, this.unlimited);
}
