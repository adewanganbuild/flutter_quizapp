import 'package:flutter/material.dart';

import 'package:revvit/page/options_widget.dart';

import 'package:revvit/model/category.dart';
import 'package:revvit/model/option.dart';
import 'package:revvit/model/question.dart';

class QuestionsWidget extends StatelessWidget {
  final Category category;
  final PageController controller;
  final ValueChanged<Option> onClickedOption;
  final ValueChanged<int> onChangedPage;

  const QuestionsWidget({
    Key? key,
    required this.category,
    required this.controller,
    required this.onChangedPage,
    required this.onClickedOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => PageView.builder(
        onPageChanged: onChangedPage,
        itemCount: category.questions.length,
        itemBuilder: (context, index) {
          final question = category.questions[index];

          return buildQuestion(question);
        },
      );

  Widget buildQuestion(
    @required Question question,
  ) =>
      Container(
          padding: EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 32),
            Text(
              question.text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              'Choose your answer from the below:',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            SizedBox(height: 32),
            Expanded(
                child: OptionsWidget(
              question: question,
              onClickedOption: onClickedOption,
            )),
          ]));
}
