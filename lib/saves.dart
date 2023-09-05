import 'dart:io';

import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:e_ink_rpg/title.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'game.dart';



// -----------------------------------------------------------------------------
// Game save load and save stuff
// -----------------------------------------------------------------------------
class GameSaves extends StatelessWidget {

  ScrollController scrollController = ScrollController();

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  bool onlyLoading() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return getGameSavePageContent();
  }

  MaterialApp getGameSavePageContent() {
    return MaterialApp(
    home: WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: getTitleAppBar('GAME SAVES'),
        body: Center(
          child: Scrollbar(
            controller: scrollController,
            child: ListenableBuilder(
              listenable: GameState().saveState,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: getScreenWidth(context) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: getListOfSaves(),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getButtons(),
            ),
          ),
        ),
      ),
    ),
  );
  }

  List<Widget> getButtons() {
    List<Widget> buttons = [];
    buttons.add(BaseButton.textOnlyWithSizes('LOAD', (context) => loadGame(GameState().selectedGameSave, context), 32, 130, 4 ));
    if (!onlyLoading()) {
      // Opened from within game
      buttons.add(BaseButton.textOnlyWithSizes('SAVE', (context) => saveGame(context), 32, 130, 4 ));
      buttons.add(BaseButton.textOnlyWithSizes('DELETE', (context) => deleteGame(GameState().selectedGameSave, context), 32, 130, 4 ));
      buttons.add(BaseButton.textOnlyWithSizes('BACK', (context) => switchToScreen(Game(), context), 32, 130, 4 ));
    } else {
      // Opened from title screen
      buttons.add(BaseButton.textOnlyWithSizes('BACK', (context) => backToTitle(context), 32, 130, 4 ));
    }
    return buttons;
  }

  List<Widget> getListOfSaves() {
    GameSaveHandler.updateListOfSaves();
    List<Widget> saves = [];
    for(File entry in GameSaveHandler.currentSaves) {
      String name = basename(entry.path);
      name = name.substring(0, name.indexOf('.save'));
      saves.add(getSaveEntry(name, name == GameState().selectedGameSave));
    }
    return saves;
  }

  Widget getSaveEntry(String label, bool selected) {
    double fontSize = 32;
    double borderWidth = 3;
    Color borderColor = Colors.black45;
    if (selected) {
      fontSize = 48;
      borderWidth = 4;
      borderColor = Colors.black;
    }
    return getCustomCardWithRoundedBorder(
        InkWell(
          onTap: () {
            GameState().selectedGameSave = label;
            GameState().saveState.update();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: getOutlinedText(label, fontSize, 2, Colors.black, Colors.white)),
          ),
        ),
        borderWidth,
        borderColor
    );
  }

  // ---------------------------------------------------------------------------
  // Shows dialog for creating a new game save
  // ---------------------------------------------------------------------------
  saveGame(BuildContext context) async {
    String initialName = GameState().selectedGameSave == null ? '' : GameState().selectedGameSave!;
    String? value = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => createNameInputDialog(context, 'SAVE GAME', 'Enter name of save game', 'Name', initialName),
    );
    if (!value!.isEmpty) {
      value = value.toLowerCase();
      bool createSave = true;
      for (File entry in GameSaveHandler.currentSaves) {
        if (entry.path.endsWith(value + '.save')) {
          bool? value = await showDialog<bool>(
            context: context,
            builder: (BuildContext context) => createAlertDialog(context, 'OVERWRITE', 'A save with that name already exists. Do you want to overwrite it?'),
          );
          createSave = value == null ? false : value;
        }
      }
      if (createSave) {
        GameSaveHandler.saveGameState(value!);
        GameState().selectedGameSave = null;
        switchToScreen(Game(), context);
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Shows dialog for loading a game save
  // ---------------------------------------------------------------------------
  loadGame(String? saveName, BuildContext context) async {
    if (saveName == null) {
      return;
    }
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'LOAD SAVE', 'Really load \'' + saveName! + '\'? You may lose current unsaved changes.'),
    );
    if (value != null && value!) {
      GameState().selectedGameSave = saveName;
      await GameSaveHandler.loadGameState(saveName);
      switchToScreen(Game(), context);
    }
  }

  // ---------------------------------------------------------------------------
  // Shows dialog for saving a game
  // ---------------------------------------------------------------------------
  quickSaveGame(BuildContext context) async {
    String? saveName = GameState().selectedGameSave;
    if (saveName == null) {
      return;
    }
    GameSaveHandler.saveGameState(saveName!);
    GameSaveHandler.updateListOfSaves();
  }

  // ---------------------------------------------------------------------------
  // Shows dialog for deleting a game save
  // ---------------------------------------------------------------------------
  deleteGame(String? saveName, BuildContext context) async {
    if (saveName == null) {
      return;
    }
    bool? value = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => createAlertDialog(context, 'DELETE SAVE', 'Really delete \'' + saveName! + '\'?'),
    );
    if (value != null && value!) {
      // TODO - DELETE SAVE
      GameSaveHandler.deleteGameState(saveName);
      GameSaveHandler.updateListOfSaves();
    }
  }

}

// -----------------------------------------------------------------------------
// Allows to select a save and load it.
// -----------------------------------------------------------------------------
class LoadGame extends GameSaves {

  Future<bool> _onWillPop() async {
    // disable back button
    return false;
  }

  @override
  bool onlyLoading() {
    return true;
  }
}

// -----------------------------------------------------------------------------
// Handles saving and loading game state
// -----------------------------------------------------------------------------
class GameSaveHandler {

  static List currentSaves = [];

  // ---------------------------------------------------------------------------
  // Saves current state under given filename
  // ---------------------------------------------------------------------------
  static saveGameState(String saveName) async {
    final file = await _localFile(saveName);

    // Create JSON from current state - TODO
    String jsonContent = GameState().toJson();

    // Write the file
    file.writeAsString(jsonContent);

    saveNameOfCurrentSave();
    updateListOfSaves();
  }

  // ---------------------------------------------------------------------------
  // Deletes file with given filename
  // ---------------------------------------------------------------------------
  static deleteGameState(String saveName) async {
    final file = await _localFile(saveName);
    // Delete the file
    print('> delete file ' + file.path);
    file.delete(recursive: false);
    updateListOfSaves();
  }

  // ---------------------------------------------------------------------------
  // Initialize current state from file with given filename
  // ---------------------------------------------------------------------------
  static loadGameState(String saveName) async {
    try {
      final file = await _localFile(saveName);
      // Read the file
      final contents = await file.readAsString();
      GameState().fromJson(contents);
    } catch (e) {
      print(e);
      // If encountering an error, return 0
    }
  }

  // ---------------------------------------------------------------------------
  // Saves name of current game save
  // ---------------------------------------------------------------------------
  static saveNameOfCurrentSave() async {
    final file = await _localLastSaveFile();
    file.writeAsString(GameState().selectedGameSave!);
    updateListOfSaves();
  }

  // ---------------------------------------------------------------------------
  // Loads name of last used game save
  // ---------------------------------------------------------------------------
  static loadLastUsedSave() async {
    try {
      final file = await _localLastSaveFile();
      final contents = await file.readAsString();
      GameState().selectedGameSave = contents;
      print('> last used save: ' + GameState().selectedGameSave!);
      await loadGameState(GameState().selectedGameSave!);
      print('> last used save loaded.');
    } catch (e) {
      // If encountering an error, return 0
    }
  }

  static updateListOfSaves() async {
    final path = await _localPath;
    var dir = Directory(path);
    currentSaves = dir.listSync();
    GameState().saveState.update();
  }

  static Future<File> _localFile(String saveName) async {
    final path = await _localPath;
    return File('$path/$saveName.save');
  }

  static Future<File> _localLastSaveFile() async {
    final path = await _localPath;
    return File('$path/game.lastsave');
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    var subDirectory = await Directory(directory.path + "/saves").create(recursive: true);
    return subDirectory.path;
  }
}

// -----------------------------------------------
// Switches back to title screen
// -----------------------------------------------
void backToTitle(BuildContext context) {
  switchToScreen(MonsterSlayerTitle(), context);
}
