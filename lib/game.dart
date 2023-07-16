import 'package:flutter/material.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldExample();
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
        title: const Text('Main Screen'),
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
    Image backButtonImage = Image(image: AssetImage('assets/button-back.png'));

    return TextButton(
      style: ButtonStyle(
//                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
      onPressed: () {
        print("*** BACK TO TITLE ***");
        Navigator.pop(context);
      },
      child: Card(
        borderOnForeground: true,
        elevation: 5.0,
        child:
            Padding(padding: const EdgeInsets.all(20), child: backButtonImage),
      ),
    );
  }
}
