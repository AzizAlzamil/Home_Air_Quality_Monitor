import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readair/BLE/ble_setup.dart';

class DisplayPage extends StatefulWidget {
  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  List<String> selectedOptions = []; // List to track selected options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Customize HomeAir Display"),
      ),
      body: ListView(
        children: [
          CheckboxListTile(
            title: Text('EPD Dot Enable'),
            value: selectedOptions.contains("EPDDE=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDDE=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Dot Location'),
            value: selectedOptions.contains("EPDDL=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDDL=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Clock Location'),
            value: selectedOptions.contains("EPDCL=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDCL=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Clock Enable (EPDCE)'),
            value: selectedOptions.contains("EPDCE=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDCE=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Clock Enable (EDPLF)'),
            value: selectedOptions.contains("EPDLF=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDLF=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Clock Enable (EDPRF)'),
            value: selectedOptions.contains("EPDRF=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDRF=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('EPD Refresh Period'),
            value: selectedOptions.contains("EPDRP=1"),
            onChanged: (bool? value) {
              handleCheckboxChanged("EPDRP=1", value);
            },
          ),
          CheckboxListTile(
            title: Text('Test'),
            value: selectedOptions.contains("TEST!"),
            onChanged: (bool? value) {
              handleCheckboxChanged("TEST!", value);
            },
          ),
          ElevatedButton(
            onPressed: submitAllCommands,
            child: Text('Submit All Commands'),
          ),
        ],
      ),
    );
  }

  void handleCheckboxChanged(String command, bool? value) {
    setState(() {
      if (value == true) {
        selectedOptions.add(command);
      } else {
        selectedOptions.remove(command);
      }
    });
  }

  void submitAllCommands() {
    if (bluetoothController.connectedDevice != null && selectedOptions.isNotEmpty) {
      selectedOptions.forEach((command) {
        bluetoothController.sendData(bluetoothController.connectedDevice!, command);
      });
    } else {
      print('No device connected or no commands selected');
    }
  }
}
