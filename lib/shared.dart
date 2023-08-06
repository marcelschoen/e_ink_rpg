import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({super.key, required this.gameStateNotifier});

  final GameState gameStateNotifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration:
          BoxDecoration(border: Border.all(color: Colors.red)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: const EdgeInsets.all(8.0),
                child: GameNpcImageAsset.player.getNpcImage(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('HEALTH: ', style: TextStyle(fontSize: 16)),
                  Text('MANA: ', style: TextStyle(fontSize: 16)),
                  Text('SKILL: ', style: TextStyle(fontSize: 16)),
                ],
              ),
              ListenableBuilder(
                listenable: gameStateNotifier.playerState,
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getProgressBar(60,
                          gameStateNotifier.player.progressBarValue(StatType.health),
                          14, Colors.black45, Colors.black12),
                      SizedBox(height: 6,),
                      // TODO - MANA
                      getProgressBar(60,
                          gameStateNotifier.player.progressBarValue(StatType.mana),
                          14, Colors.black45, Colors.black12),
                      SizedBox(height: 6,),
                      // TODO - SKILL
                      getProgressBar(60,
                          gameStateNotifier.player.progressBarValue(StatType.skillpoints),
                          14, Colors.black45, Colors.black12),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * Base class for button widgets; can have text and/or an image icon.
 */
class BaseButton extends StatelessWidget {
  final _label;
  final _image;
  final _function;
  bool enabled = true;

  BaseButton.textOnly(String label, void Function(BuildContext) function)
      : _label = label,
        _image = null,
        _function = function;

  BaseButton.withImageAndText(
      String label, String imageFilename, void Function(BuildContext) function)
      : _label = label,
        _image = imageFilename,
        _function = function;

  BaseButton.withImageOnly(
      String imageFilename, void Function(BuildContext) function)
      : _label = null,
        _image = imageFilename,
        _function = function;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("*** PRESSED: $_label ***");
          _function(context);
        },
        child: getButtonContent(enabled));
  }

  // ---------------------------------------------
  // creates icon and text content box
  // ---------------------------------------------
  Widget getButtonContent(bool enabled) {
    Widget content;

    if (!enabled) {
      content = Text('...', style: TextStyle(fontSize: 24), textAlign: TextAlign.center,);
    } else {

      if (_image != null && _label != null) {
        content = Row(
          children: [
            Image(image: AssetImage(_image)),
            SizedBox(width: 16),
            Text(_label, style: TextStyle(fontSize: 24), textAlign: TextAlign.center,)
          ],
        );
      } else {
        content = _image == null
            ? Text(_label, style: TextStyle(fontSize: 24), textAlign: TextAlign.center,)
            : Image(image: AssetImage(_image));
      }
    }

    return SizedBox(
      width: 160,
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: content
        ),
      ),
    );
  }
}

Widget getProgressBar(double width, double value, double minHeight, Color color, Color backgroundColor) {
  return SizedBox(
      width: width,
      child: LinearProgressIndicator(
          value: value,
          minHeight: minHeight,
          color: color,
          backgroundColor: backgroundColor,
//          valueColor: AlwaysStoppedAnimation(Colors.black54))
      )
    );
}

switchToScreen(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
  GameState().update();
  GameState().update();
}