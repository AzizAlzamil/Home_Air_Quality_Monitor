import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readair/BLE/ble_setup.dart';

class DisplayPage extends StatefulWidget {
  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  TextEditingController deviceNameController = TextEditingController();
  List<String> selectedOptions = []; // List to track selected options

  
Map<String, Map<String, bool>> options = {
  "EPD Dot Enable": {"EPDDE": false},
  "EPD Dot Location": {"EPDDL": false},
  "EPD Clock Location": {"EPDCL": false},
  "EPD Clock Enable": {"EPDCE": false},
  "EPD Dot Location Front": {"EPDLF": false},
  "EPD Dot Location Rear": {"EPDRF": false},
  "EPD Refresh Period": {"EPDRP": false},
};

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
        ...options.entries.map((entry) {
          String key = entry.value.keys.first; // The command key
          return CheckboxListTile(
            title: Text(entry.key), // Use the descriptive title
            value: entry.value[key],
            onChanged: (bool? value) {
              setState(() {
                options[entry.key]?[key] = value ?? false;
              });
            },
          );
        }).toList(),
        ElevatedButton(
          onPressed: submitAllCommands,
          child: Text('Submit All Commands'),
        ),
        ListTile(
          title: Text("Change Device Name"),
          subtitle: Text("Tap to set a new name for your HomeAir device."),
          trailing: Icon(Icons.edit),
          onTap: showNameChangeDialog,
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
  // Check if the device is connected
  if (bluetoothController.connectedDevice == null) {
    print('No device connected');
    // Optionally, show a user-friendly message or alert
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No Bluetooth device is connected.")),
    );
    return;
  }

  // Generate the commands string
  String commands = options.entries.map((entry) {
    String command = entry.value.keys.first; // Retrieve the command key
    bool isActive = entry.value[command] ?? false; // Default to false if null
    return '$command=${isActive ? '1' : '0'}'; // Format as 'COMMAND=1' or 'COMMAND=0'
  }).join(', ');

  // Check if there are any commands to send
  if (commands.isEmpty) {
    print('No commands selected');
    // Optionally, show a user-friendly message or alert
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No commands have been selected.")),
    );
    return;
  }

  // Send the command string to the connected device
  bluetoothController.sendData(bluetoothController.connectedDevice!, commands);
  print('Submitted: $commands'); // Debugging output

  // Optionally, show a confirmation message or alert
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Commands submitted successfully.")),
  );
}


  void showNameChangeDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Change Device Name"),
        content: TextField(
          controller: deviceNameController,
          decoration: InputDecoration(
            hintText: "Enter new name",
            helperText: "Max 10 letters",
          ),
          maxLength: 10,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (deviceNameController.text.isNotEmpty) {
                final newName = 'HomeAir-' + deviceNameController.text;
                // Send the command to the device
                bluetoothController.sendData(
                    bluetoothController.connectedDevice!, "NAME!=$newName");
                Navigator.pop(context);
              }
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

}
