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
      body: Column(
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
                    ClipPath(
                      clipper: BackgroundClipper(),
                      child: Container(
                        height: UIData.spaceSizeHeight210,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().radius(22)),
                          // color: UIData.primaryColor,
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                                color: UIData.opacity25shadowColor,
                                offset: Offset(0, UIData.spaceSizeHeight4),
                                blurRadius: 30,
                                spreadRadius: 0)
                          ],
                        ),
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: UIData.spaceSizeHeight92),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: UIData.spaceSizeWith24),
                                child: Column(
                                  children: [
                                    const Icon(
                                      MyIcons.watchedIcon,
                                      color: Colors.white,
                                      size: 44,
                                    ),
                                    CommonText.mePageText('我看过的')
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: UIData.spaceSizeWith24),
                                child: Column(
                                  children: [
                                    const Icon(
                                      MyIcons.favoriteIcon,
                                      color: Colors.white,
                                      size: 44,
                                    ),
                                    CommonText.mePageText('我收藏的')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 110,
                      child: _circleBorder1(),
                    )
                  ]),
                  SizedBox(
                    height: UIData.spaceSizeHeight22,
                  ),
                  _buildItem(),
                  SizedBox(
                    height: UIData.spaceSizeHeight22,
                  ),
                  _buildItem(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _circleBorder1() {
    return Transform.translate(
      offset: const Offset(0, -155),
      child: Container(
        width: UIData.spaceSizeHeight92,
        height: UIData.spaceSizeWith92,
        // margin: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          // color: Colors.red,
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
      ),
    );
  }

  Widget _buildItem() {
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
            const Icon(
              MyIcons.aboutUsIcon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(
              width: UIData.spaceSizeWith10,
            ),
            CommonText.mePageText('关于我们')
          ],
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height * 0.1);
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
