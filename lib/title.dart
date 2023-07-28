import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/game.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MonsterSlayerTitle());
}
/*
void startFight(BuildContext context) {
  print("*** FIGHT ***");
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Fight()),
  );
}

 */

void startPlay(BuildContext context) {
  print("*** PLAY ***");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Game()),
  );
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
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Image titleImage = Image(image: AssetImage('assets/monster-slayer-logo.png'));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Monster Slayer'),
      ),
      body: Center(
        child: titleImage,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImageOnly('assets/button-play.png', (context) => startPlay(context)),
              BaseButton.withImageOnly('assets/button-fight.png', (context) => startFight(context)),
            ],
          ),
        ),
      ),
    );
  }
}
