import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {

  const PlayerWidget({super.key, required this.gameStateNotifier});

  final GameState gameStateNotifier;

  @override
  Widget build(BuildContext context) {

    return Container(
      foregroundDecoration: BoxDecoration(
          border: Border.all(color: Colors.red)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage('assets/humanoid/Human1.png')
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(" PLAYER: " + GameState().player.name),
                  ListenableBuilder(
                    listenable: gameStateNotifier,
                    builder: (BuildContext context, Widget? child) {
                      return Text(' HEALTH: ' + gameStateNotifier.player.health().toString() );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonsterWidget extends StatelessWidget {

  const MonsterWidget({super.key, required this.gameStateNotifier});

  final GameState gameStateNotifier;

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }

}

/**
 * Base class for button widgets; can have text and/or an image icon.
 */
class BaseButton extends StatelessWidget {
  final _label;
  final _image;
  final _function;

  const BaseButton.textOnly(String label, void Function(BuildContext) function)
      : _label = label,
        _image = null,
        _function = function;

  const BaseButton.withImage(
      String label, String imageFilename, void Function(BuildContext) function)
      : _label = label,
        _image = imageFilename,
        _function = function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("*** PRESSED: $_label ***");
          _function(context);
        },
        child: getButtonContent());
  }

  Widget getButtonContent() {
    Widget content = _image == null
        ? Text(_label, style: TextStyle(fontSize: 30))
        : Image(image: AssetImage(_image));

    return Card(
      borderOnForeground: true,
      elevation: 5.0,
      child: Padding(padding: const EdgeInsets.all(10), child: content),
    );
  }
}
