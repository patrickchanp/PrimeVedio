import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.primaryColor,
      body: ListView(
        children: [
          SizedBox(
            height: UIData.spaceSizeHeight313,
            child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Image.network(
                  'https://img.syt5.com/2020/0904/20200904085741407.jpg.1680.0.jpg',
                  fit: BoxFit.cover,
                )),
          ),
          Transform.translate(
            offset: const Offset(0, -85),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith11),
              child: Column(
                children: [
                  Stack(children: [
                    //clippath加阴影
                    ClipPath(
                      clipper: BackgroundClipper(),
                      child: Container(
                        color: UIData.primaryColor,
                        height: UIData.spaceSizeHeight210,
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: UIData.spaceSizeHeight92),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UIData.spaceSizeWith24),
                                child:
                                    _buildMyInfo(MyIcons.watchedIcon, '我看过的'),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      right: UIData.spaceSizeWith24),
                                  child: _buildMyInfo(
                                      MyIcons.favoriteIcon, '我收藏的'))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                            offset: const Offset(0, -50),
                            child: _circleBorder1()),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: UIData.spaceSizeHeight22,
                  ),
                  _buildItem(MyIcons.aboutUsIcon, '关于我们'),
                  SizedBox(
                    height: UIData.spaceSizeHeight22,
                  ),
                  _buildItem(MyIcons.licenseIcon, 'LICENSE'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _circleBorder1() {
    return Container(
      width: UIData.spaceSizeHeight92,
      height: UIData.spaceSizeWith92,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://img.syt5.com/2020/0904/20200904085741407.jpg.1680.0.jpg',
          ),
          fit: BoxFit.cover,
        ),
        shape: CircleBorder(
          side: BorderSide(
              width: UIData.spaceSizeWith5, color: UIData.primaryColor),
        ),
      ),
    );
  }

  Widget _buildItem(IconData iconData, String message) {
    return Container(
      height: UIData.spaceSizeHeight75,
      decoration: BoxDecoration(
        color: UIData.primaryColor,
        borderRadius: BorderRadius.circular(ScreenUtil().radius(22)),
        boxShadow: [
          BoxShadow(
              color: UIData.opacity25shadowColor,
              offset: Offset(0, UIData.spaceSizeHeight4),
              blurRadius: 30,
              spreadRadius: 0)
        ],
      ),
      child: GestureDetector(
        child: Row(
          children: [
            SizedBox(
              width: UIData.spaceSizeWith24,
            ),
            Icon(
              iconData,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(
              width: UIData.spaceSizeWith10,
            ),
            CommonText.mePageText(message)
          ],
        ),
      ),
    );
  }
}

Widget _buildMyInfo(IconData iconData, String text) {
  return Column(
    children: [
      SizedBox(
        height: UIData.spaceSizeHeight22,
      ),
      Icon(
        iconData,
        color: Colors.white,
        size: 44,
      ),
      CommonText.mePageText(text)
    ],
  );
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height * 0.1);
    // path.arcTo(rect, startAngle, sweepAngle, forceMoveTo)
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.1);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
