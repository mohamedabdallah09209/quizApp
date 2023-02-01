import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_dark_theme.dart';
import 'package:quizquiz/configs/themes/app_light_theme.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';

const Color onSurfaceTextColor = Colors.white;

const Color correctAnswerColor = Color(0xFF3ac3cb);
const Color wrongAnswerColor = Color(0xFF851807);
const Color notAnsweredColor = Color(0xFF2a3c65);

const mainGradientLight = LinearGradient(
    colors: [primaryLightColorLight, primaryColorLight],
    begin: Alignment.topLeft,
    end: Alignment.topRight);

const mainGradientDark = LinearGradient(
    colors: [primaryDarkColorDark, primaryColorDark],
    begin: Alignment.topLeft,
    end: Alignment.topRight);

LinearGradient mainGradient() =>
    UiParameters.isDarkMood() ? mainGradientDark : mainGradientLight;

Color customScaffoldColor(BuildContext context) => UiParameters.isDarkMood()
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 240, 237, 255);

Color answerSelectedColor() => UiParameters.isDarkMood()
    ? Theme.of(Get.context!).cardColor.withOpacity(0.5)
    : Theme.of(Get.context!).primaryColor;

Color answerBorderColor() => UiParameters.isDarkMood()
    ? const Color.fromARGB(255, 20, 46, 158)
    : const Color.fromARGB(255, 221, 221, 221);
