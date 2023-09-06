import 'package:dotted_border/dotted_border.dart';
import 'package:e_ink_rpg/shared.dart';
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'fight.dart';
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

  reset() {
    availableJobs = [];
    deselectAllJobs();
  }

  add(Job job) {
    availableJobs.add(job);
  }
}

// -----------------------------------------------------------------------------
// Jobs screen
// -----------------------------------------------------------------------------
Widget getJobsScreen(BuildContext context) {
  ScrollController scrollController = ScrollController();
  return Column(
    children: [
      Expanded(
        child: Scrollbar(
          controller: scrollController,
          thickness: 20,
          isAlwaysShown: true, // TODO - FIND BETTER SOLUTION
          child: ListenableBuilder(
            listenable: GameState().jobSelectionState,
            builder: (BuildContext context, Widget? child) {
              return getJobsList(context, scrollController);
            },
          ),
        ),
      ),
      Row(
        children: [
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                //<-- SEE HERE
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Colors.black54, style: BorderStyle.solid, width: 4),
              ),
              child: SizedBox(
                height: 180,
                child: Container(
                  child: Column(
                    children: [
                      getDetailsBar('Details'),
                      jobDetails(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ListenableBuilder(
            listenable: GameState().jobsButtonState,
            builder: (BuildContext context, Widget? child) {
              String label = 'Start';
              if (GameState().selectedInJobs == null) {
                label = '...';
              }
              return BaseButton.textOnlyWithSizes(
                  label, (p0) => {startSelectedJob(context)}, 40, 160, 2);
            },
          ),
        ],
      )
    ],
  );
}

Widget getJobsList(BuildContext context, ScrollController scrollController) {
  List<Widget> jobEntries = [];

  jobEntries.add(getListSectionTitle('Available jobs', 16));

  for (Job job in GameState().availableJobs.availableJobs) {
    if (!job.finished) {
      jobEntries.add(getJobListEntry(context, job));
    }
  }

  jobEntries.add(getListSectionTitle('Completed jobs', 40));

  for (Job job in GameState().availableJobs.availableJobs) {
    if (job.finished) {
      jobEntries.add(getJobListEntry(context, job));
    }
  }

  return ListView.builder(
    controller: scrollController,
      itemCount: GameState().availableJobs.availableJobs.length + 2,
      itemBuilder: (BuildContext context, int index) {
        return jobEntries[index];
      });
}

Container getDetailsBar(String label) {
  return Container(
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
          Text(label, style: getTitleTextStyle(18)),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// Creates a title label for a section in the jobs list
// -----------------------------------------------------------------------------
Widget getListSectionTitle(String title, double topPadding) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, topPadding, 16, 16),
    child: Text(title, style: getTitleTextStyle(16)),
  );
}

// -----------------------------------------------------------------------------
// Returns a tappable job list entry (icon + label)
// -----------------------------------------------------------------------------
Widget getJobListEntry(BuildContext context, Job job) {
  return InkWell(
    onTap: () {
      GameState().selectedInJobs = job;
      GameState().availableJobs.selectJob(job);
      GameState().jobSelectionState.update();
      GameState().jobsButtonState.update();
    },
    child: getJobBorder(
        job,
        Column(
          children: [
            Row(
              children: [
                job.iconAsset.getIconImage(),
                Expanded(
                  child: Text(job.label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ],
        )),
  );
}

// ---------------------------------------------------------------------
// Border around selected inventory item stack
// ---------------------------------------------------------------------
Widget getJobBorder(Job job, Widget content) {
  if (job.selected) {
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

// ---------------------------------------------------------------------
// Starts the fight for the current selected job
// ---------------------------------------------------------------------
startSelectedJob(BuildContext context) {
  if (GameState().selectedInJobs != null) {
    startFight(context, GameState().selectedInJobs!);
  }
}

// ---------------------------------------------------------------------
// The box with the details of the selected item stack
// ---------------------------------------------------------------------
Widget jobDetails() {
  return Container(
    alignment: Alignment.topLeft,
    margin: EdgeInsets.all(5),
    child: ListenableBuilder(
      listenable: GameState().jobSelectionState,
      builder: (BuildContext context, Widget? child) {
        return getSelectedJobDetails();
      },
    ),
  );
}

// ---------------------------------------------------------------------
// The job image and description of the selected job
// ---------------------------------------------------------------------
Widget getSelectedJobDetails() {
  if (GameState().selectedInJobs != null) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: Column(
              children: [
                getTextLine(GameState().selectedInJobs!.description, 20),
                SizedBox(height: 10,),
                getTextLine('Rewards:', 16),
                getTextLine(getRewardsInfo(GameState().selectedInJobs!), 16),
              ],
            )),

      ],
    );
  }
  return Container();
}

String getRewardsInfo(Job job) {
  List<String> rewards = [];
  if (job.xp > 0 && !job.finished) {
    rewards.add(GameState().selectedInJobs!.xp.toString() + ' XP');
  }
  if (job.payment > 0) {
    rewards.add(GameState().selectedInJobs!.payment.toString() + ' Gold');
  }
  return rewards.join(', ');
}

Text getTextLine(String text, double size) {
  return Text(text, style: getTitleTextStyle(size));
}

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
