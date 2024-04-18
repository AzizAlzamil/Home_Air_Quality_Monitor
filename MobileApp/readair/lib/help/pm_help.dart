import 'package:flutter/material.dart';

class PMHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Particulate Matter Help"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Particulate Matter",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Particles, known as particulate matter (PM), are minuscule solid or liquid particles suspended in the atmosphere, ranging from coarse dust to fine smoke and aerosols. They originate from both natural sources like wildfires and human activities such as vehicle emissions and industrial processes. ",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Monitoring particle levels in the air is critical for several reasons. Firstly, they pose significant health risks when inhaled, particularly fine particles (PM2.5), which can penetrate deep into the lungs and bloodstream, leading to respiratory issues, cardiovascular diseases, and premature death. Secondly, particulate matter contributes to air pollution, reducing visibility and forming harmful compounds like ground-level ozone and smog. By assessing air quality and implementing pollution reduction measures, monitoring helps protect public health and the environment.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Moreover, certain particles like black carbon can absorb sunlight and contribute to global warming, while others influence cloud formation and precipitation patterns, affecting climate systems. Finally, regulatory compliance relies on monitoring particle levels to ensure adherence to standards set by governments and regulatory agencies, further supporting efforts to improve air quality. Overall, understanding and tracking particle levels in the air are vital for safeguarding human health, assessing air quality, mitigating climate change, and ensuring regulatory compliance.",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
