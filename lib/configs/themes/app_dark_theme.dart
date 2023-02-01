import 'package:flutter/material.dart';
import 'package:quizquiz/configs/themes/sub_theme_data.dart';

const Color primaryDarkColorDark = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const Color mainTextColorDark = Colors.white;

class DarkTheme with SubThemeData {
  buildDarkTheme() {
    final ThemeData systemLightTheme = ThemeData.dark();
    return systemLightTheme.copyWith(
      iconTheme: getIconTheme(),
      textTheme: getTextThemes().apply(
          fontFamily: 'Cairo',

        bodyColor: mainTextColorDark,
        displayColor: mainTextColorDark,
      ),
    );
  }
}
