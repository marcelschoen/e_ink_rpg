import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

void backToTitle(BuildContext context) {
  print("*** back to title ***");
  Navigator.pop(context);
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MainGameScaffold();
  }
}

class MainGameScaffold extends StatefulWidget {
  const MainGameScaffold({super.key});

  @override
  State<MainGameScaffold> createState() => _MainGameScaffoldState();
}

class _MainGameScaffoldState extends State<MainGameScaffold> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Center(
        child: Placeholder(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
//            height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton('BACK', 'assets/button-back.png', (context) => backToTitle(context)),
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
