import 'package:flutter/material.dart';

var theme = ThemeData(
  primarySwatch: Colors.deepPurple,
  primaryColorDark: Color(0xFF512DA8),
  primaryColorLight: Color(0xFFD1C4E9),
  primaryColor: Color(0xFF673AB7),
  accentColor: Color(0xFF00BCD4),
  dividerColor: Color(0xFFBDBDBD),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Color(0xFF212121),
    ),
    bodyText2: TextStyle(
      color: Color(0xFF757575),
    ),
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
