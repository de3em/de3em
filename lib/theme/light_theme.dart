import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'TitilliumWeb',
  // primaryColor: Colors.black,
  brightness: Brightness.light,
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
  colorSchemeSeed: Colors.blueAccent,

  // highlightColor: Colors.white,
  // hintColor: const Color(0xFF9E9E9E),
  // splashColor: Colors.transparent,
  // colorScheme:  ColorScheme.light(
  //   primary: Colors.black,
  //   onPrimary: Colors.white,
  //   secondary: Colors.orangeAccent,
  //   tertiary: Colors.orangeAccent,
  // ),

  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
