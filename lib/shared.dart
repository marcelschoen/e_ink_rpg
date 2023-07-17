import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {

  final _label;
  final _image;
  final _function;

  const BaseButton(String label, String imageFilename, void Function(BuildContext) function) :
        _label = label, _image = imageFilename, _function = function;

  @override
  Widget build(BuildContext context) {
    Image buttonImage = Image(image: AssetImage(_image));

    return TextButton(
      onPressed: () {
        print("*** PRESSED: $_label ***");
        _function(context);
      },
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child:
        Padding(padding: const EdgeInsets.all(10), child: buttonImage),
      ),
    );
  }
}
