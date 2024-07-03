import 'package:blood_bank/components/constants.dart';
import 'package:flutter/material.dart';

class WhiteRoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const WhiteRoundButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 297,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.red,
                )
              : Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xffFF0E0E),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
