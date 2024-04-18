import 'package:flutter/material.dart';

class HumidityHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Humidity Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Humidity",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Humidity, the measure of moisture in the air, plays a pivotal role in our daily lives and various industries. It directly influences our comfort levels, impacting how hot or cold the air feels. Excessive humidity can lead to discomfort and even health issues like heat exhaustion, while low humidity can cause dry skin and respiratory irritation.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Moreover, humidity affects productivity and concentration; high levels can induce lethargy, while low levels can lead to fatigue. Beyond personal comfort, humidity also has significant implications for materials and equipment, such as wood, electronics, and paper. High humidity can cause swelling and corrosion, while low humidity can result in shrinkage and brittleness.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Furthermore, humidity is integral to weather forecasting, influencing cloud formation, precipitation, and atmospheric stability. Thus, monitoring humidity levels is vital for maintaining comfort, promoting health, preserving materials, and predicting weather conditions.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
