import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Get a sized box with an image
// -----------------------------------------------------------------------------
SizedBox getSizedImage(String filename, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: Image(image: AssetImage(filename)),
  );
}

SizedBox getImage(String filename) {
  return SizedBox(
    width: 64,
    height: 64,
    child: Image(image: AssetImage(filename)),
  );
}

SizedBox getImageSmall(String filename) {
  return SizedBox(
    width: 32,
    height: 32,
    child: Image(image: AssetImage(filename)),
  );
}

Widget getImageFit(String filename) {
  return Image.asset(
      filename,
      fit: BoxFit.cover
  );
}
