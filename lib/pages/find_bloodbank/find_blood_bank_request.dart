
import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/find_bloodbank/available_blood_bank.dart';
import 'package:blood_bank/widgets/select_blood_type_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FindBloodBankRequest extends StatefulWidget {
  static const String id = "FindBloodBankRequest";
  const FindBloodBankRequest({super.key});

  @override
  State<FindBloodBankRequest> createState() => _FindBloodBankRequestState();
}

class _FindBloodBankRequestState extends State<FindBloodBankRequest> {
  final List<String> bloodtypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  List<bool> bloodTypeSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  final List<String> gendertype = [
    'Male',
    'Female',
  ];
  List<bool> gendertypeselected = [
    false,
    false,
  ];

  final List<String> city = ['--Select City--', 'Lahore', 'Shorkot', 'Multan'];
  bool isCitySelected = false;

  String selectedCity = '';
  String selectedbloodType = '';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
        title: Text('Find Blood Bank',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor)),
        backgroundColor: appBannarColor,
        toolbarHeight: 84,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        centerTitle: true,
      ),
      backgroundColor: whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Patient Blood Type:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Row(
              children: [
                SelectBloodTypeButton(
                  bloodType: bloodtypes[0],
                  onPressed: () {
                    selectedbloodType = bloodtypes[0];
                    print('Selected blood type: ${bloodtypes[0]}');
                    changeColor(0);
                  },
                  isClicked: bloodTypeSelected[0],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[1],
                  onPressed: () {
                    selectedbloodType = bloodtypes[1];
                    print('Selected blood type: ${bloodtypes[1]}');
                    changeColor(1);
                  },
                  isClicked: bloodTypeSelected[1],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[2],
                  onPressed: () {
                    selectedbloodType = bloodtypes[2];
                    print('Selected blood type: ${bloodtypes[2]}');
                    changeColor(2);
                  },
                  isClicked: bloodTypeSelected[2],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[3],
                  onPressed: () {
                    selectedbloodType = bloodtypes[3];
                    print('Selected blood type: ${bloodtypes[3]}');
                    changeColor(3);
                  },
                  isClicked: bloodTypeSelected[3],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Row(
              children: [
                SelectBloodTypeButton(
                  bloodType: bloodtypes[4],
                  onPressed: () {
                    selectedbloodType = bloodtypes[4];
                    print('Selected blood type: ${bloodtypes[4]}');
                    changeColor(4);
                  },
                  isClicked: bloodTypeSelected[4],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[5],
                  onPressed: () {
                    selectedbloodType = bloodtypes[5];
                    print('Selected blood type: ${bloodtypes[5]}');
                    changeColor(5);
                  },
                  isClicked: bloodTypeSelected[5],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[6],
                  onPressed: () {
                    selectedbloodType = bloodtypes[6];
                    print('Selected blood type: ${bloodtypes[6]}');
                    changeColor(6);
                  },
                  isClicked: bloodTypeSelected[6],
                ),
                SelectBloodTypeButton(
                  bloodType: bloodtypes[7],
                  onPressed: () {
                    selectedbloodType = bloodtypes[7];
                    print('Selected blood type: ${bloodtypes[7]}');
                    changeColor(7);
                  },
                  isClicked: bloodTypeSelected[7],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Select City:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(left: 45),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              underline: Container(),
              value: city.first,
              onChanged: (String? value) => _dropDownButtonOnTap(value),
              items: city.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Text(value),
                  ),
                );
              }).toList(),
            ),
          ),
          Visibility(visible: isCitySelected, child: Text(selectedCity)),
          SizedBox(
            height: 60,
          ),
          Center(
              child: button('Find Blood Bank', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AvailableBloodBank(
                          bloodgroup: selectedbloodType,
                          selectcity: selectedCity,
                        )));
          }))
        ],
      ),
    );
  }

  void changeColor(int index) {
    for (int i = 0; i < bloodTypeSelected.length; i++) {
      if (i == index) {
        bloodTypeSelected[index] = true;
      } else {
        bloodTypeSelected[i] = false;
      }
    }
    setState(() {});
  }

  void _dropDownButtonOnTap(String? value) {
    setState(() {
      selectedCity = value!;
      isCitySelected = true;
    });
    print(selectedCity);
  }
}

Widget button(String text, VoidCallback onPressed) {
  return Container(
    height: 55,
    width: 297,
    decoration: BoxDecoration(
      color: darkRedButtonColor,
      borderRadius: BorderRadius.circular(25),
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 20),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    ),
  );
}
