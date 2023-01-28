import 'package:flutter/material.dart';
import 'package:placementprep/models/test_questions/TestQuestion.dart';
import 'package:placementprep/utils/colors.dart';

class OptionWidget extends StatelessWidget {
  final TestQuestion question;
  final ValueChanged<Options> onClickedOption;

  const OptionWidget(
      {Key? key, required this.question, required this.onClickedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: question.options!
              .map((option) => buildOption(context, option))
              .toList()),
    );
  }

  Widget buildOption(BuildContext context, Options option) {
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: kSecondaryBackgroundColor,
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  option.text.toString(),
                  style: const TextStyle(
                      fontSize: 14, color: kPrimaryBackgroundColor),
                ),
              ),
              getIconForOption(option, question)
            ],
          )),
    );
  }
}

Color getColorForOption(Options option, TestQuestion question) {
  final isSelected = option == question.selectedOption;

  if (question.isLocked) {
    if (isSelected) {
      return kPrimaryBackgroundColor;
    }
  }
  return Colors.transparent;
}

Widget getIconForOption(Options option, TestQuestion question) {
  final isSelected = option == question.selectedOption;

  if (question.isLocked) {
    if (isSelected) {
      return const Icon(Icons.check_circle, color: kPrimaryBackgroundColor);
    }
  }

  return const SizedBox.shrink();
}
