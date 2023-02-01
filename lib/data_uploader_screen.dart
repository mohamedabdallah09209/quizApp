import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/controllers/question_paper/data_uploader.dart';
import 'package:quizquiz/firebase_ref/loading_status.dart';

// ignore: must_be_immutable
class DataUploaderScreen extends StatelessWidget {
  DataUploaderScreen({Key? key}) : super(key: key);
  DataUploader controller = Get.put(DataUploader());

  @override
  Widget build(BuildContext context) {
    controller.uploadData();
    return Scaffold(
      body: Center(
        child: Obx(() => Text(
            controller.loadingStatus.value == LoadingStatus.completed
                ? "uploading completed"
                : "Uploading"),
        ),
      ),
    );
  }
}
