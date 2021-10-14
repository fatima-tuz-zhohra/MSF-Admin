import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.light(
  primary: const Color(0xff009688),
  primaryVariant: const Color(0xff0444f4),
  secondary: const Color(0xffff9800),
  secondaryVariant: const Color(0xff32adf8),
  surface: Colors.grey.shade200,
  background: Colors.grey.shade200,
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

final darkColorScheme = ColorScheme.dark(
  primary: const Color(0xffb2dfdb),
  primaryVariant: const Color(0xff0444f4),
  secondary: const Color(0xffff9800),
  secondaryVariant: const Color(0xff32adf8),
  surface: const Color(0xff212121),
  background: const Color(0xff212121),
  error: const Color(0xffcf6679),
  onPrimary: Colors.black,
  onSecondary: Colors.black,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.black,
);

final lightTheme = ThemeData.from(colorScheme: lightColorScheme);
final darkTheme = ThemeData.from(colorScheme: darkColorScheme);
