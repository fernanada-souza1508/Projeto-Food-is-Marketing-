import "package:flutter/material.dart";

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: Color.fromARGB(255, 243, 241, 161),
        primary: Color.fromARGB(255, 209, 47, 47),
        secondary: Color.fromARGB(255, 209, 47, 47),
        inversePrimary: Color.fromARGB(255, 0, 0, 0)));


ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade800,
        primary: const Color.fromARGB(255, 94, 43, 43),
        secondary: Color.fromARGB(255, 77, 3, 3),
        inversePrimary: Colors.white));
