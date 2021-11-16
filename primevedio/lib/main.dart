import 'package:flutter/material.dart';
import 'package:primevedio/ui/main_page.dart';
import 'package:primevedio/utils/ui_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Video',
      theme: ThemeData(
        primaryColor: UIData.primaryColor,
        primarySwatch: Colors.blueGrey,
      ),
      home: const MainPage(),
    );
  }
}
