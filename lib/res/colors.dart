import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color eRevenueRed = Color(0xFFFB7B00);
const Color lightGrey = Color(0xFFFAFAFA);

const Color eRevenueDarkRed = Color(0xFFFB7B00);
const Color eRevenueBlue = Color.fromARGB(255, 0, 48, 73);
// const Color eRevenueGreen = Color.fromARGB(255, 0, 233, 93);
const Color eRevenueGrey = Color.fromRGBO(0, 0, 0, 0.7);
const Color eRevenueWhite = Color.fromARGB(255, 255, 255, 255);

/// Text colors for dark theme
const TextTheme lightTextTheme = TextTheme(
    bodyText2: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.black));

/// Colors theme for material defaults of dark theme
dynamic lightAppThemeAndroid = ThemeData(
  primarySwatch: erevenuePrimarycolor,
  inputDecorationTheme: InputDecorationTheme(),
  appBarTheme: AppBarTheme(color: eRevenueDarkRed),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

/// Colors theme for material defaults of dark theme
dynamic lightAppThemeIos = CupertinoThemeData(
  primaryColor: eRevenueRed,
  scaffoldBackgroundColor: eRevenueWhite,
  primaryContrastingColor: eRevenueDarkRed,
);

/// Light mode colors
var homeLightColors = GlobalAppColors(
  name: "lightTheme",
  mainBackgroundColor: eRevenueWhite,
  appThemeAndroid: lightAppThemeAndroid,
  appThemeIos: lightAppThemeIos,
  mainButtonsColor: eRevenueDarkRed,
  mainIconsColor: eRevenueGrey,
  mainTextColor: eRevenueBlue,
  secondaryTextColor: Colors.white,
  secondaryIconsColor: eRevenueBlue,
  appBarBackgroundColor: eRevenueRed,
  textTheme: lightTextTheme,
);

// making of a swatch color for the material colors
const MaterialColor erevenuePrimarycolor = const MaterialColor(
  0xFFFB7B00,
  const <int, Color>{
    50: const Color(0xFFFB7B00),
    100: const Color(0xFFFB7B00),
    200: const Color(0xFFFB7B00),
    300: const Color(0xFFFB7B00),
    400: const Color(0xFFFB7B00),
    500: const Color(0xFFFB7B00),
    600: const Color(0xFFFB7B00),
    700: const Color(0xFFFB7B00),
    800: const Color(0xFFFB7B00),
    900: const Color(0xFFFB7B00),
  },
);

/// Container for all things color in mgari
class GlobalAppColors {
  String name;
  Color mainBackgroundColor;
  Color mainButtonsColor;
  Color mainIconsColor;
  Color mainTextColor;
  Color secondaryTextColor;
  Color secondaryIconsColor;
  TextTheme textTheme;
  dynamic appThemeAndroid;
  dynamic appThemeIos;
  Color appBarBackgroundColor;

  GlobalAppColors({
    this.name,
    this.mainBackgroundColor,
    this.mainButtonsColor,
    this.mainIconsColor,
    this.secondaryIconsColor,
    this.mainTextColor,
    this.secondaryTextColor,
    this.textTheme,
    this.appBarBackgroundColor,
    this.appThemeAndroid,
    this.appThemeIos,
  });
}
