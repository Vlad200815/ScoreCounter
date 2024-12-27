import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final primaryColor = Colors.white;
final themeData = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  textTheme: textTheme,
);

final darkTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  textTheme: textTheme,
  dividerTheme: DividerThemeData(
    color: Colors.grey,
  ),
);

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  textTheme: textTheme,
  dividerTheme: DividerThemeData(
    color: Colors.white,
  ),
);

final textTheme = GoogleFonts.montserratTextTheme().copyWith(
  titleLarge: GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 50,
    fontWeight: FontWeight.w600,
  ),
  headlineLarge: GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 80,
    fontWeight: FontWeight.w900,
  ),
);
