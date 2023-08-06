import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

// Switches back to title screen
void backToTitle(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MonsterSlayerTitle()),
  );
}

// Main game screen
class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Main Screen'),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TabBarView(
                children: [
                  Text('*** JOBS ***'),
                  Text('*** SHOPPING ***'),
                  Text('*** EQUIPMENT ***'),
                  Text('*** SKILLS ***'),
                ],
              ),
            ),
            Container(
              color: Colors.black54,
              height: 8,
            ),
            TabBar(
              tabs: [
                Tab(child: Image(image: AssetImage('assets/button-jobs.png'))),
                Tab(child: Image(image: AssetImage('assets/button-shop.png'))),
                Tab(child: Image(image: AssetImage('assets/button-equip.png'))),
                Tab(child: Image(image: AssetImage('assets/button-skills.png'))),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImageOnly('assets/button-back.png', (context) => backToTitle(context)),
              BaseButton.withImageOnly('assets/button-fight.png', (context) => startFight(context)),
            ],
          ),
        ),
      ),
    );
  }
}

