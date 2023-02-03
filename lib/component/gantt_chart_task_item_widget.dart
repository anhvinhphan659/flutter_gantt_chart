import 'package:flutter/material.dart';
import 'package:flutter_gant_chart/component/gantt_chart_task_item.dart';

class GanttChartTaskItemWidget extends StatelessWidget {
  /*
  width of this widget will be calculated by fomular: width = dateWidth * dateDiff 
  */
  final double dateWidth;
  //height display of task
  final double rowHeight;

  DateTime? startDate;
  DateTime? endDate;
  final GanttChartTaskItem taskItem;

  GanttChartTaskItemWidget(
      {this.dateWidth = 60.0,
      this.rowHeight = 30.0,
      required this.taskItem,
      super.key});

  late int dateDiff;
  void onInit() {
    startDate = taskItem.startDate ?? DateTime.now();

    endDate = taskItem.endDate ?? DateTime.now();

    dateDiff = endDate!.difference(startDate!).inDays + 1;
  }

  @override
  Widget build(BuildContext context) {
    onInit();
    double taskWidth = dateWidth * dateDiff;
    return Container(
      width: taskWidth + 100,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              color: taskItem.restProgressColor,
              width: taskWidth,
              height: rowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 4.0),
                    decoration: BoxDecoration(
                      color: taskItem.onProgressColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                    ),
                    width: taskWidth * taskItem.percent / 100,
                    height: rowHeight,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      taskItem.taskDescription,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: taskWidth * taskItem.percent / 100 + 4,
              child: Container(
                alignment: Alignment.centerLeft,
                height: rowHeight,
                child: Text(
                  "${taskItem.percent.ceil()}%",
                ),
              ))
        ],
      ),
    );
  }
}
