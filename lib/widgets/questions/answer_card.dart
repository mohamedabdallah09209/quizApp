import 'package:flutter/material.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';

enum AnswerStatus { correct, wrong, answered, notanswered }

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback onTap;

  const AnswerCard(
      {super.key,
      required this.answer,
      this.isSelected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: UiParameters.cardBorderRadius,
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: UiParameters.cardBorderRadius,
              color: isSelected
                  ? answerSelectedColor()
                  : Theme.of(context).cardColor,
              border: Border.all(
                color: isSelected ? answerSelectedColor() : answerBorderColor(),
              )),
          child: Text(
            answer,
            style: TextStyle(
              color: isSelected ? onSurfaceTextColor : null,
            ),
          ),
        ));
  }
}

class CorrectAnswer extends StatelessWidget {
  final String answer;

  const CorrectAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UiParameters.cardBorderRadius,
        color: correctAnswerColor.withOpacity(0.1)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Text(
        answer,
        style: TextStyle(
          color: correctAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class NotAnswered extends StatelessWidget {
  final String answer;

  const NotAnswered({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UiParameters.cardBorderRadius,
        color: notAnsweredColor.withOpacity(0.1)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Text(
        answer,
        style: TextStyle(
          color: notAnsweredColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class WrongAnswer extends StatelessWidget {
  final String answer;

  const WrongAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: UiParameters.cardBorderRadius,
        color: wrongAnswerColor.withOpacity(0.1)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Text(
        answer,
        style: TextStyle(
          color: wrongAnswerColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
