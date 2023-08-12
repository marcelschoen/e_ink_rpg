

import 'package:dotted_border/dotted_border.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'models/jobs.dart';

// -----------------------------------------------------------------------------
// Handler for all available jobs (i.e. inventory of available jobs)
// -----------------------------------------------------------------------------
class AvailableJobs {
  List<Job> availableJobs = [];

  addJob(Job job) {
    availableJobs.add(job);
  }

  deselectAllJobs() {
    for (Job job in availableJobs) {
      job.selected = false;
    }
  }

  selectJob(Job job) {
    deselectAllJobs();
    job.selected = true;
  }

  add(Job job) {
    availableJobs.add(job);
  }

  List<Widget> getJobWidgets() {
    List<Widget> jobWidgets = [];
    for (Job job in availableJobs) {
      jobWidgets.add(getJobWidget(job));
    }
    return jobWidgets;
  }

}

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------
Widget getJobsScreen(BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          thickness: 20,
          isAlwaysShown: true,  // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().inventorySelectionState,
            builder: (BuildContext context, Widget? child) {
              return GridView.count(
                childAspectRatio: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  // Generate 100 widgets that display their index in the List.
                  children: GameState().availableJobs.getJobWidgets(),
              );
            },
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Colors.black54,
                    style: BorderStyle.solid,
                    width: 4
                ),
              ),
              child: SizedBox(
                height: 180,
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
                      jobDetails(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Column(children: [
            BaseButton.textOnlyWithSizes("Use", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Combine", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
            BaseButton.textOnlyWithSizes("Discard all", (p0) => { print("* NOT IMPLEMENTED *") }, 26, 160, 2 ),
          ],)
        ],
      )
    ],
  );
}


// ---------------------------------------------------------------------
// The box with the details of the selected item stack
// ---------------------------------------------------------------------
Widget jobDetails() {
  return Expanded(
    child: Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.all(5),
      child: ListenableBuilder(
        listenable: GameState().inventorySelectionState,
        builder: (BuildContext context, Widget? child) {
          return Row(
          );
        },
      ),
    ),
  );
}


// ---------------------------------------------------------------------
// Job widget
// ---------------------------------------------------------------------
Widget getJobWidget(Job job) {
  Size size = Size(100, 30);
  return InkWell(
    onTap: () {
      print("* tapped: " + job.label + " *");
      GameState().selectedInJobs = job;
      GameState().availableJobs.selectJob(job);


      GameState().inventorySelectionState.update();
      /*
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
          title: Text(itemStack.item!.name),
          content: Text(itemStack.item!.description),
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
        */
    },
    child: getJobBorder(job, Column(
      children: [
        Expanded(
          child: Container(
            constraints: BoxConstraints.tight(size),
            padding: const EdgeInsets.all(4),
            child: FittedBox(child: job.iconAsset.getIconImage()),
          ),
        ),

        Row(
          children: [
            Container(
                color: Colors.black,
                width: 24,
                height: 36,
                alignment: Alignment.center,
                child: Text('XY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
                    textAlign: TextAlign.center)
            ),
            Expanded(
              child: Text(job.label,
                  style: TextStyle(fontWeight: FontWeight.bold, ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
      ],
    ),
    ),
  );
}

// ---------------------------------------------------------------------
// Border around selected inventory item stack
// ---------------------------------------------------------------------
Widget getJobBorder(Job job, Widget content) {
  if(job.selected) {
    return DottedBorder(
      borderType: BorderType.RRect,
      strokeWidth: 4,
      color: Colors.blueGrey,
      radius: Radius.circular(8),
      padding: EdgeInsets.all(4),
      child: content,
    );
  }
  return Container(
    color: Colors.black12,
    child: content,
  );
}