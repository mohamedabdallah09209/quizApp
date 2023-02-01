import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRef = fireStore.collection("users");
final questionPaperRF = fireStore.collection('questionPapers');
final leaderBoardRF = fireStore.collection('leaderBoard');

DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRF.doc(paperId).collection("questions").doc(questionId);
