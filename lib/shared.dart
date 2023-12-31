import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/models/attribute.dart';
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
          /*
          NpcWidget(),
          NpcWidget(),
          NpcWidget(),
           */
        ],
      ),
      NpcWidget(),
    ],
  );
}

Widget _getProgressBarWithLetter(String letter, StatType statType) {
  return Column(
    children: [
      RotatedBox(
          quarterTurns: 3,
          child: getProgressBar(
              50,
              GameState().player.progressBarValue(statType),
              12,
              Colors.black45,
              Colors.black12)),
      Text(letter, style: getTitleTextStyle(12))
    ],
  );
}

class NpcWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getCardWithRoundedBorder(Padding(
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
                      GameImageAsset.mount_horse.getGameImage(),
//                      GameNpcImageAsset.player.getNpcImage(),
                    ],
                  ),
                ),
                _getProgressBarWithLetter('H', StatType.health),
              ],
            );
          }),
    ));
  }
}

// -----------------------------------------------------------------------------
// Widget containing the players level, status info, picture etc.
// -----------------------------------------------------------------------------
class PlayerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return getCardWithRoundedBorder(Padding(
      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      child: ListenableBuilder(
          listenable: GameState().playerState,
          builder: (BuildContext context, Widget? child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Lvl', style: getTitleTextStyle(14)),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                            GameState()
                                .player
                                .attrValueInt(AttributeType.level)
                                .toString(),
                            style: getTitleTextStyle(24)),
//                    Text(GameState().player.level.toString(), style: getTitleTextStyle(24)),
                      ],
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: getProgressBar(
                          60,
                          GameState().player.progressBarValue(StatType.xp),
                          8,
                          Colors.black45,
                          Colors.black12),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      getImage(GameNpcImageAsset.male7.filename()),
                    ],
                  ),
                ),
                // ------------------ progress bars ------------------
                Row(
                  children: [
                    _getProgressBarWithLetter('H', StatType.health),
                    hGap(2),
                    _getProgressBarWithLetter('S', StatType.stamina),
                    hGap(2),
                    _getProgressBarWithLetter('F', StatType.focus),
                    hGap(2),
                    _getProgressBarWithLetter('M', StatType.mana),
                  ],
                )
              ],
            );
          }),
    ));
  }
}

// -----------------------------------------------------------------------------
// Base class for button widgets; can have text and/or an image icon.
// -----------------------------------------------------------------------------
class BaseButton extends StatelessWidget {
  final _label;
  final _image;
  final _function;
  bool enabled = true;
  double _fontSize = 24;
  double _buttonWidth = 160;
  double _paddingSize = 6;

  BaseButton.textOnlyWithSizes(
      String label,
      void Function(BuildContext) function,
      double fontSize,
      double buttonWidth,
      double paddingSize)
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
  Widget getButtonContent(
      bool enabled, double buttonWidth, double paddingSize) {
    Widget content;

    if (!enabled) {
      content = Text(
        '...',
        style: TextStyle(fontSize: _fontSize),
        textAlign: TextAlign.center,
      );
    } else {
      if (_image != null && _label != null) {
        content = Row(
          children: [
            Image(image: AssetImage(_image)),
            hGap(16),
            Text(
              _label,
              style: TextStyle(fontSize: _fontSize),
              textAlign: TextAlign.center,
            )
          ],
        );
      } else {
        content = _image == null
            ? Text(
                _label,
                style: TextStyle(fontSize: _fontSize),
                textAlign: TextAlign.center,
              )
            : Image(image: AssetImage(_image));
      }
    }

    return SizedBox(
      width: buttonWidth,
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child: Padding(padding: EdgeInsets.all(paddingSize), child: content),
      ),
    );
  }
}

// ----------------------------------------------------------
// Progress bar
// ----------------------------------------------------------
Widget getProgressBar(double width, double value, double minHeight, Color color,
    Color backgroundColor) {
  return SizedBox(
      width: width,
      child: LinearProgressIndicator(
        value: value,
        minHeight: minHeight,
        color: color,
        backgroundColor: backgroundColor,
      ));
}

// ----------------------------------------------------------
// App bar for screen with title adapted to game state
// ----------------------------------------------------------
getAppBar(String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    // disable back button
    title: ListenableBuilder(
      listenable: GameState().appBarTitleState,
      builder: (BuildContext context, Widget? child) {
        if (GameState().screenType() == ScreenType.inventory) {
          return getAppBarTitle('Inventory', false);
        } else if (GameState().screenType() == ScreenType.jobs) {
          return getAppBarTitle('Jobs', false);
        } else if (GameState().screenType() == ScreenType.shop) {
          return getAppBarTitle('Shop', false);
        } else if (GameState().screenType() == ScreenType.skills) {
          return getAppBarTitle('Skills', false);
        } else if (GameState().screenType() == ScreenType.equipment) {
          return getAppBarTitle('Equipment', false);
          /*
        } else if (GameState().screenType() == ScreenType.title) {
          return getAppBarTitle('Play4Ever Presents', true);

           */
        } else if (GameState().screenType() == ScreenType.exploration) {
          return getAppBarTitle('Exploration', false);
        }
        return getAppBarTitle(title, false);
      },
    ),
    titleTextStyle: getTitleTextStyle(24),
    centerTitle: true,
    flexibleSpace: ListenableBuilder(
      listenable: GameState().appBarTitleState,
      builder: (BuildContext context, Widget? child) {
        return getAppBarImage();
      },
    ),
  );
}

Widget getAppBarTitle(String title, bool centered) {
  Alignment alignment = Alignment.centerLeft;
  if (centered) {
    alignment = Alignment.center;
  }
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    getOutlinedText(title, 36, 3, Colors.black87, Colors.white),
    getOutlinedText(
        GameState().daytime.getLabel(), 20, 1, Colors.black87, Colors.white),
  ]);
}

Widget getAppBarImage() {
  return Image(
    image: AssetImage(GameState().daytime.getDetail().image.filename()),
    fit: BoxFit.fitWidth,
  );
}

// ----------------------------------------------------------
// Horizontal gap between widgets
// ----------------------------------------------------------
SizedBox hGap(double width) {
  return SizedBox(width: width);
}

// ----------------------------------------------------------
// Vertical gap between widgets
// ----------------------------------------------------------
SizedBox vGap(double height) {
  return SizedBox(height: height);
}

// ----------------------------------------------------------
// Bold text style in given size
// ----------------------------------------------------------
getTitleTextStyle(double size) {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: size);
}

// ----------------------------------------------------------
// Regular text style in given size
// ----------------------------------------------------------
getRegularTextStyle(double size) {
  return TextStyle(fontWeight: FontWeight.normal, fontSize: size);
}

// -----------------------------------------------------------------------------
// Returns text as filled outline in the 'Diablo' font
// -----------------------------------------------------------------------------
Widget getOutlinedText(String text, double fontSize, double strokeWidth,
    Color border, Color fill) {
  return Stack(
    children: <Widget>[
      // Solid text as fill.
      Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Diablo',
          color: fill,
        ),
      ),
      // Stroked text as border.
      Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Diablo',
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth
            ..color = border,
        ),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Switches to the given screen
// -----------------------------------------------------------------------------
switchToScreen(Widget widget, BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
  GameState().setScreenByWidget(widget);
  GameState().update();
}

// -----------------------------------------------------------------------------
// Creates a card with a rounded dark grey border
// -----------------------------------------------------------------------------
Card getCardWithRoundedBorder(Widget child) {
  return getCustomCardWithRoundedBorder(child, 3, Colors.black45);
}

// -----------------------------------------------------------------------------
// Creates a card with a rounded dark grey border
// -----------------------------------------------------------------------------
Card getCustomCardWithRoundedBorder(
    Widget child, double borderWidth, Color borderColor) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          width: borderWidth,
          color: borderColor,
        ),
      ),
      child: child);
}

// -----------------------------------------------------------------------------
// Creates an alert dialog that asks for a string value
// -----------------------------------------------------------------------------
AlertDialog createNameInputDialog(BuildContext context, String title,
    String text, String inputFieldName, String inputFieldValue) {
  final myController = TextEditingController();
  myController.text = inputFieldValue;
  return AlertDialog(
    title: Text(title),
    content: SizedBox(
      height: 100, // TODO: AVOID FIXED VALUE
      child: Column(
        children: [
          Text(text),
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          )
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, ''),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, myController.text),
        child: const Text('OK'),
      ),
    ],
  );
}

// -----------------------------------------------------------------------------
// Creates an alert dialog for a yes/no question
// -----------------------------------------------------------------------------
AlertDialog createAlertDialog(BuildContext context, String title, String text) {
  return AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('OK'),
      ),
    ],
  );
}

getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
