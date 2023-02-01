import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizquiz/controllers/auth_controller.dart';
import 'package:quizquiz/controllers/question_paper/question_paper_controller.dart';
import 'package:quizquiz/firebase_ref/loading_status.dart';
import 'package:quizquiz/firebase_ref/references.dart';
import 'package:quizquiz/models/question_paper_model.dart';
import 'package:quizquiz/screens/home/home_screen.dart';
import 'package:quizquiz/screens/introduction/introduction.dart';

import '../../screens/question/result_screen.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  Rxn<Questions> currentQuestion = Rxn<Questions>();

  Timer? _timer;
  int remainSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final qustionPaper = Get.arguments as QuestionPaperModel;
    loadData(qustionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionsQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();
      final questions = questionsQuery.docs
          .map((question) => Questions.fromSnapshot(question))
          .toList();

      questionPaperModel.questions = questions;
      for (Questions question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();
        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();

        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list','answers_review_list']);
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) return;
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  String get completeTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return '$answered ${'outof'.tr} ${allQuestions.length} ${'answered'.tr}';
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) return;
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainSeconds--;
      }
    });
  }

  void tryAgain() {
    Get.find<QuestionPaperController>()
        .navigateToQuestions(paperModel: questionPaperModel, tryAgain: true);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(AppIntroductionScreen.routeName, (route) => false);
  }
}
