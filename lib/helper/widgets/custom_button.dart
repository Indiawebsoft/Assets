import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final Function() onPressed;
  final double fontSize;
  final double padding;
  final double height;
  final double width;

  CustomButton({ required this.label,
     required this.color,
     required this.textColor,
     required this.borderColor,
     required this.onPressed,
     required this.fontSize,
     required this.padding,
     required this.height,
     required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Padding(
            padding:  EdgeInsets.all(padding),
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: fontSize),
            ),
          ),
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(12.0),
              shadowColor: MaterialStateProperty.all(Colors.white30),
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: borderColor))))),
    );
  }
}
