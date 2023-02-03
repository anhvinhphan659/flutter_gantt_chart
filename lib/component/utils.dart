// int getDaysDiff(Duration duration) {
//   int diff = 0;
//   diff = duration.inDays;
//   if(duration.inHours>0||duration.in|duration.inSeconds>0
//   return diff;
// }

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'gantt_chart_task_item.dart';

//style configuration
TextStyle monthText = const TextStyle(
  fontFamily: "Outfit",
  fontWeight: FontWeight.w400,
  fontSize: 15,
);
TextStyle dayText = const TextStyle(
  fontFamily: "Outfit",
  fontWeight: FontWeight.w300,
  fontSize: 15,
);

//end style configuration

Map<String, DateTime> getStartEndOfProject(List<GanttChartTaskItem> taskList) {
  if (taskList.isEmpty) {
    return {
      "start": DateTime.now(),
      "end": DateTime.now(),
    };
  }
  DateTime start = taskList[0].startDate ?? DateTime.now();
  DateTime end = taskList[0].endDate ?? DateTime.now();
  for (int i = 1; i < taskList.length; i++) {
    var startTask = taskList[i].startDate ?? DateTime.now();
    var endTask = taskList[i].endDate ?? DateTime.now();
    if (startTask.isBefore(start)) {
      start = startTask;
    }
    if (endTask.isAfter(end)) {
      end = endTask;
    }
  }
  return {
    "start": start,
    "end": end,
  };
}

Map<String, List<DateTime>> getMonthMap(DateTime start, DateTime end) {
  Map<String, List<DateTime>> res = {};
  DateFormat df = DateFormat("MMMM y");

  while (!start.isAfter(end)) {
    String key = df.format(start);

    if (res[key] == null) {
      res[key] = <DateTime>[];
    }
    res[key]!.add(start);
    start = start.add(const Duration(days: 1));
  }
  return res;
}
