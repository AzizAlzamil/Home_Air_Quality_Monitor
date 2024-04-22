import 'package:flutter/material.dart';
import 'package:readair/data/packet.dart';
import 'package:readair/stats/graph.dart';

class StatsPage extends StatefulWidget {
  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  List<DataPacket> packets = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    packets = await _fetchLastFivePackets(); // Fetch the last packets
    setState(() {});
  }

  Future<List<DataPacket>> _fetchLastFivePackets() async {
    List<DataPacket> packets = await DatabaseService.instance.getLastFivePackets();
    return packets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Graphical Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Passing data to GraphWidget
              GraphWidget(title: "AQI", dataPoints: _convertToDataPoints(packets, (p) => p.aqi)),
              GraphWidget(title: "Temperature", dataPoints: _convertToDataPoints(packets, (p) => p.temp)),
              GraphWidget(title: "Carbon Dioxide", dataPoints: _convertToDataPoints(packets, (p) => p.co2)),
              GraphWidget(title: "Humidity", dataPoints: _convertToDataPoints(packets, (p) => p.humid)),
              GraphWidget(title: "Carbon Monoxide", dataPoints: _convertToDataPoints(packets, (p) => p.co)),
              GraphWidget(title: "Volatile Organic Compounds", dataPoints: _convertToDataPoints(packets, (p) => p.voc)),
              GraphWidget(title: "Nitrogen Oxides", dataPoints: _convertToDataPoints(packets, (p) => p.nox)),
              GraphWidget(title: "Methane", dataPoints: _convertToDataPoints(packets, (p) => p.ng)),
              GraphWidget(title: "Particulate Matter 2.5", dataPoints: _convertToDataPoints(packets, (p) => p.ppm2_5)),
              
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to convert packets to DataPoint list
  List<DataPoint> _convertToDataPoints(List<DataPacket> packets, double Function(DataPacket) valueExtractor) {
    return packets
        .map((packet) => DataPoint(valueExtractor(packet), packet.epochTime.toInt()))
        .toList();
  }
}
