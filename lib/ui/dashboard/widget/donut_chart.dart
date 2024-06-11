import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penatu/ui/styles/theme.dart';

class DonutChart extends StatefulWidget {
  final double done, onProgress, pending;

  DonutChart(this.done, this.onProgress, this.pending);

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  var now = DateTime.now();
  var formatter = DateFormat('MMMM yyyy');
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
            height: size.height * 0.25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      PieChart(
                        PieChartData(
                          startDegreeOffset: 0,
                          sectionsSpace: 0,
                          centerSpaceRadius: 50,
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sections: [
                            PieChartSectionData(
                              value: this.widget.done,
                              color: StatusColor.done,
                              title: 'Done',
                              radius: 32,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: this.widget.onProgress,
                              color: StatusColor.onProgress,
                              title: 'On Progress',
                              radius: 32,
                              showTitle: false,
                            ),
                            PieChartSectionData(
                              value: this.widget.pending,
                              color: StatusColor.pending,
                              title: 'Pending',
                              radius: 32,
                              showTitle: false,
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                '${(this.widget.done + this.widget.pending + this.widget.onProgress).toInt()}',
                                // '${(this.widget.done + this.widget.pending + this.widget.onProgress).toInt()}',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                              Text(
                                'Pesanan',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Indicator(
                      color: StatusColor.done,
                      text: 'Done',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: StatusColor.onProgress,
                      text: 'On Progress',
                      isSquare: false,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Indicator(
                      color: StatusColor.pending,
                      text: 'Pending',
                      isSquare: false,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
