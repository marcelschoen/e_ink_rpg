import 'package:flutter/material.dart';

class Fight extends StatelessWidget {
  const Fight({super.key});

  @override
  Widget build(BuildContext context) {
    return FightScaffold();
  }
}

class FightScaffold extends StatefulWidget {
  const FightScaffold({super.key});

  @override
  State<FightScaffold> createState() => _FightScaffoldState();
}

class _FightScaffoldState extends State<FightScaffold> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fight Screen'),
      ),
      body: Center(
        child: Placeholder(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
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
          ),
      onPressed: () {
        print("*** ABORT FIGHT ***");
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
