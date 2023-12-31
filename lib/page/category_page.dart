import 'package:flutter/material.dart';
import 'package:revvit/model/category.dart';
import 'package:revvit/model/option.dart';
import 'package:revvit/model/question.dart';
//import 'package:revvit/model/result.dart';
import 'package:revvit/widget/questions_widget.dart';
import 'package:revvit/widget/question_numbers_widget.dart';

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
    Category.getCategoriesFromFirestore();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: buildAppBar(context),
        body: QuestionsWidget(
          category: widget.category,
          controller: controller!,
          onChangedPage: (index) => nextQuestion(index: index),
          onClickedOption: selectOption,
        ),
      );

  void selectOption(Option option) {
    // print("clicked selectOption");
    // Result.saveResult();
    if (question!.isLocked) {
      return;
    } else {
      setState(() {
        question!.isLocked = true;
        question!.selectedOption = option;
      });
    }
  }

  void nextQuestion({int index = 0, bool jump = false}) {
    // print('nextQuestion called...');
    // Result.saveResult();
    double currPage = 0;
    if (controller!.page != null) currPage = controller!.page as double;
    final nextPage = currPage + 1;
    final indexPage = index ?? nextPage.toInt();
    setState(() {
      question = widget.category.questions[indexPage];
    });

    if (jump) {
      controller!.jumpToPage(indexPage);
    }
  }

  AppBar buildAppBar(context) => AppBar(
        title: Text(widget.category.categoryName),
        actions: [
          Icon(Icons.filter_alt_outlined),
          SizedBox(
            width: 16,
          ),
          //GuestBook(addMessage: (message) => print(message)),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: QuestionNumbersWidget(
              questions: widget.category.questions,
              question: question!,
              onClickedNumber: (index) =>
                  nextQuestion(index: index, jump: true),
            ),
          ),
        ),
      );
}
