import 'package:flutter/material.dart';

class AQIHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AQI Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "AQI: Air Quality Index",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "AQI stands for air quality index. It is used to tell us how clean or dirty the air is. It provides a simplified and easily understandable way for the public to gauge the quality of the air they are breathing. Think of AQI as a ruler that runs from 0 to 500. The higher the AQI value the worse the air quality is and the greater the health concerns.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "The Air Quality Index (AQI) is determined based on the concentrations of specific air pollutants. The main pollutants that determine AQI are Particulate Matter (PM2.5 and PM10), Ground-level Ozone (O3), Sulfur Dioxide (SO2), Nitrogen Dioxide (NO2), and Carbon Monoxide (CO).",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "For each of these pollutants, there are established concentration ranges that correspond to different AQI categories, such as \"Good,\" \"Moderate,\" \"Unhealthy,\" and so on. For the public’s safety, the AQI is typically calculated based on the highest concentration of these pollutants.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
