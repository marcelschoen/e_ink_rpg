import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
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
        length: 5,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: TabBarView(
                children: [
                  Text('*** JOBS ***'),
                  Text('*** SHOPPING ***'),
                  getInventory(context),
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
              dividerColor: Colors.black54,
              tabs: [
                Tab(child: Image(image: AssetImage('assets/button-jobs.png'))),
                Tab(child: Image(image: AssetImage('assets/button-shop.png'))),
                Tab(child: Image(image: AssetImage('assets/button-inventory.png'))),
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

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Shop screen
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Inventory screen
// -----------------------------------------------------------------------------
Widget getInventory(BuildContext context) {
  return CustomScrollView(
    primary: false,
    slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(10),
        sliver: SliverGrid.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 8,
          children: GameState().player.inventory.getItemWidgets(context)
        ),
      ),
    ],
  );
}


// -----------------------------------------------------------------------------
// Equip screen
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Skills screen
// -----------------------------------------------------------------------------
