import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizquiz/controllers/auth_controller.dart';
import 'package:quizquiz/firebase_ref/references.dart';
import 'package:quizquiz/models/question_paper_model.dart';
import 'package:quizquiz/services/firebase_storage_service.dart';

import '../../screens/question/questions_screen.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();
      allPapers.assignAll(paperList);
      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paperModel, bool tryAgain = false}) {
    AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
         Get.toNamed(QuestionsScreen.routeName,arguments: paperModel,preventDuplicates: false);

      } else {
        Get.toNamed(QuestionsScreen.routeName,arguments: paperModel);
      }
    } else {
      authController.showLoginAlertDialog();
    }
  }
}
