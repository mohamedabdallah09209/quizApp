import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';
import '../../configs/themes/app_light_theme.dart';

class AppIntroductionScreen extends StatelessWidget {
  AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = "/introduction";

  final List locale = [
    {'name': 'ENGLISH', 'locale': const Locale('en', 'US')},
    {'name': 'عربي', 'locale': const Locale('ar', 'EG')},
  ];
  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('chooselange'.tr),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Theme.of(context).primaryColor,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: mainGradient()),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
          "assets/images/app_splash_logo.png",
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        ),
              SizedBox(
                height: Get.width * 0.1,
              ),
              Text(
                'intro'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.maxFinite,
                height: 45,
                color:
                    Get.isDarkMode ? Theme.of(context).primaryColor : Colors.blue[700],
                onPressed: () {
                  buildLanguageDialog(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language_outlined,color: Get.isDarkMode
                        ? cardColor
                        : Theme.of(context).scaffoldBackgroundColor),
                    SizedBox(width: 5,),
                    Text(
                      'changelange'.tr,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? cardColor
                              : Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.maxFinite,
                height: 45,
                color:
                    Get.isDarkMode ? Theme.of(context).primaryColor : Colors.yellow[700],
                onPressed: () => Get.offAllNamed("/home"),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'start'.tr,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? cardColor
                              : Theme.of(context).scaffoldBackgroundColor),
                    ),
                    const SizedBox(width: 5,),
                    Icon(Icons.arrow_forward, size: Get.width * 0.06,color: Get.isDarkMode
                        ? cardColor
                        : Theme.of(context).scaffoldBackgroundColor),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
