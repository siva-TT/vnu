import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xFFB78524);
const COLOR_SECONDARY = Color(0xFF000000);
const COLOR_TERITARY = Color(0xFF414141);
const COLOR_WHITE = Color(0xFFFFFFFF);


/* class Constant{
int card_height = 119;
int card_width = 10;
} */

ThemeData lightTheme = ThemeData(


  fontFamily: "HelveticaNeue",
  dividerColor: COLOR_PRIMARY,
  primaryColor: COLOR_PRIMARY,
  secondaryHeaderColor: COLOR_SECONDARY,
  backgroundColor: COLOR_WHITE,
  appBarTheme: const AppBarTheme(
    color: COLOR_SECONDARY,
  ),
  cardTheme: const CardTheme(
    color: COLOR_PRIMARY,
  ),
);
