import 'package:flutter/material.dart';

class GanttChartTaskItem {
  double percent;
  String taskDescription;
  Color onProgressColor;
  Color? restProgressColor;
  DateTime? startDate;
  DateTime? endDate;

  GanttChartTaskItem(
      {this.percent = 0.0,
      this.onProgressColor = Colors.red,
      this.taskDescription = "",
      this.restProgressColor,
      this.startDate,
      this.endDate,
      Key? key});
}
