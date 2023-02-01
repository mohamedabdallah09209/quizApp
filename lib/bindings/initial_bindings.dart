import 'package:get/get.dart';
import 'package:quizquiz/controllers/auth_controller.dart';
import 'package:quizquiz/controllers/theme_controller.dart';
import 'package:quizquiz/services/firebase_storage_service.dart';

import '../controllers/question_paper/question_paper_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FirebaseStorageService());
    Get.put(QuestionPaperController());
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
  }
}
