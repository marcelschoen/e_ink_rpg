import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

void backToTitle(BuildContext context) {
  print("*** abort fight ***");
  Navigator.pop(context);
}

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

      // ********** Actual combat screen part **********
      body: Center(
        child: Placeholder(),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton('BACK', 'assets/button-back.png', (context) => backToTitle(context)),
            ],
          ),
        ),
      ),
    );
  }
}
