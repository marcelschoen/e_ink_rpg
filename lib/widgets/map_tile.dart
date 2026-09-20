import 'dart:ui' as ui;

import 'package:e_ink_rpg/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
// Draws the given path segment images stacked as a CustomPaint background
// behind "content" (e.g. the discovered/undiscovered center icon).
// -----------------------------------------------------------------------------
Widget getMapPathTile(List<GameImageAsset> segments) {
  return _MapTile(segments: segments);
}

// Decoding a PNG asset into a ui.Image is asynchronous, so decoded tile
// images are cached here rather than re-decoded for every tile that uses them.
final Map<GameImageAsset, ui.Image> _tileImageCache = {};

Future<ui.Image> _loadTileImage(GameImageAsset asset) async {
  ui.Image? cached = _tileImageCache[asset];
  if (cached != null) {
    return cached;
  }
  ByteData data = await rootBundle.load(asset.filename());
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  ui.FrameInfo frame = await codec.getNextFrame();
  _tileImageCache[asset] = frame.image;
  return frame.image;
}

class _MapTile extends StatefulWidget {
  final List<GameImageAsset> segments;

  const _MapTile({required this.segments});

  @override
  State<_MapTile> createState() => _MapTileState();
}

class _MapTileState extends State<_MapTile> {
  List<ui.Image>? _images;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  // Without a Key distinguishing tiles, Flutter reuses this State across
  // rebuilds for whatever widget lands in the same grid slot - including
  // after switching regions, where a completely different location (with
  // different segments) can occupy the same slot. Reload whenever the
  // segments actually change instead of only once in initState.
  @override
  void didUpdateWidget(covariant _MapTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.segments, widget.segments)) {
      _images = null;
      _loadImages();
    }
  }

  void _loadImages() {
    Future.wait(widget.segments.map(_loadTileImage)).then((images) {
      if (mounted) {
        setState(() {
          _images = images;
        });
      }
    });
  }

  // Reference size matching the tile art's native pixel dimensions. This
  // grid sits inside a FittedBox that measures it at these unconstrained,
  // intrinsic dimensions and then scales the whole thing to fit - so this
  // needs a definite size rather than AspectRatio, which reports an
  // intrinsic width of 0 under the unbounded height a FittedBox provides.
  static const double _tileNativeSize = 300;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _tileNativeSize,
      height: _tileNativeSize,
      child: CustomPaint(
        painter: _images == null ? null : _MapTilePainter(_images!),
      ),
    );
  }
}

class _MapTilePainter extends CustomPainter {
  final List<ui.Image> images;

  _MapTilePainter(this.images);

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
    for (ui.Image image in images) {
      paintImage(canvas: canvas, rect: rect, image: image, fit: BoxFit.cover);
    }
  }

  @override
  bool shouldRepaint(covariant _MapTilePainter oldDelegate) {
    return !listEquals(oldDelegate.images, images);
  }
}
