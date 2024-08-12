import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'TitilliumWeb',
  colorSchemeSeed: Colors.orange,
  // primaryColor: Colors.black,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
  // highlightColor: const Color(0xFF252525),
  // hintColor: const Color(0xFFc7c7c7),
  // cardColor: const Color(0xFF242424),
  // scaffoldBackgroundColor: const Color(0xFF000000),
  // splashColor: Colors.transparent,
  // colorScheme: const ColorScheme.dark(
  //   primary: Colors.black,
  //   onPrimary: Colors.white,
  //   secondary: Colors.orange,
  //   tertiary: Colors.orange,
  //   tertiaryContainer: Color(0xFF6C7A8E),
  //   background: Color(0xFF2D2D2D),
  //   onTertiaryContainer: Color(0xFF0F5835),
  //   primaryContainer: Color(0xFF208458),
  //   onSecondaryContainer: Color(0x912A2A2A),
  //   outline: Colors.orange,
  //   onTertiary: Color(0xFF545252),
  //   secondaryContainer: Color(0xFFF2F2F2),
  // ),
  textTheme: const TextTheme(bodyLarge: TextStyle(color: Color(0xFFE9EEF4))),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
