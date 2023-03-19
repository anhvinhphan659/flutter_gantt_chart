import 'package:flutter/material.dart';
import 'package:flutter_gant_chart/component/gantt_chart_task_item.dart';
import 'package:flutter_gant_chart/component/gantt_chart_task_item_widget.dart';
import 'package:flutter_gant_chart/component/utils.dart';

class GanttChart extends StatefulWidget {
  //with of column in chart (by date)
  final double? columnWidth;

  //height of row (except header)
  final double? rowHeight;

  ///Add some day before begin day
  final int additionBeginDays;

  ///Add some day after end day
  final int additionEndDays;

  final TextStyle? headerTextStyle;

  final TextStyle? dayTextStyle;

  final TextStyle? taskItemTextStyle;

  ///List of tasks in gantt chart
  final List<GanttChartTaskItem> taskItems;
  const GanttChart(
      {this.additionBeginDays = 1,
      this.additionEndDays = 1,
      required this.taskItems,
      this.columnWidth,
      this.rowHeight,
      this.dayTextStyle,
      this.headerTextStyle,
      this.taskItemTextStyle,
      Key? key})
      : super(key: key);

  @override
  State<GanttChart> createState() => _GanttChartState();
}

class _GanttChartState extends State<GanttChart> {
  //constant
  static const double HEADER_HEIGHT_DEFAULT = 60;
  static const double DAY_ROW_HEIGHT_DEFAULT = 30;
  static const double DAY_COLUMN_WIDTH_DEFAULT = 60;

  List<GanttChartTaskItem> taskItems = [];
  List<Widget> taskWidgets = [];

  late DateTime startDateProject;
  late DateTime endDateProject;

  Map<String, List<DateTime>> monthMap = {};

  double rowHeight = 0;
  double columnWidth = 0;

  @override
  void initState() {
    setUpDefault();
    var data = getStartEndOfProject(taskItems);
    //update startday and endday
    data["start"] =
        data["start"]!.subtract(Duration(days: widget.additionBeginDays));
    data["end"] =
        data["end"]!.subtract(Duration(days: widget.additionBeginDays));

    //generate map
    monthMap = getMonthMap(
      (data["start"] ?? DateTime.now()).subtract(
        Duration(days: widget.additionBeginDays),
      ),
      (data["end"] ?? DateTime.now())
          .add(Duration(days: widget.additionEndDays)),
    );
    //generate task widget
    taskWidgets = List.generate(taskItems.length, (index) {
      double startLeft = (taskItems[index].startDate ?? DateTime.now())
              .difference(data["start"]!)
              .inDays *
          columnWidth;

      return Positioned(
        top: (index + 2) * rowHeight + 4,
        left: startLeft,
        child: GanttChartTaskItemWidget(
          taskItem: taskItems[index],
          rowHeight: rowHeight - 4,
          dateWidth: columnWidth,
          taskItemStyle: widget.taskItemTextStyle,
        ),
      );
    });

    super.initState();
  }

  void setUpDefault() {
    //set up size
    rowHeight = widget.rowHeight ?? DAY_ROW_HEIGHT_DEFAULT;
    columnWidth = widget.columnWidth ?? DAY_COLUMN_WIDTH_DEFAULT;
    //set up tasks
    taskItems = widget.taskItems;
    //set up styles
  }

  @override
  Widget build(BuildContext context) {
    double tableHeight = (taskItems.length + 5) * DAY_ROW_HEIGHT_DEFAULT;

    return ListView(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Stack(
            children: [
              Row(
                children: [
                  ...monthMap.keys.map(
                    (key) => Row(
                      children: [
                        SizedBox(
                          width: (monthMap[key] ?? []).length *
                              DAY_COLUMN_WIDTH_DEFAULT,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  alignment: Alignment.centerLeft,
                                  height: HEADER_HEIGHT_DEFAULT,
                                  child: Text(
                                    key.toUpperCase(),
                                    style: widget.headerTextStyle ?? monthText,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                SizedBox(
                                  height: DAY_ROW_HEIGHT_DEFAULT,
                                  child: Row(
                                    children: List.generate(
                                      (monthMap[key] ?? []).length,
                                      (index) => Container(
                                        width: DAY_COLUMN_WIDTH_DEFAULT,
                                        alignment: Alignment.center,
                                        child: Text(
                                          monthMap[key]![index].day.toString(),
                                          style: widget.dayTextStyle ?? dayText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      tableHeight - DAY_ROW_HEIGHT_DEFAULT * 2,
                                  child: Row(
                                    children: List.generate(
                                      (monthMap[key] ?? []).length,
                                      (index) => Row(
                                        children: [
                                          Container(
                                            width: DAY_COLUMN_WIDTH_DEFAULT,
                                          ),
                                          const VerticalDivider(
                                            color: Colors.grey,
                                            width: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                        const VerticalDivider(
                          color: Colors.grey,
                          indent: 0,
                          width: 0,
                          endIndent: 0,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ...taskWidgets
            ],
          ),
        ),
      ],
    );
  }
}
