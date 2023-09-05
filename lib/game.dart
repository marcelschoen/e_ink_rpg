import 'package:e_ink_rpg/equip.dart';
import 'package:e_ink_rpg/saves.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

import 'inventory.dart';
import 'jobs.dart';
import 'map.dart';

// -----------------------------------------------
// Switches back to title screen
// -----------------------------------------------
void backToTitle(BuildContext context) {
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
      body: Column(
        children: [
          getPartyStatusBar(),
          Expanded(
            child: DefaultTabController(
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
                            getMapScreen(context),
                            getJobsScreen(context),
                            getInventoryScreen(context),
                            getEquipScreen(context),
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
                          Tab(child: Image(image: AssetImage('assets/button-map.png'))),
                          Tab(child: Image(image: AssetImage('assets/button-jobs.png'))),
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
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getButtons(),
          ),
        ),
      ),
    );
  }


  List<Widget> getButtons() {
    List<Widget> buttons = [];
    buttons.add(BaseButton.textOnly('EXIT', (context) => abortGame(context)));
    buttons.add(BaseButton.textOnly('SAVES', (context) => switchToScreen(GameSaves(), context)));
    return buttons;
  }

  // ---------------------------------------------------------------------------
  // Shows dialog for saving a game
  // ---------------------------------------------------------------------------
  abortGame(BuildContext context) async {
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'ABORT GAME', 'Really going back to title? Any unsaved progress may be lost.'),
    );
    if (value != null && value!) {
      switchToScreen(MonsterSlayerTitle(), context);
    }
  }

}
