import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/configs/themes/app_light_theme.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';
import 'package:quizquiz/widgets/questions/answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  final int index;
  final AnswerStatus? status;
  final VoidCallback onTap;

  const QuestionNumberCard(
      {super.key,
      required this.index,
      required this.status,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Color _backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        _backgroundColor =
            Get.isDarkMode ? cardColor : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        _backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        _backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
        _backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.2);
        break;
      default:
       _backgroundColor= Theme.of(context).primaryColor.withOpacity(0.2);
    }
    return InkWell(
      onTap: onTap,
      borderRadius: UiParameters.cardBorderRadius,
      child: Ink(
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: UiParameters.cardBorderRadius
        ),
        child: Center(
          child: Text(
            '$index',
            style: TextStyle(
                color: status == AnswerStatus.answered
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ),
    );
  }
}
