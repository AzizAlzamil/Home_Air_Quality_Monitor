import 'package:flutter/material.dart';

class CO2HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CO2 Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CO2: Carbon Dioxide",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Carbon dioxide (CO2) is a crucial component of Earth's atmosphere, playing a significant role in regulating climate and sustaining life. While naturally occurring, human activities, such as burning fossil fuels and deforestation, have led to a dramatic increase in CO2 levels over the past century, contributing to global warming and climate change.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Monitoring CO2 levels is essential for several reasons. Firstly, elevated CO2 concentrations can have adverse effects on human health, causing respiratory issues and exacerbating conditions like asthma. Secondly, CO2 is a greenhouse gas, trapping heat in the atmosphere and contributing to the warming of the planet.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Understanding and managing CO2 levels is thus critical for mitigating the impacts of climate change and transitioning to a more sustainable future. Additionally, monitoring CO2 levels aids in assessing air quality and implementing measures to reduce pollution, benefiting both human health and the environment.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
