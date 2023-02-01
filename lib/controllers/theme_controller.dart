import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_dark_theme.dart';
import 'package:quizquiz/configs/themes/app_light_theme.dart';

import '../main.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  bool isDarkMode = false;
  @override
  void onInit() {
    initializeThemeData();
    super.onInit();
  }

  initializeThemeData() {
    _darkTheme = DarkTheme().buildDarkTheme();
    _lightTheme = LightTheme().buildLightTheme();
  }

  ThemeData get darkTheme => _darkTheme;
  ThemeData get lightTheme => _lightTheme;

  var appTheme=LightTheme().buildLightTheme();


  void toggleDarkMode() {
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      appTheme=DarkTheme().buildDarkTheme();
     // Get.changeTheme(Get.find<ThemeController>().darkTheme);
    } else {
      appTheme=LightTheme().buildLightTheme();

      //Get.changeTheme(Get.find<ThemeController>().lightTheme);

    }
    update();
  }
}
