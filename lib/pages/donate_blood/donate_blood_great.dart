import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/donor_register.dart';
import 'package:blood_bank/widgets/appbar_container.dart';
import 'package:flutter/material.dart';

class DonateBloodGreat extends StatefulWidget {
  static const String id = "DonateBloodGreat";
  const DonateBloodGreat({super.key});

  @override
  State<DonateBloodGreat> createState() => _DonateBloodGreatState();
}

class _DonateBloodGreatState extends State<DonateBloodGreat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarContainer(text: 'Great!', fontSize: 24),
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
                      Image(
                          height: 160,
                          width: 160,
                          image: AssetImage('assets/images/thumbs_up.png')),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'You have passed our eligibility \n check and it looks like you can give \n blood.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      button('Donate Blood', () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DonorRegister()));
                      }),
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
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    ),
  );
}
