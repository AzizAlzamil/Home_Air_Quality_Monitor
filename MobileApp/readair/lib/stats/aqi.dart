// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:readair/data/packet.dart';
import 'package:readair/help/aqi_help.dart';
import 'package:readair/stats/graph.dart';

class AQIPage extends StatefulWidget {
  // const AQIPage({super.key, required this.title});

  // final String title;

  @override
  State<AQIPage> createState() => _AQIPageState();
}

class _AQIPageState extends State<AQIPage> {
  List<DataPacket> packets = [];
  final Random _random = Random();

  double? current;
  double? average;
  double? maxVal;
  double? minVal;
  List<FlSpot> valSpots = [];
  List<DataPoint> valDataPoints = []; // Adapted for GraphWidget

  @override
  void initState() {
    super.initState();
    fetchTempData();
  }


  Future<void> fetchTempData() async {
    List<DataPacket> lastTwentyFourHourPackets =
        await DatabaseService.instance.getPacketsForLastHours(2400);

      // Calculate other statistics as needed
    if (lastTwentyFourHourPackets.isNotEmpty) {
      current = lastTwentyFourHourPackets.first.aqi;

      valDataPoints = lastTwentyFourHourPackets
          .map((packet) => DataPoint(packet.aqi, packet.epochTime.toInt()))
          .toList();

      double totalTemp = lastTwentyFourHourPackets.map((packet) => packet.aqi).reduce((a, b) => a + b);
      average = totalTemp / lastTwentyFourHourPackets.length;

      maxVal = lastTwentyFourHourPackets.map((packet) => packet.aqi).reduce(max);
      minVal = lastTwentyFourHourPackets.map((packet) => packet.aqi).reduce(min);

      valSpots = lastTwentyFourHourPackets.asMap().entries.map((entry) => FlSpot(entry.key.toDouble(), entry.value.aqi)).toList();
    }

    setState(() {});
  }

  List<FlSpot> generateRandomData() {
    return List.generate(
        10, (index) => FlSpot(index.toDouble(), _random.nextInt(90) + 10.0));
  }

  Color? AQIColor(int value) {
    if (value <= 50) {
      return Color.fromARGB(255, 48, 133, 56);
    } else if (value > 50 && value <= 100) {
      return Color.fromARGB(255, 229, 193, 13);
    } else if (value > 101 && value <= 150) {
      return Color.fromARGB(255, 229, 114, 13);
    } else if (value > 151 && value <= 250) {
      return Color.fromARGB(255, 217, 19, 4);
    } else {
      return Color.fromARGB(255, 121, 0, 0);
    }
  }

  String AQImessage(int value) {
    if (value <= 50) {
      return "Good";
    } else if (value > 50 && value <= 100) {
      return "Moderate";
    } else if (value > 101 && value <= 150) {
      return "Moderately Bad";
    } else if (value > 151 && value <= 250) {
      return "Unhealthy";
    } else {
      return "Dangerous";
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> data = generateRandomData();

  List<DataPoint> dataPoints = valSpots
      .asMap()
      .entries
      .map((entry) => DataPoint(entry.value.y, entry.key))
      .toList();


    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Air Quality Index',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AQIHelpPage()),
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
                      color: AQIColor(current?.toInt() ?? 0),
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
                      color: AQIColor(average?.toInt() ?? 0),
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
                  child: Text('The Air Quality is ${AQImessage(current?.toInt() ?? 0)}',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),),

                                
              ),
            ),

            const Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),

                                    GraphWidget(
              title: "AQI Over Time",
              dataPoints: valDataPoints,
            ),

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
                      color: AQIColor(maxVal?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$maxVal',
                              style: TextStyle(
                                  fontSize: 50, color: Colors.white70))
                        ],
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Card(
                      color: AQIColor(minVal?.toInt() ?? 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$minVal',
                              style: TextStyle(
                                  fontSize: 50, color: Colors.white70))
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
                    child: Text('Air Quality Index',
                        style: TextStyle(fontSize: 35))),

                //trailing: Icon(Icons.wb_sunny, size: 40),
              ),
            ),

            //const SizedBox(height: 3), //Spacing between the "boxes"
            const Card(
              //IF STATEMENT! Change color with Quality of Air
              color: Color.fromARGB(255, 48, 133, 56),
              child: // ListTile(
                  //title:
                  Row(
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
                    child: Text('0-50',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            //const SizedBox(height: 3), //Spacing between the "boxes"
            const Card(
              //IF STATEMENT! Change color with Quality of Air
              color: Color.fromARGB(255, 229, 193, 13),
              child: // ListTile(
                  //title:
                  Row(
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
                    child: Text('51-100',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            //const SizedBox(height: 3), //Spacing between the "boxes"
            const Card(
              //IF STATEMENT! Change color with Quality of Air
              color: Color.fromARGB(255, 229, 114, 13),
              child: // ListTile(
                  //title:
                  Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Moderately Bad',
                          style: TextStyle(fontSize: 30, color: Colors.white70),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('101-150',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            //const SizedBox(height: 3), //Spacing between the "boxes"
            const Card(
              //IF STATEMENT! Change color with Quality of Air
              color: Color.fromARGB(255, 217, 19, 4),
              child: // ListTile(
                  //title:
                  Row(
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
                    child: Text('151-250',
                        style: TextStyle(fontSize: 30, color: Colors.white70),
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ),

            //const SizedBox(height: 3), //Spacing between the "boxes"
            const Card(
              //IF STATEMENT! Change color with Quality of Air
              color: Color.fromARGB(255, 121, 0, 0),
              child: // ListTile(
                  //title:
                  Row(
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
                    child: Text('251-500',
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

class DataGraph extends StatelessWidget {
  const DataGraph({
    super.key,
    required this.aqiSpots,
  });

  final List<FlSpot> aqiSpots;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        child: LineChart(
          LineChartData(
            minY: 0, // Y-axis begins at 0
            maxY: 100, // Y-axis peaks at 100
            gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text('${value.toInt()}');
                  },
                  reservedSize: 40,
                  interval:
                      20, // Optional: to display the side titles at given interval
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text('${(value.toInt() + 1)}');
                  },
                  reservedSize: 20,
                ),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: aqiSpots, // Here we use the actual data
                isCurved: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                color: Theme.of(context).primaryColor,
                barWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
