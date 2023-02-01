import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';
import 'package:quizquiz/controllers/question_paper/question_controller.dart';
import 'package:quizquiz/controllers/question_paper/question_controller_extention.dart';
import 'package:quizquiz/screens/question/answer_check_screen.dart';
import 'package:quizquiz/widgets/common/background_decoration.dart';
import 'package:quizquiz/widgets/common/main_button.dart';
import 'package:quizquiz/widgets/content_area.dart';
import 'package:quizquiz/widgets/questions/answer_card.dart';

import '../../configs/themes/custom_text_style.dart';
import '../../widgets/questions/custom_app_bar.dart';
import '../../widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);
  static const String routeName = "/result";
  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: SizedBox(height: 80),
        title: controller.correctAnswerQuestions,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    SvgPicture.asset('assets/images/bulb.svg'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        "congratulation".tr,
                        style: headerText.copyWith(color: _textColor),
                      ),
                    ),
                    Text(
                      "${'youhave'.tr} ${controller.points} ${'points'.tr}",
                      style: TextStyle(color: _textColor),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "tabvca".tr,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: controller.allQuestions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: Get.width ~/ 75,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (_, index) {
                          final _qustion = controller.allQuestions[index];
                          AnswerStatus _status = AnswerStatus.notanswered;
                          final _selectedAnswer = _qustion.selectedAnswer;
                          final _correctAnswer = _qustion.correctAnswer;
                          if (_selectedAnswer == _correctAnswer) {
                            _status = AnswerStatus.correct;
                          } else if (_qustion.selectedAnswer == null) {
                            _status = AnswerStatus.wrong;
                          } else {
                            _status = AnswerStatus.wrong;
                          }
                          return QuestionNumberCard(
                              index: index + 1,
                              status: _status,
                              onTap: () {
                                controller.jumpToQuestion(index,
                                    isGoBack: false);
                                Get.toNamed(AnswerCheckScreen.routeName);
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UiParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.tryAgain();
                        },
                        color: Colors.blue[800],
                        title: 'tryagain'.tr,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MainButton(
                        onTap: () {
                          controller.saveTestResult();
                        },
                        title: 'home'.tr,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
