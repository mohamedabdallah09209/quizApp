import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quizquiz/controllers/question_paper/question_controller.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

extension QustionsControllerExtenstion on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnswerQuestions {
    return '$correctQuestionCount ${'outof'.tr} ${allQuestions.length} ${'arecorrect'.tr}';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResult() async {
    var batch = fireStore.batch();

    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;
    batch.set(
        userRef
            .doc(_user.email)
            .collection('myrecent_quizes')
            .doc(questionPaperModel.id),
        {
          "points": points,
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": questionPaperModel.id,
          "time": questionPaperModel.timeSeconds - remainSeconds
        });

        batch.set(
        leaderBoardRF
            .doc(questionPaperModel.id)
            .collection('scores')
            .doc(_user.email),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": questionPaperModel.id,
          "time": questionPaperModel.timeSeconds - remainSeconds
          ,"user_id":_user.email
        });
    batch.commit();
    navigateToHome();
  }
}
