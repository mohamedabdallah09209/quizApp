import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:quizquiz/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login/login_screen.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toogleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

 

  void signIn() {
    Get.toNamed(LoginScreen.routeName);
  }

  void website() {
    _launch("https://google.com");
  }

  void facebook() {
    _launch("https://facebook.com");
  }

   void phone() {
    _launch("0996992624");
  }
  

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ebnabdallahprogrammer@gmail.com',
    );
    _launch(emailLaunchUri.toString());
  }

  Future<void> _launch(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }
}
