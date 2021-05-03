import 'package:flutter/material.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function onClick;

  CustomButton({
    @required this.text,
    @required this.textColor,
    @required this.backgroundColor,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Text(text),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.all(FORM_PADDING * 1.2),
        ),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width / 1.2,
            0,
          ),
        ),
        foregroundColor:
        MaterialStateProperty.all(textColor),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontWeight: FontWeight.bold),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
