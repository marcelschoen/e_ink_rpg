import 'package:dotted_border/dotted_border.dart';
import 'package:e_ink_rpg/assets.dart';
import 'package:e_ink_rpg/models/stat.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/action.dart';
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
    padding: const EdgeInsets.all(4.0),
    child: Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: enemies,
        ),
        SizedBox(
          height: 10,
        ),
        ListenableBuilder(
          listenable: GameState().hintState,
          builder: (BuildContext context, Widget? child) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(getHint(context)),
            ]);
          },
        )
      ],
    )),
  );
}

// --------------------------------------------------------------
// Create text hint shown under enemies, such as "select target"
// --------------------------------------------------------------
String getHint(BuildContext context) {
  if (CurrentFight().selectedTarget == null &&
      (CurrentFight().selectedAttack != null ||
      CurrentFight().selectedAction.runtimeType == Spy)) {
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
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
              onTap: () {
                CurrentFight().selectAttackTarget(monsterStateNotifier.being());

                // UPDATE LOWER BUTTONS
                GameState().lowerButtonsState.update();
              },
              child: getEnemyBorder(monsterStateNotifier)),
        );
      },
    );
  }
}

DottedBorder getEnemyBorder(BeingState monsterStateNotifier) {
  Color borderColor = Colors.white;
  double borderWidth = 0;
  BorderStyle borderStyle = BorderStyle.solid;
  if (monsterStateNotifier.being().state().selected) {
    borderColor = Colors.blueAccent;
    borderWidth = 5;
  } else if (monsterStateNotifier.being().state().affected) {
    borderColor = Colors.lightBlueAccent;
    borderWidth = 2;
  }
  return DottedBorder(
    borderType: BorderType.RRect,
    strokeWidth: borderWidth,
    color: borderColor,
    radius: Radius.circular(8),
    padding: EdgeInsets.all(4),
    child: getEnemyWidgetContent(monsterStateNotifier),
  );
//  return Border.all(color: borderColor, width: borderWidth);
}

Padding getEnemyWidgetContent(BeingState monsterStateNotifier) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(children: [
      Text(monsterStateNotifier.being().getSpecies()),
      getMonsterImage(monsterStateNotifier.being()),
      Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 4),
              child: getMonsterLifebarIcon(monsterStateNotifier.being())),
          getProgressBar(60, monsterStateNotifier.being().stat(StatType.health)!.progressBarValue(), 10,
              Colors.black45, Colors.black12),
        ],
      ),
    ]),
  );
}

Widget getMonsterLifebarIcon(Being enemy) {
  if (enemy.isAlive()) {
    return Image(height: 12, image: AssetImage(GameIcon.heart.filename()));
  }
  return Image(height: 12, image: AssetImage(GameIcon.death.filename()));
}

Widget getMonsterImage(Being enemy) {
  if (enemy.isAlive()) {
    return Image(
//        height: 92, image: AssetImage('assets/monster/RPG_Monster_123-3.png'));
        height: 92, image: AssetImage('assets/monster/' + enemy.species.filename));
  }
  return SizedBox(
    width: 90,
    height: 100,
  );
}
