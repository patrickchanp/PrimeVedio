import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/ui/search_page.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

import 'home_page.dart';
import 'me_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(
      icon: Icon(
        MyIcons.homeIcon,
        size: 30,
        color: UIData.unselectColor,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        MyIcons.searchIcon,
        size: 30,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        MyIcons.meIcon,
        size: 30,
        color: UIData.unselectColor,
      ),
      label: '',
    ),
  ];

  late int _currentIndex;
  final pages = const [HomePage(), SearchPage(), MePage()];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: UIData.spaceSizeHeight10375,
        child: BottomNavigationBar(
          backgroundColor: UIData.bottomBgColor,
          items: bottomNavItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            changePage(index);
          },
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  void changePage(int index, {bool isSelected = false}) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      isSelected = true;
    }
  }
}
