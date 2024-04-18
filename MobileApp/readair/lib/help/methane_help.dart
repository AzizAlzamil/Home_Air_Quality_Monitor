import 'package:flutter/material.dart';

class MethaneHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Methane Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Methane (Natural Gas)",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Methane, a potent greenhouse gas, plays a crucial role in Earth's climate system. It is emitted from various natural and human-made sources, including livestock, landfills, and fossil fuel production. While methane has a shorter atmospheric lifespan compared to carbon dioxide (CO2), it is around 25 times more effective at trapping heat over a 100-year period.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Therefore, even though CO2 is more abundant in the atmosphere, monitoring methane levels is essential for understanding and mitigating climate change. Additionally, methane emissions often accompany other pollutants, contributing to air quality degradation and health concerns.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Since CO2 and methane are both major contributors to global warming, knowing their levels helps policymakers, scientists, and industries develop effective strategies to reduce emissions and mitigate the impacts of climate change.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
