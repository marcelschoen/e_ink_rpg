import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatelessWidget {

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
                listenable: GameState().playerState,
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      getProgressBar(60,
                          GameState().player.progressBarValue(StatType.health),
                          14, Colors.black45, Colors.black12),
                      SizedBox(height: 6,),
                      // TODO - MANA
                      getProgressBar(60,
                          GameState().player.progressBarValue(StatType.mana),
                          14, Colors.black45, Colors.black12),
                      SizedBox(height: 6,),
                      // TODO - SKILL
                      getProgressBar(60,
                          GameState().player.progressBarValue(StatType.skillpoints),
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
  double _fontSize = 24;
  double _buttonWidth = 160;
  double _paddingSize = 6;

  BaseButton.textOnlyWithSizes(String label, void Function(BuildContext) function,
      double fontSize, double buttonWidth, double paddingSize)
      : _label = label,
        _image = null,
        _function = function,
        _fontSize = fontSize,
        _buttonWidth = buttonWidth,
        _paddingSize = paddingSize;

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
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(2),
            minimumSize: Size(_buttonWidth, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            alignment: Alignment.centerLeft),
        onPressed: () {
          print("*** PRESSED: $_label ***");
          _function(context);
        },
        child: getButtonContent(this.enabled, _buttonWidth, _paddingSize));
  }

  // ---------------------------------------------
  // creates icon and text content box
  // ---------------------------------------------
  Widget getButtonContent(bool enabled, double buttonWidth, double paddingSize) {
    Widget content;

    if (!enabled) {
      content = Text('...', style: TextStyle(fontSize: _fontSize), textAlign: TextAlign.center,);
    } else {

      if (_image != null && _label != null) {
        content = Row(
          children: [
            Image(image: AssetImage(_image)),
            gap(16),
            Text(_label, style: TextStyle(fontSize: _fontSize), textAlign: TextAlign.center,)
          ],
        );
      } else {
        content = _image == null
            ? Text(_label, style: TextStyle(fontSize: _fontSize), textAlign: TextAlign.center,)
            : Image(image: AssetImage(_image));
      }
    }

    return SizedBox(
      width: buttonWidth,
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: content
        ),
      ),
    );
  }
}

// ----------------------------------------------------------
// Progress bar
// ----------------------------------------------------------
Widget getProgressBar(double width, double value, double minHeight, Color color, Color backgroundColor) {
  return SizedBox(
      width: width,
      child: LinearProgressIndicator(
          value: value,
          minHeight: minHeight,
          color: color,
          backgroundColor: backgroundColor,
      )
    );
}

// ----------------------------------------------------------
// Horizontal gap between widgets
// ----------------------------------------------------------
SizedBox gap(double width) {
  return SizedBox(width: width);
}

// ----------------------------------------------------------
// Bold text style in given size
// ----------------------------------------------------------
getTitleTextStyle(double size) {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: size);
}

// ----------------------------------------------------------
// App bar for screen with title adapted to game state
// ----------------------------------------------------------
getAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: ListenableBuilder(
      listenable: GameState().appBarTitleState,
      builder: (BuildContext context, Widget? child) {

        if (GameState().screenType() == ScreenType.inventory) {
          return Text('Inventory');
        } else if (GameState().screenType() == ScreenType.jobs) {
          return Text('Jobs');
        } else if (GameState().screenType() == ScreenType.shop) {
          return Text('Shop');
        } else if (GameState().screenType() == ScreenType.skills) {
          return Text('Skills');
        } else if (GameState().screenType() == ScreenType.equipment) {
          return Text('Equipment');
        } else if (GameState().screenType() == ScreenType.title) {
          return Text('Play4Ever Presents');
        }

        return Text(title);
      },
    ),
    titleTextStyle: getTitleTextStyle(24),
    centerTitle: true,
    flexibleSpace: getAppBarImage(),
  );
}

Widget getAppBarImage() {
  return Image(
    image: AssetImage('assets/background-title.png'),
    fit: BoxFit.fitWidth,
  );
}

switchToScreen(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
  GameState().setScreenByWidget(widget);
  GameState().update();
}

