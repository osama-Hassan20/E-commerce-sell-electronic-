import 'package:flutter/material.dart';


Widget defaultTextButton({
  required VoidCallback? function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Color(0xff4c505b),
          fontSize: 18,
        ),
      ),
    );
