import 'package:flutter/material.dart';

class MyColors {
  static const Color mainTheme = Color.fromRGBO(71, 61, 192, 1);
  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color grey = Color.fromRGBO(205, 201, 201, 1.0);
  static const Color greyText = Color.fromRGBO(154, 154, 154, 1);
  static const Color scaffold = Colors.white24;
  static const Color red = Colors.red;
  static const Color green = Colors.green;
  static const Color greyBackground = Color.fromRGBO(248, 234, 250, 1);
  static const Color greyIcon = Color.fromRGBO(192, 188, 188, 1);
  static const Color lightmainTheme = Color.fromRGBO(168, 156, 252, 1);
  static const Color drakgreyText = Color.fromRGBO(32, 32, 32, 1.0);
  static const Color lightgrey = Color.fromRGBO(32, 32, 32, 1);
  static const Color lightBluegrey = Color.fromRGBO(221, 220, 220, 1);
  static const Color gradient1 = Color.fromRGBO(24, 206, 238, 1.0);
  static const Color gradient2 = Color.fromRGBO(47, 135, 215, 1.0);
  static const Color gradient3 = Color.fromRGBO(71, 61, 192, 1.0);
  static const Color black1D2226 = Color.fromRGBO(29, 34, 38, 1.0);
  static const Color black5F5F5F = Color.fromRGBO(95, 95, 95, 1.0);
  static const Color text2E2E2E = Color.fromRGBO(46, 46, 46, 1.0);
  static const Color containerEBEBEB = Color.fromRGBO(235, 235, 235, 1.0);
  static const Color containerF6F6F6 = Color.fromRGBO(246, 246, 246, 1.0);
  static const Color text878787 = Color.fromRGBO(135, 135, 135, 1.0);
  static const Color heading354038 = Color.fromRGBO(53, 64, 56, 1.0);
  static const Color lightBlue = Color.fromRGBO(230, 241, 250, 1.0);

  static const MaterialColor primaryCustom = MaterialColor(0xFF2F87D7, {
    50: Color.fromRGBO(10, 205, 237, 1.0),
    100: Color.fromRGBO(12, 186, 231, 1.0),
    200: Color.fromRGBO(14, 166, 225, 1.0),
    300: Color.fromRGBO(16, 150, 220, 1.0),
    400: Color.fromRGBO(18, 130, 214, 1.0),
    500: Color.fromRGBO(24, 113, 208, 1.0),
    600: Color.fromRGBO(27, 103, 205, 1.0),
    700: Color.fromRGBO(30, 87, 200, 1.0),
    800: Color.fromRGBO(38, 76, 197, 1.0),
    900: Color.fromRGBO(50, 61, 192, 1.0),
  });
}

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}
