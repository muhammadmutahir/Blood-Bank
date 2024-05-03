import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'City Dropdown',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedCity = "--Select City--"; // Initially selected city

  // List of cities in Pakistan
  List<String> _cities = [
    "Karachi",
    "Lahore",
    "Islamabad",
    "Rawalpindi",
    "Faisalabad",
    "Multan",
    // Add more cities as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Dropdown'),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: DropdownButton<String>(
            value: _selectedCity,
            onChanged: (String? newValue) {
              setState(() {
                _selectedCity = newValue!;
                // Perform backend operations here
                print("Selected city: $_selectedCity"); // For demonstration
              });
            },
            items: _cities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              );
            }).toList(),
            dropdownColor: Colors.blue, // Set dropdown background color
            icon: Icon(Icons.arrow_drop_down,
                color: Colors.white), // Set dropdown icon color
            underline: SizedBox(), // Remove default underline
          ),
        ),
      ),
    );
  }
}
