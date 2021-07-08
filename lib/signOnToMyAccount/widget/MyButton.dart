import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final enabled;
  final onPressed;

  MyButton({this.enabled, this.onPressed});

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  Color color;
  var onPressed;

  @override
  Widget build(BuildContext context) {
    if (widget.enabled) {
      color = Color(0xFF6C63FF);
      onPressed = widget.onPressed;
    } else {
      color = Colors.grey;
      onPressed = null;
    }
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Center(
          child: Text(
            "SEARCH",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
