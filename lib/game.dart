import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

import 'inventory.dart';
import 'jobs.dart';

// -----------------------------------------------
// Switches back to title screen
// -----------------------------------------------
void backToTitle(BuildContext context) {
  print (" ----------------------> BACK TO TITLE" );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MonsterSlayerTitle()),
  );
  GameState().setScreenType(ScreenType.title);
}

// -----------------------------------------------
// Main game screen
// -----------------------------------------------
class Game extends StatelessWidget {
  Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar('Monster Slayer'),
      body: DefaultTabController(
        length: 5,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context)!;
            tabController.addListener(() {
              GameState().setScreenTypeByNumber(tabController.index);
            });

            return Column(
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [
                      getJobsScreen(context),
                      Text('*** SHOPPING ***'),
                      getInventoryScreen(context),
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
            );
          }
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton.withImageOnly('assets/button-back.png', (context) => switchToScreen(MonsterSlayerTitle(), context)),
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
// Equip screen
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Skills screen
// -----------------------------------------------------------------------------
