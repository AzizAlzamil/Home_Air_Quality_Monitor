import 'package:flutter/material.dart';

class NOxHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOx Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nitrogen Oxides",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Nitrogen oxides (NOx) are a group of highly reactive gases composed of nitrogen and oxygen molecules. They are primarily produced during combustion processes in vehicles, power plants, and industrial facilities. NOx plays a significant role in air pollution and environmental degradation. ",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "When released into the atmosphere, NOx can react with other pollutants to form ground-level ozone and fine particulate matter, contributing to smog formation and respiratory issues. Additionally, NOx can deposit into ecosystems, leading to acid rain and nutrient imbalances in soil and water bodies. Monitoring NOx levels is crucial for assessing air quality and implementing measures to reduce pollution and protect public health.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "By understanding NOx concentrations, policymakers and environmental agencies can develop strategies to control emissions, improve air quality, and mitigate the harmful effects of NOx on both human health and the environment.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
