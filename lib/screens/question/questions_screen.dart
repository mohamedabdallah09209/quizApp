import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/configs/themes/custom_text_style.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';
import 'package:quizquiz/controllers/question_paper/question_controller.dart';
import 'package:quizquiz/firebase_ref/loading_status.dart';
import 'package:quizquiz/screens/question/test_overview_screen.dart';
import 'package:quizquiz/widgets/content_area.dart';
import 'package:quizquiz/widgets/question_screen_holder.dart';
import 'package:quizquiz/widgets/questions/answer_card.dart';
import 'package:quizquiz/widgets/questions/count_down_timer.dart';
import 'package:quizquiz/widgets/questions/custom_app_bar.dart';

import '../../widgets/common/background_decoration.dart';
import '../../widgets/common/main_button.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({Key? key}) : super(key: key);
  static const String routeName = "/questions";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          // ignore: sort_child_properties_last
          child: Obx(
            () => CountDownTimer(
              time: controller.time.value,
              color: onSurfaceTextColor,
            ),
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(color: onSurfaceTextColor, width: 2),
            ),
          ),
        ),
        showActionIcon: true,
        titleWidget: Obx(
          () => Text(
            '${'q'.tr} . ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
            style: appBarTs,
          ),
        ),
      ),
      body: BackgroundDecoration(
        child: Obx(
          (() => Column(
                children: [
                  if (controller.loadingStatus.value == LoadingStatus.loading)
                    const Expanded(
                        child: ContentArea(child: QuestionScreenHolder())),
                  if (controller.loadingStatus.value == LoadingStatus.completed)
                    Expanded(
                      child: ContentArea(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            children: [
                              Text(
                                controller.currentQuestion.value!.question,
                                style: quistionTs,
                              ),
                              GetBuilder<QuestionsController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(top: 25),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
                                        return AnswerCard(
                                          answer:
                                              '${answer.identifier}. ${answer.answer}',
                                          onTap: () {
                                            controller.selectedAnswer(
                                                answer.identifier);
                                          },
                                          isSelected: answer.identifier ==
                                              controller.currentQuestion.value!
                                                  .selectedAnswer,
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, index) =>
                                              const SizedBox(
                                                height: 10,
                                              ),
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ColoredBox(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: UiParameters.mobileScreenPadding,
                      child: Row(
                        children: [
                          Visibility(
                            visible: controller.isFirstQuestion,
                            child: SizedBox(
                              width: 55,
                              height: 55,
                              child: MainButton(
                                onTap: () {
                                  controller.prevQuestion();
                                },
                                child: Icon(
                                  Icons.arrow_back,size: 25,
                                  color: Get.isDarkMode
                                      ? onSurfaceTextColor
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Visibility(
                              visible: controller.loadingStatus.value ==
                                  LoadingStatus.completed,
                              child: MainButton(
                                onTap: () {
                                  controller.isLastQuestion
                                      ? Get.toNamed(
                                          TestOverviewScreen.routeName)
                                      : controller.nextQuestion();
                                },
                                title: controller.isLastQuestion
                                    ? 'complete'.tr
                                    : 'next'.tr,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
