// ****************************************
// constants for icon assets
// ****************************************
enum GameIcon {

  attack('icon163.png'),
  fight('icon2.png'),
  flee('icon8.png'),
  heart('icon23.png'),
  death('icon11.png'),
  magic('icon37.png'),
  skill('icon9.png'),
  spy('icon35.png'),
  ;

  const GameIcon(this._filename);

  final String _filename;

  String filename() {
    return 'assets/icons/' + this._filename;
  }
}

// ****************************************
// constants for image assets
// ****************************************
enum GameMonsterImages {

  monster('bloodbat.png'),
  ;

  const GameMonsterImages(this._filename);

  final String _filename;

  String filename() {
    return 'assets/monster/' + this._filename;
  }
}

// ****************************************
// constants for image assets
// ****************************************
enum GameNpcImages {

  player('Human1.png'),
  ;

  const GameNpcImages(this._filename);

  final String _filename;

  String filename() {
    return 'assets/humanoid/' + this._filename;
  }
}
