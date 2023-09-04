import 'dart:io';

import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
                  BaseButton.textOnlyWithSizes('NEW', (context) => newGame(context), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('LOAD', (context) => loadGame(GameState().selectedGameSave, context), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('SAVE', (context) => saveGame(GameState().selectedGameSave, context), 32, 160, 4 ),
                  BaseButton.textOnlyWithSizes('DELETE', (context) => deleteGame(GameState().selectedGameSave, context), 32, 160, 4 ),
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

  newGame(BuildContext context) async {
    String? value = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => createNameInputDialog(context, 'CREATE SAVE', 'Please enter name of new save', 'Name'),
    );
    if (!value!.isEmpty) {
      print ('*** create new game: ' + value! + ' ***');
      saveGameState(value!);
    }
  }

  loadGame(String? saveName, BuildContext context) async {
    if (saveName == null) {
      return;
    }
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'LOAD SAVE', 'Really load \'' + saveName! + '\'? You may lose current unsaved changes.'),
    );
    if (value != null && value!) {
      print ('*** load game ' + saveName + ' ***');
    }
  }

  saveGame(String? saveName, BuildContext context) async {
    if (saveName == null) {
      return;
    }
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'SAVE GAME', 'Really overwrite \'' + saveName! + '\'?'),
    );
    if (value != null && value!) {
      print ('*** save game ' + saveName + ' ***');
    }
  }

  deleteGame(String? saveName, BuildContext context) async {
    if (saveName == null) {
      return;
    }
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'DELETE SAVE', 'Really delete \'' + saveName! + '\'?'),
    );
    if (value != null && value!) {
      print ('*** delete game ' + saveName + ' ***');
    }
  }

  // ---------------------------------------------------------------------------
  // Saves current state under given filename
  // ---------------------------------------------------------------------------
  Future<File> saveGameState(String saveName) async {
    final file = await _localFile(saveName);

    // Create JSON from current state - TODO
    String jsonContent = '{}';

    // Write the file
    return file.writeAsString(jsonContent);
  }

  // ---------------------------------------------------------------------------
  // Initialize current state from file with given filename
  // ---------------------------------------------------------------------------
  Future<String> loadGameState(String saveName) async {
    try {
      final file = await _localFile(saveName);
      // Read the file
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      print(e);
      // If encountering an error, return 0
      return '';
    }
  }

  Future<File> _localFile(String saveName) async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

