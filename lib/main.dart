import 'package:flutter/material.dart';
import 'package:untitled/pages/mainpage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Score",
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(color: Colors.black, fontSize:30),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: const MainPage(),
    );
  }
}





















































































