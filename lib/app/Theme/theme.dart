import 'package:flutter/material.dart';

class AppTheme {
  static get theme => ThemeData(
    primaryColor: const Color(0xff5358B6),
    backgroundColor: const Color(0xffF5F6FA),
    scaffoldBackgroundColor: const Color(0xffF5F6FA),
    cardColor: const Color(0xffFFFFFF),
    disabledColor: const Color(0xffECECEC),
    unselectedWidgetColor: const Color(0xffDDDDDD),
    textTheme: const TextTheme().apply(
      bodyColor: const Color(0xff333A42),
      displayColor: const Color(0xff333A42),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xff5358B6),
      secondary: Color(0xff53B681),
      surface: Color(0xffFFFFFF),
      background: Color(0xffF5F6FA),
      error: Color(0xffF15E64),
      onPrimary: Color(0xffFFFFFF),
      onSecondary: Color(0xffFFFFFF),
      onError: Color(0xffFFFFFF),
      onBackground: Color(0xff333A42),
      onSurface: Color(0xff333A42)
    )
  );
}

