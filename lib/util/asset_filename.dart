// -----------------------------------------------------------------------------
// Shared "asset enum" behavior: each constant stores its filename relative
// to a per-enum folder under assets/, and exposes the full asset path via
// filename(). Mix this into an enum with `enum Foo with AssetFilename { ... }`,
// give it a `rawFilename` field (set via the constructor) and, if the enum's
// assets don't live directly under assets/, override `assetFolder`.
// -----------------------------------------------------------------------------
mixin AssetFilename {
  String get rawFilename;

  String get assetFolder => '';

  String filename() => 'assets/$assetFolder$rawFilename';
}
