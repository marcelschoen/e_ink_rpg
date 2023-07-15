import 'package:flutter/material.dart';

void main() {
  runApp(Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monster Slayer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(),
      ),
      home: TitlePage(),
    );
  }
}

class TitlePage extends StatelessWidget {

  TitlePage();

  Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    /*
    final style = theme.textTheme.displayMedium!.copyWith(
      //color: theme.colorScheme.onPrimary,
    );

     */

    return Center(
      child: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        //color: Theme.of(context).colorScheme.primaryContainer,
        //alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            titleImage,
            TextButton(
              style: ButtonStyle(
//                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { print("*** PRESSED ***"); },
              child: Card(
                color: theme.colorScheme.primary,    // ← And also this.
                borderOnForeground: true,
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "START GAME",
//                    style: style,
                    semanticsLabel: "START GAME",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
