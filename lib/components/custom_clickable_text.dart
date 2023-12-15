import 'package:flutter/material.dart';

class CustomClickableText extends StatelessWidget {
  CustomClickableText({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.size,
  });
  String text;
  double size;
  Color color;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: size,
          color: color,
        ),
      ),
    );
  }
}

