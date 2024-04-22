// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:readair/data/packet.dart';
import 'package:readair/help/methane_help.dart';
import 'package:readair/stats/graph.dart';

class MethanePage extends StatefulWidget {
  @override
  State<MethanePage> createState() => _MethanePageState();
}

class _MethanePageState extends State<MethanePage> {
  final Random _random = Random();
  List<FlSpot> generateRandomData() {
    return List.generate(
        10, (index) => FlSpot(index.toDouble(), _random.nextInt(90) + 10.0));
  }

  double? current;
  double? average;
  double? maxVal;
  double? minVal;
  List<FlSpot> valSpots = [];
   List<DataPoint> valDataPoints = [];

      @override
  void initState() {
    super.initState();
    fetchValData();
  }

    Future<void> fetchValData() async {
    List<DataPacket> lastTwentyFourHourPackets =
        await DatabaseService.instance.getPacketsForLastHours(2400);

    if (lastTwentyFourHourPackets.isNotEmpty) {
      current = lastTwentyFourHourPackets.first.ng;

            valDataPoints = lastTwentyFourHourPackets
          .map((packet) => DataPoint(packet.ng, packet.epochTime.toInt()))
          .toList();

      double totalVal = lastTwentyFourHourPackets.map((packet) => packet.ng).reduce((a, b) => a + b);
      average = totalVal / lastTwentyFourHourPackets.length;

      maxVal = lastTwentyFourHourPackets.map((packet) => packet.ng).reduce(max);
      minVal = lastTwentyFourHourPackets.map((packet) => packet.ng).reduce(min);

      valSpots = lastTwentyFourHourPackets.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value.ng)).toList();
    }

    setState(() {});
  }

  Color? CoordinatedColor(int value) {
    //Colors cordinated with the danger levels
    if (value <= 99) {
      return Color.fromARGB(255, 48, 133, 56);
    } else if (value > 99 && value <= 100) {
      return Color.fromARGB(255, 229, 193, 13);
    } else if (value > 100 && value <= 400) {
      return Color.fromARGB(255, 229, 114, 13);
    } else if (value > 400 && value <= 1000) {
      return Color.fromARGB(255, 217, 19, 4);
    } else {
      return Color.fromARGB(255, 121, 0, 0);
    }
  }

  String message(int value) {
    //Displays message below current value
    if (value <= 99) {
      return "Good";
    } else if (value > 99 && value <= 100) {
      return "Moderate";
    } else if (value > 100 && value <= 400) {
      return "Bad";
    } else if (value > 400 && value <= 1000) {
      return "Unhealthy";
    } else {
      return "Dangerous";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> data = generateRandomData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Methane (ppm)',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MethaneHelpPage()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10), //Spacing between the "boxes"
              const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Current value',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Average value', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                      color: CoordinatedColor(current?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${current?.toStringAsFixed(1) ?? '-'}',
                              style: TextStyle(
                                  fontSize: 38, color: Colors.white70)),
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                      color: CoordinatedColor(average?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${average?.toStringAsFixed(1) ?? '-'}',
                              style: TextStyle(
                                  fontSize: 38, color: Colors.white70)),
                        ],
                      )),
                ),
              ],
            ),
            
            Padding(
              padding: EdgeInsets.all(2.0),
              child: ListTile(
                title: Center(child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                        'The Methane level is ${message(current?.toInt() ?? 0)}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                ),),
              ),
            ),

            const Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

            const Padding(
              padding: EdgeInsets.all(6.0),
              child: ListTile(
                title: Center(
                    child:
                        Text('24 Hour Span', style: TextStyle(fontSize: 30))),
              ),
            ),

                                                GraphWidget(
              title: "Methane Over Time",
              dataPoints: valDataPoints,
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     height: 300,
            //     child: LineChart(
            //       LineChartData(
            //         gridData: FlGridData(show: false),
            //         titlesData: FlTitlesData(
            //           leftTitles: AxisTitles(
            //             sideTitles: SideTitles(
            //               showTitles: true,
            //               getTitlesWidget: (value, meta) {
            //                 if (value % 10 == 0)
            //                   return Text('${value.toInt()}');
            //                 return Text('');
            //               },
            //               reservedSize: 40,
            //             ),
            //           ),
            //           bottomTitles: AxisTitles(
            //             sideTitles: SideTitles(
            //               showTitles: true,
            //               getTitlesWidget: (value, meta) {
            //                 return Text('${value.toInt()}');
            //               },
            //               reservedSize: 20,
            //             ),
            //           ),
            //         ),
            //         borderData: FlBorderData(show: true),
            //         lineBarsData: [
            //           LineChartBarData(
            //             spots: valSpots,
            //             isCurved: true,
            //             dotData: FlDotData(show: false),
            //             belowBarData: BarAreaData(show: false),
            //             color: Colors.blue,
            //             barWidth: 3,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),

            const Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Maximum',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Minimum', style: TextStyle(fontSize: 25)),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                      color: CoordinatedColor(maxVal?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${maxVal?.toStringAsFixed(1) ?? '-'}',
                              style: TextStyle(
                                  fontSize: 50, color: Colors.white70)),
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                      color: CoordinatedColor(minVal?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${minVal?.toStringAsFixed(1) ?? '-'}',
                              style: TextStyle(
                                  fontSize: 50, color: Colors.white70)),
                        ],
                      )),
                ),
              ],
            ),

            const Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

            const Padding(
              padding: EdgeInsets.all(6.0),
              child: ListTile(
                title: Center(
                    child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Methane Index (ppm)',
                    style: TextStyle(fontSize: 40),
                  ),
                )),
              ),
            ),

            const Card(
              color: Color.fromARGB(255, 48, 133, 56),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Good',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Less than 100',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            const Card(
              color: Color.fromARGB(255, 229, 193, 13),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Moderate',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('100 for 8 hours',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            const Card(
              color: Color.fromARGB(255, 229, 114, 13),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Bad',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('101-400',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            const Card(
              color: Color.fromARGB(255, 217, 19, 4),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Unhealthy',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('401-1,000',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            const Card(
              color: Color.fromARGB(255, 121, 0, 0),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Dangerous',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Over 1,000',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}