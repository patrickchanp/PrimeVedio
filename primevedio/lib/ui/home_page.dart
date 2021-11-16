import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/utils/common_text.dart';
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonText.mainTitle('Prime '),
            CommonText.mainTitle('Video', color: Colors.white)
          ],
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
        Expanded(
          child: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: _buildTabBarView()),
          ),
        )
      ],
    );
  }

  Widget _buildTabBar() => Container(
        color: UIData.primaryColor,
        child: TabBar(
          onTap: (tab) => print(tab),
          labelStyle: TextStyle(
              fontSize: UIData.fontSize1906, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 19.06),
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.blue,
          indicatorWeight: 3,
          indicatorPadding:
              EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
          unselectedLabelColor: Colors.white,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
        ),
      );

  Widget _buildTabBarView() => Container(
        color: UIData.primaryColor,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabs
                    .map((e) => Center(
                            child: Text(
                          e,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )))
                    .toList(),
              ),
            ),
          ],
        ),
      );
}
