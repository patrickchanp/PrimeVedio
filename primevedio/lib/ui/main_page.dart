import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/ui/searchpage/search_page.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

import 'homepage/home_page.dart';
import 'mepage/me_page.dart';

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
      ),
      label: '',
    ),
  ];

  late int _currentIndex;
  final pages = [
    const HomePage(),
    SearchPage(),
    const GlobalKeyCommunication()
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: UIData.spaceSizeHeight104,
        child: BottomNavigationBar(
          backgroundColor: UIData.bottomBgColor,
          items: bottomNavItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: UIData.primarySwatch,
          unselectedItemColor: UIData.unselectColor,
          onTap: (index) {
            changePage(index);
          },
        ),
      ),
      body: pages[_currentIndex],
    );
  }

  void changePage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
