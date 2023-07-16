import 'package:flutter/material.dart';

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
              BackButton(),
            ],
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
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
