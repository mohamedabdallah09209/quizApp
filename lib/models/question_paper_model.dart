import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      this.questions,
      required this.questionCount});

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  /*if (json['questions'] != null) {
      questions = new List<Questions>();
      json['questions'].forEach((v) {
        questions.add(new Questions.fromJson(v));
      });
    }*/

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title =
            json.data().toString().contains('title') ? json.get('title') : '',
        imageUrl = json.data().toString().contains('image_url')
            ? json.get('image_url')
            : '',
        description = json.data().toString().contains('description')
            ? json.get('description')
            : '',
        timeSeconds = json.data().toString().contains('time_seconds')
            ? json.get('time_seconds') as int
            : 0,
        questionCount = json.data().toString().contains('questions_count')
            ? json.get('questions_count') as int
            : 0,
        questions = [];
  String timeInMinites() => "${(timeSeconds / 60).ceil()} ${'mins'.tr}";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['description'] = description;
    data['time_seconds'] = timeSeconds;
    /*if (this.questions != null) {
      data['questions'] = this.questions.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
   String? selectedAnswer;

  Questions(
      {required this.id,
      required this.question,
      required this.answers,
      this.correctAnswer,this.selectedAnswer});

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        /* if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }*/
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    // ignore: unnecessary_null_comparison
    if (answers != null) {
      data['answers'] = answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['answer'];

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String,
        answer = snapshot['answer'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}
