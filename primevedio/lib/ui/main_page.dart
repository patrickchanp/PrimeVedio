import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        size: 26,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        MyIcons.searchIcon,
        size: 26,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        MyIcons.meIcon,
        size: 26,
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
        height: 103.75,
        child: BottomNavigationBar(
          backgroundColor: UIData.bottomBgColor,
          items: bottomNavItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            _changePage(index);
          },
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  void _changePage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
