import 'package:flutter/material.dart';

class VOCHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VOC Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Volatile Organic Compounds",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Volatile organic compounds (VOCs) are a diverse group of chemicals that easily evaporate into the air at room temperature. They are emitted from various sources, including household products, building materials, paints, and vehicle emissions. VOCs can have harmful effects on human health and the environment.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Some VOCs, like benzene and formaldehyde, are known to cause respiratory irritation, headaches, and in severe cases, even cancer. Additionally, VOCs contribute to the formation of ground-level ozone and smog, which can exacerbate respiratory problems and damage vegetation. Monitoring VOC levels is crucial for maintaining indoor air quality, as prolonged exposure to high concentrations of VOCs indoors can lead to ${"sick building syndrome"} and other health issues.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "It's also important for outdoor air quality management, as VOCs contribute to air pollution and its associated health and environmental impacts. By understanding VOC levels, individuals and policymakers can take steps to minimize exposure and reduce emissions, ultimately promoting healthier environments for both humans and ecosystems.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
