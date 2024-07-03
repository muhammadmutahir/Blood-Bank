import 'package:flutter/material.dart';

class SelectBloodTypeButton extends StatelessWidget {
  final String bloodType;
  final VoidCallback onPressed;
  final bool isClicked;

  const SelectBloodTypeButton({
    super.key,
    required this.bloodType,
    required this.onPressed,
    required this.isClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        height: 40,
        width: 60,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: isClicked ? Colors.red : Colors.white,
        ),
        child: Text(
          bloodType,
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
