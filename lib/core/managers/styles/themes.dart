import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch:defaultColor,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  // floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //   backgroundColor:Colors.black,
  // ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.black,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  scaffoldBackgroundColor:Colors.white,
);
