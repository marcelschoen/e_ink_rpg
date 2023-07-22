import 'package:flutter/material.dart';

import 'models/beings.dart';

class PlayerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Widget widget;

    widget = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Image(image: AssetImage('assets/humanoid/Human1.png')),
        Column(
          children: [
            Text(" PLAYER: " + Player().name),
            Text(" HEALTH: " + Player().health().toString()),
          ],
        ),
      ],
    );

    return widget;
  }

}

/**
 * Base class for button widgets; can have text and/or an image icon.
 */
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
