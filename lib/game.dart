import 'package:flutter/material.dart';

void main() {
  runApp(Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    Image titleImage =
        Image(image: AssetImage('assets/monster-slayer-logo.png'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monster Slayer'),
      ),
      body: Center(
        child: titleImage,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
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
