import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {

  final _label;
  final _image;
  final _function;

  const BaseButton.textOnly(String label, void Function(BuildContext) function) :
        _label = label, _image = null, _function = function;

  const BaseButton.withImage(String label, String imageFilename, void Function(BuildContext) function) :
        _label = label, _image = imageFilename, _function = function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print("*** PRESSED: $_label ***");
        _function(context);
      },
      child: getButtonContent()
    );
  }

  Widget getButtonContent() {
    Widget content = _image == null
        ? Text(_label, style: TextStyle( fontSize: 30))
        : Image(image: AssetImage(_image));

    return Card(
      borderOnForeground: true,
      elevation: 5.0,
      child:
      Padding(padding: const EdgeInsets.all(10), child: content),
    );
  }
}
