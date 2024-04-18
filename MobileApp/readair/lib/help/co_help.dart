import 'package:flutter/material.dart';

class COHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CO Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CO: Carbon Monoxide",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Carbon monoxide (CO) is a colorless, odorless gas produced by incomplete combustion of carbon-containing fuels such as wood, gasoline, and natural gas. It's a silent but deadly threat, as exposure to high levels of CO can lead to carbon monoxide poisoning, which can be fatal. ",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Symptoms of CO poisoning include headache, dizziness, nausea, and confusion, and in severe cases, it can result in unconsciousness and death. Therefore, it's crucial to monitor CO levels, especially in enclosed spaces where combustion occurs, such as homes, workplaces, and vehicles.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Installing carbon monoxide detectors and regularly checking their functionality can save lives by providing early warning of dangerous CO concentrations, allowing prompt action to prevent exposure and ensure safety.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
