import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class TabInfo extends StatefulWidget {
  const TabInfo({Key? key}) : super(key: key);

  @override
  State<TabInfo> createState() => _TabInfoState();
}

class _TabInfoState extends State<TabInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          left: UIData.spaceSizeWith24,
          right: UIData.spaceSizeWith24,
          top: UIData.spaceSizeWith24),
      children: [
        SizedBox(height: UIData.spaceSizeHeight17256, child: const ViewPage()),
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeWith16),
          child: CommonText.normalText('最新发布'),
        ),
        _gridView(),
      ],
    );
  }
}

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  var imgList = [
    'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2877516247,37083492&fm=26&gp=0.jpg',
    'https://pica.zhimg.com/v2-3b4fc7e3a1195a081d0259246c38debc_720w.jpg?source=172ae18b'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // pageSnapping: false,
      itemBuilder: (context, index) => _buildPageItem(index),
      // controller: _pageController,
    );
  }

  _buildPageItem(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ScreenUtil().radius(11.65)),
        image: DecorationImage(
            image: NetworkImage(imgList[index % 2]), fit: BoxFit.fill),
      ),
    );
  }
}

Widget _gridView() {
  return GridView.count(
    shrinkWrap: true,
    primary: false,
    crossAxisCount: 2,
    childAspectRatio: 0.7,
    mainAxisSpacing: 20,
    crossAxisSpacing: 16,
    children: [
      _buildReleaseItem(Colors.red),
      _buildReleaseItem(Colors.blue),
      _buildReleaseItem(Colors.green),
      _buildReleaseItem(Colors.yellow),
      _buildReleaseItem(Colors.yellow),
    ],
  );
}

Widget _buildReleaseItem(color) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(11.65)),
            color: color),
        height: UIData.spaceSizeHeight202,
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 12.0),
        child: CommonText.normalText("text"),
      )
    ],
  );
}
