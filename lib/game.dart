import 'package:e_ink_rpg/fight.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

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
// Inventory screen
// -----------------------------------------------------------------------------

// MISSING BUTTONS FOR SELECTED ITEM ("Use", "Discard", ...)

Widget getInventory(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          thickness: 20,
          isAlwaysShown: true,
          child: GridView.count(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 6,
            // Generate 100 widgets that display their index in the List.
            children: GameState().player.inventory.getItemWidgets(context)
          ),
        ),
      ),
      Card(
        shape: RoundedRectangleBorder( //<-- SEE HERE
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.black54,
            style: BorderStyle.solid,
            width: 4
          ),
        ),
        child: SizedBox(
          height: 110,
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.black12,
                  child: Container(
                    margin: EdgeInsets.only(top: 4, bottom: 0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Details', style: getTitleTextStyle(18)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      )
    ],
  );
}


getMainAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: ListenableBuilder(
      listenable: GameState().appBarTitleState,
      builder: (BuildContext context, Widget? child) {
        /*
        if (GameState().appBarTitleState.sections == AppBarSections.inventory) {
          return Text('Inventory');
        } else if (GameState().appBarTitleState.sections == AppBarSections.jobs) {
          return Text('Jobs');
        } else if (GameState().appBarTitleState.sections == AppBarSections.equip) {
          return Text('Equipment');
        }

         */
        return Text('');
      },
    ),
    titleTextStyle: getTitleTextStyle(24),
    centerTitle: true,
    flexibleSpace: getAppBarImage(),
  );
}

// -----------------------------------------------------------------------------
// Equip screen
// -----------------------------------------------------------------------------


// -----------------------------------------------------------------------------
// Skills screen
// -----------------------------------------------------------------------------
