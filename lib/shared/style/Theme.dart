import 'package:flutter/material.dart';

ThemeData lightThem () =>ThemeData(
  textTheme: const TextTheme(
    subtitle1:TextStyle(
      fontWeight:FontWeight.bold,
      fontSize: 15,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 10
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleSpacing: 5,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 17
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    )
  )
);