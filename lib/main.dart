import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/bindings/initial_bindings.dart';
import 'package:quizquiz/controllers/theme_controller.dart';
import 'langueges/app_translations.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  InitialBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ThemeController());
    return GetBuilder<ThemeController>(
        builder: (controller)=>GetMaterialApp(
      title: 'apptitle'.tr,
      translations: AppTranslations(),
      locale: const Locale('ar', 'EG'),
      debugShowCheckedModeBanner: false,
      theme: controller.appTheme,
      getPages: AppRoutes.routes(),),
    );
  }
}
