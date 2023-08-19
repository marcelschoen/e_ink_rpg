

// --------------------------------------------------------------------
// Day or night (easier or harder monsters)
// --------------------------------------------------------------------
import 'package:e_ink_rpg/state.dart';
import 'package:flutter/material.dart';

import 'assets.dart';

enum OverallTime {
  day,
  night
}

// --------------------------------------------------------------------
// Detail time (mostly for atmosphere)
// --------------------------------------------------------------------
enum DetailTime {
  dawn(OverallTime.day, 'Dawn', 5, 6, GameImageAsset.daytime_morning),
  morning(OverallTime.day, 'Morning', 6, 12, GameImageAsset.daytime_day),
  noon(OverallTime.day, 'Noon', 12, 13, GameImageAsset.daytime_day),
  afternoon(OverallTime.day, 'Afternoon', 13, 19, GameImageAsset.daytime_day),
  evening(OverallTime.day, 'Evening', 19, 21, GameImageAsset.daytime_evening),
  dusk(OverallTime.night, 'Dusk', 21, 22, GameImageAsset.daytime_evening),
  night(OverallTime.night, 'Night', 22, 23, GameImageAsset.daytime_night),
  night2(OverallTime.night, 'Night', 0, 5, GameImageAsset.daytime_night),
  ;

  final OverallTime overallTime;
  final label;
  final int startingHour;
  final int endingHour;
  final GameImageAsset image;

  const DetailTime(this.overallTime, this.label, this.startingHour, this.endingHour, this.image);

  Widget getImage() {
    return getSizedImage(this.image.filename(), 32);
  }

  static DetailTime getByHourOfDay(int hour) {
    for (DetailTime detailTime in DetailTime.values) {
      if (hour >= detailTime.startingHour && hour <= detailTime.endingHour) {
        return detailTime;
      }
    }
    print('****************************** FAILED TO DETERMINE TIME. HOUR: ' + hour.toString());
    return DetailTime.afternoon;
  }
}

// --------------------------------------------------------------------
// Holds and calculates time of day information
// --------------------------------------------------------------------
class GameDaytime {

  static const int minutesPerDay = 24 * 60;

  int _internalMinute = 0;

  /**
   * Call this from any long-duration game action to advance the time by n hours.
   */
  advanceByHours(int hours) {
    advanceByMinutes(hours * 60);
  }

  /**
   * Call this from any quick game action to advance the time by n minutes.
   */
  advanceByMinutes(int minutes) {
    DetailTime oldTime = getDetail();
    _internalMinute += minutes;
    if (_internalMinute >= minutesPerDay) {
      _internalMinute = 0;
    }
    if (getDetail() != oldTime) {
      GameState().appBarTitleState.update();
    }
  }

  /**
   * Gets the descriptive daytime label.
   */
  String getLabel() {
    return getDetail().label;
  }

  DetailTime getDetail() {
    print('___> INTERNAL MINUTE: ' + _internalMinute.toString());
    int hourOfDay = _internalMinute ~/ 60;
    print('___> HOUR OF DAY: ' + hourOfDay.toString());
    DetailTime detailTime = DetailTime.getByHourOfDay(hourOfDay);
    print('___> DETAIL TIME: ' + detailTime.name + ' / ' + detailTime.label);
    return detailTime;
  }
}