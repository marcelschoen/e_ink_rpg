import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

Widget getPartyStatusBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          PlayerWidget(),
          NpcWidget(),
          NpcWidget(),
        ],
      ),
      Card(
        child: Text('Aha'),
      )
    ],
  );
}

class NpcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( //<-- SEE HERE
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          width: 3,
          color: Colors.black45,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: ListenableBuilder(
            listenable: GameState().playerState,
            builder: (BuildContext context, Widget? child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        GameNpcImageAsset.player.getNpcImage(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            getProgressBar(60,
                                GameState().player.progressBarValue(
                                    StatType.health),
                                12, Colors.black45, Colors.black12),
                            SizedBox(height: 2,),
                            // TODO - MANA
                            getProgressBar(60,
                                GameState().player.progressBarValue(
                                    StatType.mana),
                                12, Colors.black45, Colors.black12),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                        child: Row(
                          children: [
                            GameIconAsset.heart.getIconImage(),
                            gap(2),
                            GameIconAsset.magic.getIconImage(),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder( //<-- SEE HERE
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          width: 3,
          color: Colors.black45,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: ListenableBuilder(
          listenable: GameState().playerState,
          builder: (BuildContext context, Widget? child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('Lvl', style: getTitleTextStyle(14)),
                    SizedBox(height: 2,),
                    Text('13', style: getTitleTextStyle(24)),
//                    Text(GameState().player.level.toString(), style: getTitleTextStyle(24)),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      GameNpcImageAsset.player.getNpcImage(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          getProgressBar(60,
                              GameState().player.progressBarValue(
                                  StatType.health),
                              12, Colors.black45, Colors.black12),
                          SizedBox(height: 2,),
                          // TODO - MANA
                          getProgressBar(60,
                              GameState().player.progressBarValue(
                                  StatType.mana),
                              12, Colors.black45, Colors.black12),
                          SizedBox(height: 2,),
                          // TODO - SKILL
                          getProgressBar(60,
                              GameState().player.progressBarValue(
                                  StatType.skillpoints),
                              12, Colors.black45, Colors.black12),
                          SizedBox(height: 2,),
                          getProgressBar(60,
                              GameState().player.progressBarValue(StatType.xp),
                              12, Colors.black45, Colors.black12),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                      child: Row(
                        children: [
                          GameIconAsset.heart.getIconImage(),
                          gap(2),
                          GameIconAsset.magic.getIconImage(),
                          gap(2),
                          GameIconAsset.skill.getIconImage(),
                          gap(2),
                          GameIconAsset.special.getIconImage(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }
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
          return Text('These Jobs are cool');
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

