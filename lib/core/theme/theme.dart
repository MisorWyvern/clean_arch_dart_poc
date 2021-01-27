import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double _u = 8.0;

final Color _lightPurple = Color(0xFFD1C4E9);
final Color _purple = Color(0xFF673AB7);
final Color _darkpurple = Color(0xFF512DA8);
final Color _cyan = Color(0xFF00BCD4);
final Color _almostBlack = Color(0xFF212121);
final Color _darkGrey = Color(0xFF757575);
final Color _lightGrey = Color(0xFFBDBDBD);



ThemeData theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColorDark: _darkpurple,
  primaryColorLight: _lightPurple,
  primaryColor: _purple,
  accentColor: _cyan,
  dividerColor: _lightGrey,
  textTheme: TextTheme(
    bodyText1: GoogleFonts.lato(
      color: _almostBlack,
    ),
    bodyText2: GoogleFonts.lato(
      color: _darkGrey,
    ),
    headline1: GoogleFonts.pressStart2p(color: Colors.white, fontSize: _u*5),
    headline2: GoogleFonts.pressStart2p(color: Colors.white, fontSize: _u*4),
    headline3: GoogleFonts.lato(color: Colors.white, fontSize: _u*3.5),
    headline4: GoogleFonts.lato(color: Colors.white, fontSize: _u*3),
    headline5: GoogleFonts.lato(color: Colors.white, fontSize: _u*2.5),
    headline6: GoogleFonts.lato(color: _almostBlack, fontSize: _u*2, fontWeight: FontWeight.bold),
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
