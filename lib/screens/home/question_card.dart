import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_icons.dart';
import 'package:quizquiz/controllers/question_paper/question_paper_controller.dart';
import 'package:quizquiz/models/question_paper_model.dart';
import 'package:quizquiz/widgets/app_icon_text.dart';
import '../../configs/themes/custom_text_style.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';

class QuestionCard extends GetView<QuestionPaperController> {
  final QuestionPaperModel model;

  const QuestionCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    const double padding = 10.0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UiParameters.cardBorderRadius,
        color: Theme.of(context).cardColor,
      ),
      child: InkWell(
        onTap: () {
          controller.navigateToQuestions(paperModel: model, tryAgain: false);
        },
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      child: SizedBox(
                        height: Get.width * 0.15,
                        width: Get.width * 0.15,
                        child: CachedNetworkImage(
                          imageUrl: model.imageUrl!,
                          placeholder: ((context, url) => Container(
                                alignment: Alignment.center,
                                child: const CircularProgressIndicator(),
                              )),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/app_splash_logo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: cardTitles(context),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(model.description),
                        ),
                        Row(children: [
                          AppIconText(
                              icon: Icon(
                                Icons.help_outline_sharp,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                '${model.questionCount} ${'qustions'.tr}',
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          AppIconText(
                              icon: Icon(
                                Icons.timer,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                              ),
                              text: Text(
                                model.timeInMinites(),
                                style: detailText.copyWith(
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Theme.of(context).primaryColor,
                                ),
                              )),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -padding,
                right: -padding,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cardBorderRadius),
                        bottomRight: Radius.circular(cardBorderRadius),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: const Icon(AppIcons.traphyOutLine),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
