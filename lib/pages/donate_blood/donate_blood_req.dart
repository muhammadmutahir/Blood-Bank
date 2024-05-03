import 'package:blood_bank/components/constants.dart';
import 'package:blood_bank/pages/donate_blood/donate_req_one.dart';
import 'package:blood_bank/widgets/appbar_container.dart';
import 'package:flutter/material.dart';

class DonateBloodReq extends StatefulWidget {
  static const String id = "DonateBloodReq";
  const DonateBloodReq({Key? key}) : super(key: key);

  @override
  State<DonateBloodReq> createState() => _DonateBloodReqState();
}

class _DonateBloodReqState extends State<DonateBloodReq> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarContainer(text: 'Donate Blood', fontSize: 20),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: SingleChildScrollView(
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
                        const Padding(
                          padding: EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            'Check if you can give Blood',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff502727),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/doctor.png',
                              height: 290,
                              width: 110,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\u2714 These questions will help you \n      find if you can give blood',
                                  style: TextStyle(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                    '\u2714 It could save you time or even \n     a wasted journey'),
                                SizedBox(height: 10),
                                Text(
                                    '\u2714 Run through them before you \n     go along to your donation'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        button('Donate Blood', () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DonateReqOne()));
                        })
                      ],
                    ),
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
              fontSize: 16,
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
