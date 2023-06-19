import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revvit/page/category_page.dart';
import 'package:revvit/data/categories.dart';
import 'package:revvit/page/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'Quiz App';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: HomePage(),
        // home: CategoryPage(category: categories.first),
      );
}
