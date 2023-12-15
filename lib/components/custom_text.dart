import 'package:flutter/material.dart';

class customText extends StatelessWidget {
  customText({
    super.key,
    required this.text,
    required this.size,
  });
  String text;
  double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
      ),
    );
  }
}
