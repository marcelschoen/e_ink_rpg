import 'package:e_ink_rpg/assets.dart';

// -----------------------------------------------------------------------------
// Points of interest in the current location (e.g. shops, taverns etc.)
// -----------------------------------------------------------------------------
enum LocalPointOfInterestType {
  generalGoodsStore(GameImageAsset.map_poi_shop_interior, 'General Goods'),
  weaponSmith(GameImageAsset.map_poi_shop_interior, 'Weapon Smith'),
  armorSmith(GameImageAsset.map_poi_shop_interior, 'Armor Smith'),
  tavern(GameImageAsset.map_loc_hamlet, 'Tavern'),
  pond(GameImageAsset.map_loc_monolith, 'Pond'),
  garden(GameImageAsset.map_loc_ruin_small, 'Garden'),
  ;

  final GameImageAsset imageAsset;
  final String label;

  const LocalPointOfInterestType(this.imageAsset, this.label);

}

// -----------------------------------------------------------------------------
// Local point of view within a location (e.g. shop, tavern, pond...)
// -----------------------------------------------------------------------------
class LocalPointOfInterest {
  int index;
  LocalPointOfInterestType pointOfInterestType;
  String name;

  LocalPointOfInterest(this.pointOfInterestType, this.name, this.index);
}
