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
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: UIData.spaceSizeWith24,
              right: UIData.spaceSizeWith6622,
              top: UIData.spaceSizeHeight30),
          child: const ViewPage(),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: UIData.spaceSizeWith24,
            top: UIData.spaceSizeHeight2244,
            bottom: UIData.spaceSizeHeight1771,
          ),
          child: Row(children: [
            CommonText.normalText('最新发布', textAlign: TextAlign.left),
          ]),
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
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582796218195&di=04ce93c4ac826e19067e71f916cec5d8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F344fda8b47808261c946c81645bff489c008326f15140-koiNr3_fw658'
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
    return SizedBox(
        height: UIData.spaceSizeHeight17256,
        width: UIData.spaceSizeWith30678,
        child: PageView.builder(
          itemBuilder: (context, index) => _buildPageItem(index),
          // controller: _pageController,
        ));
  }

  _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();

    return Transform(
      transform: matrix4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(11.65)),
          image: DecorationImage(
              image: NetworkImage(imgList[index % 2]), fit: BoxFit.cover),
        ),
      ),
    );
  }
}

Widget _gridView() {
  return GridView.count(
    shrinkWrap: true,
    primary: false,
    padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
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
        // color: color,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenUtil().radius(11.65)),
            color: color),
        height: UIData.spaceSizeHeight202,
        width: UIData.spaceSizeWith159,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: CommonText.normalText("text"),
      )
    ],
  );
}
