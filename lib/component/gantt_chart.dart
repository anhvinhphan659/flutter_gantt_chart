import 'package:flutter/material.dart';

class GanttChart extends StatefulWidget {
  const GanttChart({Key? key}) : super(key: key);

  @override
  State<GanttChart> createState() => _GanttChartState();
}

class _GanttChartState extends State<GanttChart> {
  static const double MONTH_ROW_HEIGHT = 30;
  static const double DAY_ROW_HEIGHT = 30;

  @override
  Widget build(BuildContext context) {
    int monthDiff = 2;
    int dayDiff = 9;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 300,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text("December"),
                      height: MONTH_ROW_HEIGHT,
                    ),
                    Container(
                      color: Colors.red,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          4,
                          (index) => Text(
                            (31 - index).toString(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.yellow,
                            width: 75,
                          ),
                          VerticalDivider(
                            color: Colors.red,
                            width: 0,
                          ),
                          Container(
                            color: Colors.white,
                            width: 75,
                          ),
                          VerticalDivider(
                            color: Colors.red,
                            width: 0,
                          ),
                          Container(
                            color: Colors.white,
                            width: 75,
                          ),
                          VerticalDivider(
                            color: Colors.red,
                            width: 0,
                          ),
                          Container(
                            color: Colors.white,
                            width: 75,
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
            VerticalDivider(
              color: Colors.green,
              indent: 0,
              width: 0,
              endIndent: 0,
            ),
            // Container(
            //   width: 450,
            //   color: Colors.white,
            //   child: Column(children: [
            //     Text("January"),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: List.generate(
            //         7,
            //         (index) => Text(
            //           index.toString(),
            //         ),
            //       ),
            //     )
            //   ]),
            // ),
            // VerticalDivider(
            //   color: Colors.green,
            // ),
            // Container(
            //   width: 150,
            //   color: Colors.white,
            // ),
          ],
        ),
      ),
    );
  }
}
