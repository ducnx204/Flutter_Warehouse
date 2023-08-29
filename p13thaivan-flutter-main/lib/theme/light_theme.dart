import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xff61A63C),
  brightness: Brightness.light,
  accentColor: Colors.white,
  hintColor: const Color(0xFF9E9E9E),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
