import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/donate_blood/donate_blood_sorry.dart';
import 'package:blood_bank/pages/donate_blood/donate_req_four.dart';
import 'package:blood_bank/widgets/appbar_container.dart';
import 'package:flutter/material.dart';

class DonateReqThree extends StatefulWidget {
  static const String id = "DonateReqThree";
  const DonateReqThree({super.key});

  @override
  State<DonateReqThree> createState() => _DonateReqThreeState();
}

class _DonateReqThreeState extends State<DonateReqThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarContainer(text: 'Check if you can give blood', fontSize: 20),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: Container(
                  height: 520,
                  width: 360,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: const [
                      BoxShadow(
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image(
                          height: 160,
                          width: 160,
                          image: AssetImage('assets/images/virus.png')),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Have you had any infection in the \n last 2 weeks or have you taken \n antibiotics within the last 7 days?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button('Yes', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonateBloodSorry()));
                          }),
                          SizedBox(
                            width: 20,
                          ),
                          button('No', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DonateReqFour()));
                          })
                        ],
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
    height: 44,
    width: 144,
    decoration: BoxDecoration(
      color: darkRedButtonColor,
      borderRadius: BorderRadius.circular(10),
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}
