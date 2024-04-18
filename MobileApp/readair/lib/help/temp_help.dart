import 'package:flutter/material.dart';

class TempHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Temperature",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Temperature refers to the measure of the warmth or coldness of an object or environment, typically measured in degrees Celsius (°C) or Fahrenheit (°F). Understanding temperature is crucial for various reasons.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Primarily, it helps us regulate our bodies and maintain comfortable living conditions. In scientific and industrial settings, precise temperature control is essential for processes ranging from cooking and climate control to manufacturing and chemical reactions.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Additionally, temperature plays a vital role in weather forecasting, agriculture, and health management, enabling us to anticipate and respond to changes in our surroundings effectively. Thus, knowing the temperature empowers us to adapt, thrive, and make informed decisions in diverse aspects of our lives.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
