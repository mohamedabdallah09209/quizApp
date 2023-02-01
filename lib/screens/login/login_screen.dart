import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/controllers/auth_controller.dart';
import 'package:quizquiz/widgets/common/main_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/app_splash_logo.png",
              width: 200,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Text(
                "logintext".tr,
                style: const TextStyle(
                  color: onSurfaceTextColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            MainButton(
              onTap: () {
                controller.signInWithGoogle();
              },
              child: Stack(
                children: [
                  Center(
                    child: Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/icons/google.svg',
                        color: Get.isDarkMode
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "googlesignin".tr,
                      style: TextStyle(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
