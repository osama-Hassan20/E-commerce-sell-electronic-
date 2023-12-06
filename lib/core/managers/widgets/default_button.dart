import 'package:flutter/material.dart';

Widget defaultButton({
  bool isUpperCase = true,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color(0xfff4ac47),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
