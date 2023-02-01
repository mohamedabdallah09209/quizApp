import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizquiz/firebase_ref/loading_status.dart';
import 'package:quizquiz/firebase_ref/references.dart';
import 'package:quizquiz/models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;
  void uploadData() async {
    loadingStatus.value = LoadingStatus.loading;
    final fireStore = FirebaseFirestore.instance;
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains(".json"))
        .toList();
    List<QuestionPaperModel> questionPaper = [];
    for (var paper in papersInAssets) {
      String stringPathContent = await rootBundle.loadString(paper);
      questionPaper
          .add(QuestionPaperModel.fromJson(json.decode(stringPathContent)));
    }
    //print(questionPaper[3].id);
    var batch = fireStore.batch();
    for (var paper in questionPaper) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions == null ? 0 : paper.questions!.length
      });
      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id, questionId: questions.id);
        batch.set(questionPath, {  
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });
        for (var answer in questions.answers) {
          batch.set(questionPath.collection("answers").doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
        }
      }
    }
    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;  
  }
}
