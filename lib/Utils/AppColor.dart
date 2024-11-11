import 'dart:ui';

import 'package:flutter/material.dart';

class Appcolor {
  static const MaterialColor primarySwatch = MaterialColor(
    0xFFFACD3E, // Base color value (hex of your primaryColor)
    <int, Color>{
      50: Color(0xFFF9E4A7), // Lighter shade of primary color
      100: Color(0xFFF7D06A),
      200: Color(0xFFF6C14D),
      300: Color(0xFFF5B330),
      400: Color(0xFFF4A31A),
      500: Color(0xFFFACD3E), // Your primary color
      600: Color(0xFFF39E1A),
      700: Color(0xFFF17E14),
      800: Color(0xFFF05E0F),
      900: Color(0xFFEF3E09), // Darker shade of primary color
    },
  );

  static const Color primaryColor = Color.fromRGBO(250, 205, 62, 1);
}
