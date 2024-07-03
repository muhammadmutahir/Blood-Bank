import 'package:flutter/material.dart';

class SelectCityButton extends StatefulWidget {
  const SelectCityButton({super.key});

  @override
  _SelectCityButtonState createState() => _SelectCityButtonState();
}

class _SelectCityButtonState extends State<SelectCityButton> {
  String selectedCity = "-- Select City --";

  List<String> cities = [
    "Karachi",
    "Lahore",
    "Islamabad",
    "Rawalpindi",
    "Faisalabad",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.red, width: 1),
      ),
      child: TextButton(
        onPressed: () {
          _showCitySelectionDialog(context);
        },
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(Colors.black),
        ),
        child: Text(
          selectedCity,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _showCitySelectionDialog(BuildContext context) async {
    String? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select a City"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(cities[index]),
                  onTap: () {
                    Navigator.of(context).pop(cities[index]);
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedCity = result;
      });
      //widget.onCitySelected(result);
    }
  }
}
