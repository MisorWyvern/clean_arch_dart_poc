import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double u = 8.0;

var theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColorDark: Color(0xFF512DA8),
  primaryColorLight: Color(0xFFD1C4E9),
  primaryColor: Color(0xFF673AB7),
  accentColor: Color(0xFF00BCD4),
  dividerColor: Color(0xFFBDBDBD),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.lato(
      color: Color(0xFF212121),
    ),
    bodyText2: GoogleFonts.lato(
      color: Color(0xFF757575),
    ),
    headline1: GoogleFonts.pressStart2p(color: Colors.white, fontSize: u*5),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) => getColor(states)),
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return theme.primaryColorLight;
  }
  return Colors.white;
}
