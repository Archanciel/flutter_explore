import 'package:flutter/material.dart';

class CheetahButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color textColor;

  const CheetahButton({
    required this.text,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          elevation: 8,
          backgroundColor: color,
          foregroundColor: Colors.deepOrange,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
