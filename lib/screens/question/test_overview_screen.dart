import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/custom_text_style.dart';
import 'package:quizquiz/controllers/question_paper/question_controller.dart';
import 'package:quizquiz/widgets/common/background_decoration.dart';
import 'package:quizquiz/widgets/common/main_button.dart';
import 'package:quizquiz/widgets/content_area.dart';
import 'package:quizquiz/widgets/questions/answer_card.dart';
import 'package:quizquiz/widgets/questions/count_down_timer.dart';
import 'package:quizquiz/widgets/questions/custom_app_bar.dart';
import 'package:quizquiz/widgets/questions/question_number_card.dart';

import '../../configs/themes/ui_parameters.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({Key? key}) : super(key: key);
  static const String routeName = "/testoverview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completeTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CountDownTimer(
                            color: UiParameters.isDarkMood()
                                ? Theme.of(context).textTheme.bodyText1!.color
                                : Theme.of(context).primaryColor,
                            time: ''),
                        Obx(() => Text(
                              '${controller.time} ${'remaining'.tr}',
                              style: countDownTimerTs(),
                            ))
                      ],
                    ),
                   const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, index) {
                          // ignore: no_leading_underscores_for_local_identifiers
                          AnswerStatus? _answerStatus;
                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            _answerStatus = AnswerStatus.answered;
                          }
                          return QuestionNumberCard(
                              index: index + 1,
                              status: _answerStatus,
                              onTap: () => controller.jumpToQuestion(index));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: UiParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: () {
                    controller.complete();
                  },
                  title: 'complete1'.tr,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
