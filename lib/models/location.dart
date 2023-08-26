
enum LocalPointOfInterestType {
  generalGoodsStore,
  weaponSmith,
  armorSmith,
  tavern,
  pond,
  garden
}

class LocalPointOfInterest {
  LocalPointOfInterestType pointOfInterestType;
  String name;

  LocalPointOfInterest(this.pointOfInterestType, this.name);
}



enum RegionPointOfInterestType {
  village,
  dungeon,
  cave,
  cottage,
  farm,
  bridge,
  encampment,
  castle,
  fortress,
}

class RegionPointOfInterest {
  RegionPointOfInterestType regionPointOfInterestType;
  String name;

  RegionPointOfInterest(this.regionPointOfInterestType, this.name);
}