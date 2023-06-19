import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revvit/model/category.dart';
import 'package:revvit/model/option.dart';
import 'package:revvit/model/question.dart';
import 'package:revvit/widget/questions_widget.dart';

class CategoryPage extends StatefulWidget {
  final Category category;

  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  PageController? controller;
  Question? question;

  @override
  void initState() {
    super.initState();

    controller = PageController();
    question = widget.category.questions.first;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: QuestionsWidget(
          category: widget.category,
          controller: controller!,
          onChangedPage: (index) => nextQuestion(index: index),
          onClickedOption: selectOption,
        ),
      );

  void selectOption(Option option) {
    print("selectOption called with question : " + question!.text);
    if (question!.isLocked) {
      return;
    } else {
      setState(() {
        question!.isLocked = true;
        question!.selectedOption = option;
      });
    }
  }

  void nextQuestion({int index = 0}) {
    final nextPage = controller!.page! + 1;
    final indexPage = index ?? nextPage.toInt();

    setState(() {
      question = widget.category.questions[indexPage];
    });
  }
}
