import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DataPoint {
  final double measurement;
  final int epoch;

  DataPoint(this.measurement, this.epoch);
}

enum TimeRange { last24Hours, lastWeek, allTime }

class GraphWidget extends StatefulWidget {
  final String title;
  final List<DataPoint> dataPoints;

  const GraphWidget({Key? key, required this.title, required this.dataPoints})
      : super(key: key);

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  TimeRange _selectedTimeRange = TimeRange.last24Hours; // Default value

  @override
  Widget build(BuildContext context) {

    final filteredDataPoints = _filterDataPoints(widget.dataPoints, _selectedTimeRange);
    final points = filteredDataPoints;
    final double minY = points.isNotEmpty
        ? max(points.map((e) => e.measurement).reduce(min) - 100.0, 0.0)
        : 0.0;
    final double maxY = points.isNotEmpty
        ? points.map((e) => e.measurement).reduce(max) + 100.0
        : 100.0;

    double xLabelInterval = max(1, points.length / 5);
    double yLabelInterval = (maxY - minY) / 5;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: DropdownButton<TimeRange>(
            value: _selectedTimeRange,
            onChanged: (TimeRange? newValue) {
              setState(() {
                _selectedTimeRange = newValue!;
              });
            },
            items: <TimeRange>[
              TimeRange.last24Hours,
              TimeRange.lastWeek,
              TimeRange.allTime
            ].map<DropdownMenuItem<TimeRange>>((TimeRange value) {
              return DropdownMenuItem<TimeRange>(
                value: value,
                child: Text(_getTimeRangeText(value)),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(widget.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 320,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()}');
                      },
                      interval: yLabelInterval,
                    ),
                  ),
                  bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
              final int index = value.toInt();
              if (index >= 0 && index < points.length) {
                  final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      points[index].epoch * 1000);
                  String formattedDate;
                  switch (_selectedTimeRange) {
                      case TimeRange.last24Hours:
                          formattedDate = DateFormat('HH:mm').format(date); // Time for last 24 hours
                          break;
                      case TimeRange.lastWeek:
                      case TimeRange.allTime:
                          formattedDate = DateFormat('MM/dd').format(date); // Date for last week and all time
                          break;
                  }
                  return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                          formattedDate,
                          style: TextStyle(fontSize: 10),
                      ),
                  );
              }
              return Container();
          },
          interval: max(1, points.length / 5), // Adjusting the interval for clarity
            ),
        ),
                  // bottomTitles: AxisTitles(
                  //   sideTitles: SideTitles(
                  //     showTitles: true,
                  //     reservedSize: 30,
                  //     getTitlesWidget: (value, meta) {
                  //       final int index = value.toInt();
                  //       if (index >= 0 && index < points.length) {
                  //         final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                  //             points[index].epoch * 1000);
                  //         return Padding(
                  //           padding: const EdgeInsets.only(top: 10.0),
                  //           child: Text(
                  //             DateFormat('MM/dd HH:mm').format(date),
                  //             style: TextStyle(fontSize: 10),
                  //           ),
                  //         );
                  //       }
                  //       return Container();
                  //     },
                  //     interval: xLabelInterval,
                  //   ),
                  // ),
                  // Hiding top and right titles
                                  topTitles: AxisTitles(
                    // Hide top titles
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    // Hide right titles
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.black, width: 2), // Show bottom side
                    left: BorderSide(
                        color: Colors.black, width: 2), // Show left side
                    top: BorderSide.none, // Hide top side
                    right: BorderSide.none, // Hide right side
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _createSpots(points),
                    isCurved: false, // Set this to false to remove curve effect
                    // Or set this to true and adjust the below property
                    // curveSmoothness: 0.1, // Experiment with this value to reduce curve effect
                    dotData: FlDotData(
                        show: false,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.blue,
                            strokeWidth: 1.5,
                            strokeColor: Colors.white,
                          );
                        }),
                    belowBarData: BarAreaData(show: false),
                    color: Colors.blue,
                    barWidth: 3,
                  ),
                ],
                minY: minY,
                maxY: maxY,
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: Colors.blueAccent,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        final DateTime date = DateTime.fromMillisecondsSinceEpoch(
                            points[touchedSpot.spotIndex].epoch * 1000);
                        String tooltipText =
                            DateFormat('MM/dd/yyyy HH:mm').format(date) +
                                ': ' +
                                touchedSpot.y.toStringAsFixed(2);
                        return LineTooltipItem(
                          tooltipText,
                          const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  // List<FlSpot> _createSpots(List<DataPoint> points) {
  //   return List.generate(points.length,
  //       (index) => FlSpot(index.toDouble(), points[index].measurement));
  // }

List<FlSpot> _createSpots(List<DataPoint> points) {
    // No need to reverse, ensure that data is sorted by epoch (if not already)
    points.sort((a, b) => a.epoch.compareTo(b.epoch));

    return List.generate(points.length, (index) {
        // Convert each DataPoint to an FlSpot using the index as x-value and measurement as y-value
        return FlSpot(index.toDouble(), points[index].measurement);
    });
}


  List<DataPoint> _filterDataPoints(
      List<DataPoint> dataPoints, TimeRange timeRange) {
    final now = DateTime.now();
    switch (timeRange) {
      case TimeRange.last24Hours:
        final last24HoursEpoch =
            now.subtract(Duration(hours: 24)).millisecondsSinceEpoch ~/ 1000;
        return dataPoints
            .where((point) => point.epoch >= last24HoursEpoch)
            .toList();
      case TimeRange.lastWeek:
        final lastWeekEpoch =
            now.subtract(Duration(days: 7)).millisecondsSinceEpoch ~/ 1000;
        return dataPoints
            .where((point) => point.epoch >= lastWeekEpoch)
            .toList();
      case TimeRange.allTime:
        return dataPoints;
    }
  }

  String _getTimeRangeText(TimeRange timeRange) {
    switch (timeRange) {
      case TimeRange.last24Hours:
        return 'Last 24 Hours';
      case TimeRange.lastWeek:
        return 'Last Week';
      case TimeRange.allTime:
        return 'All Time';
      default:
        return '';
    }
  }
}
