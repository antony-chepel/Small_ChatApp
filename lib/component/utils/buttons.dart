import 'package:flutter/material.dart';


class Buttons extends StatelessWidget {
  final Color color;
  final String title;
  final void Function() onPressed;

  Buttons({this.color, this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 7.0,
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200,
          height: 45,
          child: Text(title, style: TextStyle(color: Colors.white) ,),
        ),
      ),
    );
  }
}
