import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/beings.dart';

// ----------------------------------------------------
// Enemies display
// ----------------------------------------------------

Widget enemyDisplay(BuildContext context) {
  List<Widget> enemies = [];
  for (Being enemy in CurrentFight().enemies()) {
    enemies.add(EnemyWidget(monsterStateNotifier: enemy.state()));
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: enemies,
            ),
            SizedBox(height: 10,),
            ListenableBuilder (
              listenable: GameState(),
              builder: (BuildContext context, Widget? child) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getHint(context)),
                    ]
                );
              },
            )
          ],
        )),
  );
}

String getHint(BuildContext context) {
  print("> selected attack: " + (CurrentFight().selectedAttack == null ? 'null' : CurrentFight().selectedAttack!.name() ));
  if (CurrentFight().selectedTarget == null && CurrentFight().selectedAttack != null) {
    return 'TAP ENEMY TO SELECT TARGET';
  }
  return '';
}

// -------------------------------------
// Widget for a single enemy
// -------------------------------------
class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key, required this.monsterStateNotifier});

  final BeingState monsterStateNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: monsterStateNotifier,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell (
            onTap: (){
              CurrentFight().selectAttackTarget(monsterStateNotifier.being());
              GameState().update();
            },
            child: Container(
              foregroundDecoration:
              BoxDecoration(border: getEnemyBorder(monsterStateNotifier.being())),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Text(monsterStateNotifier.being().getSpecies()),
                  getMonsterImage(monsterStateNotifier.being()),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(right: 4),
                          child: getMonsterLifebarIcon(monsterStateNotifier.being())
                      ),
                      SizedBox(
                          width: 60,
                          child: LinearProgressIndicator(
                              value: (monsterStateNotifier.being().health().toDouble() /
                                  monsterStateNotifier.being().maxHealth().toDouble()),
                              minHeight: 10,
                              color: Colors.black45,
                              backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation(Colors.black54))),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}

BoxBorder getEnemyBorder(Being enemy) {
  Color borderColor = Colors.white;
  double borderWidth = 0;
  if(enemy.state().selected) {
    borderColor = Colors.blueAccent;
    borderWidth = 5;
  } else if(enemy.state().affected) {
    borderColor = Colors.blueAccent;
    borderWidth = 2;
  }
  return Border.all(color: borderColor, width: borderWidth);
}

Widget getMonsterLifebarIcon(Being enemy) {
  if(enemy.isAlive()) {
    return Image(
        height: 12,
        image: AssetImage(GameIcon.heart.filename()));
  }
  return Image(
      height: 12,
      image: AssetImage(GameIcon.death.filename()));
}

Widget getMonsterImage(Being enemy) {
  if(enemy.isAlive()) {
    return Image(
        height: 92,
        image: AssetImage('assets/monster/RPG_Monster_123-3.png'));
  }
  return SizedBox(width: 90, height: 100,);
}
