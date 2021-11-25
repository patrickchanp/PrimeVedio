import 'package:flutter/material.dart';
import 'package:primevedio/common/indicator.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/video_type_list.dart';
import 'package:primevedio/ui/homepage/tab_info.dart';
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
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommonText.mainTitle('Prime '),
              CommonText.mainTitle('Video', color: Colors.white)
            ],
          ),
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
    with TickerProviderStateMixin {
  List<TabBarType>? getVideoType = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: getVideoType!.length, vsync: this);
    _getVideoTypeList();
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
          child: _buildTabBarView(),
        )
      ],
    );
  }

  Widget _buildTabBar() => Container(
        color: UIData.primaryColor,
        height: UIData.spaceSizeHeight40,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
          child: TabBar(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: UIData.fontSize20,
            ),
            isScrollable: true,
            controller: _tabController,
            indicator: StubTabIndicator(color: UIData.primarySwatch),
            unselectedLabelColor: Colors.white,
            tabs: getVideoType!.map((e) => Tab(text: e.typeName)).toList(),
          ),
        ),
      );

  Widget _buildTabBarView() => Container(
        color: UIData.primaryColor,
        child: TabBarView(
          controller: _tabController,
          children: getVideoType!
              .map((e) => TabInfo(
                    typeId: e.typeId,
                  ))
              .toList(),
        ),
      );

  _getVideoTypeList() {
    HttpUtil.request(
      HttpOptions.baseUrl,
      HttpUtil.GET,
    ).then((value) {
      TabBarListModel model = TabBarListModel.fromJson(value);
      setState(() {
        getVideoType = model.tabBarList;
      });
      _tabController = TabController(vsync: this, length: getVideoType!.length);
    });
  }
}
