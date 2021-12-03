import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/ui/main_page.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const ClassicHeader(
        idleText: '下拉刷新',
        releaseText: '松手刷新',
        refreshingText: '正在刷新',
        refreshingIcon: Icon(
          MyIcons.refreshIcon,
          color: Colors.white,
        ),
        completeText: '刷新完成',
      ),
      footerBuilder: () => const ClassicFooter(
        loadingText: '正在加载',
        loadingIcon: Icon(
          MyIcons.refreshIcon,
          color: Colors.white,
        ),
      ),
      headerTriggerDistance: 80,
      springDescription:
          const SpringDescription(stiffness: 170, damping: 16, mass: 1.9),
      child: ScreenUtilInit(
        designSize: const Size(397, 859.64),
        builder: () => MaterialApp(
          title: 'Prime Video',
          theme: ThemeData(
              primaryColor: UIData.primaryColor,
              primarySwatch: Colors.blue,
              splashColor: const Color.fromRGBO(0, 0, 0, 0)),
          home: const MainPage(),
        ),
      ),
    );
  }
}
