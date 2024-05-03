import 'package:blood_bank/components/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppBarContainer extends StatelessWidget {
  String text;
  double fontSize;
  AppBarContainer({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 245,
            width: double.infinity,
            decoration: BoxDecoration(
              color: appBannarColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 5,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
