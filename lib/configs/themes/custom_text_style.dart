import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';

TextStyle cardTitles(context) => TextStyle(
      color: UiParameters.isDarkMood()
          ? Theme.of(context).textTheme.bodyText1!.color
          : Theme.of(context).primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
const quistionTs = TextStyle(fontSize: 16, fontWeight: FontWeight.w800);
const detailText = TextStyle(fontSize: 12);
const headerText = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w700, color: onSurfaceTextColor);
const appBarTs = TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: onSurfaceTextColor);

TextStyle countDownTimerTs ()=> TextStyle(
  letterSpacing: 2,
  color: UiParameters.isDarkMood()?
  Theme.of(Get.context!).textTheme.bodyText1!.color
  :Theme.of(Get.context!).primaryColor
  );
