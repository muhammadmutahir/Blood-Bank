import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/login.dart';
import 'package:blood_bank/widgets/appbar_container.dart';
import 'package:flutter/material.dart';

class DonateBloodSorry extends StatefulWidget {
  static const String id = "DonateBloodSorry";
  const DonateBloodSorry({Key? key}) : super(key: key);

  @override
  State<DonateBloodSorry> createState() => _DonateBloodSorryState();
}

class _DonateBloodSorryState extends State<DonateBloodSorry> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarContainer(text: 'Sorry!', fontSize: 24),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Container(
                  height: 520,
                  width: 360,
                  child: Column(
                    
                    children: [
                       SizedBox(
                        height: 10,
                      ),
                      Image(
                          height: 160,
                          width: 160,
                          image: AssetImage('assets/images/nothing.png')),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'You are not eligible to donate blood \n at this time. Your health is important, \n and we encourage you to explore \n other ways to support our cause.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      button('Back', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()));
                      }),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      const BoxShadow(
                        color: Color.fromARGB(255, 139, 128, 128),
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
          Icon(Icons.arrow_back, color: Colors.white),
          SizedBox(width: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}
