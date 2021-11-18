import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/ui/main_page.dart';
import 'package:primevedio/utils/ui_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(397, 859.64),
      builder: () => MaterialApp(
        title: 'Prime Video',
        theme: ThemeData(
            primaryColor: UIData.primaryColor,
            primarySwatch: Colors.blue,
            splashColor: const Color.fromRGBO(0, 0, 0, 0)),
        home: const MainPage(),
      ),
    );
  }
}
