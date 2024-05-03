import 'package:flutter/material.dart';

class SelectGenderTypeButton extends StatelessWidget {
  final String genderType;
  final VoidCallback onPressed;
  final bool isClicked;

  const SelectGenderTypeButton({
    Key? key,
    required this.genderType,
    required this.onPressed,
    required this.isClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 40,
        width: 130,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: isClicked ? Colors.red : Colors.white,
        ),
        child: Text(
          genderType,
          style: TextStyle(
            color: isClicked ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
