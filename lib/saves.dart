import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// Game save load and save stuff
// -----------------------------------------------------------------------------
class GameSaves extends StatelessWidget {

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: getTitleAppBar('GAME SAVES'),
          body: Center(
            child: Scrollbar(
              controller: scrollController,
              child: Column(
                children: getListOfSaves(),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseButton.textOnlyWithSizes('NEW', (context) => newGame('xy'), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('LOAD', (context) => loadGame('xy'), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('SAVE', (context) => loadGame('xy'), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('DELETE', (context) => deleteGame('xy', context), 32, 160, 4 ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getListOfSaves() {
    List<Widget> saves = [];

    for(int i = 0; i < 5; i ++) {
      saves.add(getSaveEntry('Save ' + i.toString()));
    }

    return saves;
  }

  Widget getSaveEntry(String label) {
    return getCardWithRoundedBorder(
        InkWell(
          onTap: () {
            GameState().selectedGameSave = label;
            GameState().saveState.update();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getOutlinedText(label, 32, 2, Colors.black, Colors.white),
          ),
        )
    );
  }

  newGame(String saveName) {
    print ('*** new game ' + saveName + ' ***');
  }

  loadGame(String saveName) {
    print ('*** load game ' + saveName + ' ***');
  }

  saveGame(String saveName) {
    print ('*** load game ' + saveName + ' ***');
  }

  deleteGame(String saveName, BuildContext context) async {

    String? value = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('DELETE SAVE'),
        content: Text('Really delete save?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    print ('>>> value: ' + (value == null ? 'null' : value!.toString()));
    print ('*** delete game ' + saveName + ' ***');
  }

}

