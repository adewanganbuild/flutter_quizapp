import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:revvit/data/questions.dart';
import 'package:revvit/model/question.dart';

class Category {
  final String categoryName;
  final String description;
  final Color backgroundColor;
  final IconData icon;
  final List<Question> questions;
  final String imageUrl;

  Category({
    required this.imageUrl,
    required this.questions,
    required this.categoryName,
    this.description = '',
    this.backgroundColor = Colors.orange,
    this.icon = FontAwesomeIcons.question,
  });

  static Future<List<Category>> getCategoriesFromFirestore() async {
    CollectionReference ref = FirebaseFirestore.instance.collection('category');
    QuerySnapshot eventsQuery = await ref
        // .where("time", isGreaterThan: new DateTime.now().millisecondsSinceEpoch)
        // .where("food", isEqualTo: true)
        .get();

    HashMap<String, Category> eventsHashMap = new HashMap<String, Category>();

    eventsQuery.docs.forEach((document) {
      print(document['name']);
      eventsHashMap.putIfAbsent(
          document['name'],
          () => Category(
              categoryName: document['name'],
              questions: questionsChem,
              imageUrl: 'assets/maths.png'));
    });

    int num = eventsHashMap.values.toList().length;
    print("Got $num categories from firestore.");
    return eventsHashMap.values.toList();
  }
}
