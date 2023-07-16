import 'package:e_ink_rpg/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MonsterSlayerTitle());
}

class MonsterSlayerTitle extends StatelessWidget {
  const MonsterSlayerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TitleScaffold(),
    );
  }
}

class TitleScaffold extends StatefulWidget {
  const TitleScaffold({super.key});

  @override
  State<TitleScaffold> createState() => _TitleScaffoldState();
}

class _TitleScaffoldState extends State<TitleScaffold> {
  @override
  Widget build(BuildContext context) {
    Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monster Slayer'),
      ),
      body: Center(
        child: titleImage,
      ),
      bottomNavigationBar: BottomAppBar(
//        shape: const CircularNotchedRectangle(),
        child: Container(
//            height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StartGameButton(),
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class StartGameButton extends StatelessWidget {
  const StartGameButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Image playButtonImage = Image(image: AssetImage('assets/button-play.png'));

    return TextButton(
      style: ButtonStyle(
//                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {
        print("*** PRESSED ***");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Game()),
        );

      },
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child:
        Padding(padding: const EdgeInsets.all(20), child: playButtonImage),
      ),
    );
  }
}
