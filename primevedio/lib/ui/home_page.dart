import 'package:flutter/material.dart';
import 'package:primevedio/utils/ui_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIData.primaryColor,
        title: const Text(
          'prime video',
          style: TextStyle(fontSize: 25.41),
        ),
      ),
      body: const CustomTabBarView(),
    );
  }
}

class CustomTabBarView extends StatefulWidget {
  const CustomTabBarView({Key? key}) : super(key: key);

  @override
  _CustomTabBarViewState createState() => _CustomTabBarViewState();
}

class _CustomTabBarViewState extends State<CustomTabBarView>
    with SingleTickerProviderStateMixin {
  final tabs = ['电影', '连续剧', '综艺', '动漫', '资讯', '动作片'];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildTabBar(),
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: _buildTabBarView())
      ],
    );
  }

  Widget _buildTabBar() => TabBar(
        onTap: (tab) => print(tab),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 16),
        isScrollable: true,
        controller: _tabController,
        labelColor: Colors.blue,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
        unselectedLabelColor: Colors.grey,
        tabs: tabs.map((e) => Tab(text: e)).toList(),
      );

  Widget _buildTabBarView() => TabBarView(
      controller: _tabController,
      children: tabs
          .map((e) => Center(
                  child: Text(
                e,
                style: TextStyle(color: Colors.white, fontSize: 20),
              )))
          .toList());
}
