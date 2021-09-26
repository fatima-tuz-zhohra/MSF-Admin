import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme.light(
  primary: const Color(0xff009688),
  primaryVariant: const Color(0xff0444f4),
  secondary: const Color(0xffff9800),
  secondaryVariant: const Color(0xff32adf8),
  surface: Colors.white,
  background: Colors.white,
  error: const Color(0xffb00020),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

final lightTheme = ThemeData.from(colorScheme: lightColorScheme);
