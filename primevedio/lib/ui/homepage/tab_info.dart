import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/swiper_list.dart';
import 'package:primevedio/ui/playpage/play_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

import 'grid_view_page.dart';

class TabInfo extends StatefulWidget {
  final int typeId;

  const TabInfo({Key? key, required this.typeId}) : super(key: key);

  @override
  State<TabInfo> createState() => _TabInfoState();
}

class _TabInfoState extends State<TabInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          left: UIData.spaceSizeWith24,
          right: UIData.spaceSizeWith24,
          top: UIData.spaceSizeWith24),
      children: [
        SizedBox(
            height: UIData.spaceSizeHeight176,
            child: ViewPage(typeId: widget.typeId)),
        Padding(
          padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeWith16),
          child: CommonText.normalText('最新发布'),
        ),
        GridViewPage(typeId: widget.typeId),
      ],
    );
  }
}

class ViewPage extends StatefulWidget {
  final int typeId;
  const ViewPage({Key? key, required this.typeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  var imgList = [];
  // int currentIndex = 0;
  // late PageController _pageController;
  // late Timer _timer;

  List<PageList>? getSwiperList = [];

  _getSwiperList() async {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.typeId,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      PageViewListModel pageViewListModel = PageViewListModel.fromJson(value);
      setState(() {
        getSwiperList = pageViewListModel.list;
        imgList = getSwiperList!.map((e) => e.vodPic).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getSwiperList();
    // _timer;
    // _pageController = PageController(initialPage: currentIndex);
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    //   startTimer();
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // controller: _pageController,
      onPageChanged: (int index) {
        setState(() {
          // currentIndex = index;
        });
      },
      itemCount: imgList.length,
      itemBuilder: (context, index) => _buildPageItem(index),
    );
  }

  _buildPageItem(int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
          image: DecorationImage(
              image: CachedNetworkImageProvider(imgList[index]),
              fit: BoxFit.fill),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlayPage(
            ids: getSwiperList![index].vodId,
            typeId: getSwiperList![index].typeId,
          );
        }));
      },
    );
  }
  //
  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(milliseconds: 3000), (value) {
  //     currentIndex++;
  //     _pageController.animateToPage(currentIndex,
  //         duration: Duration(milliseconds: 3000), curve: Curves.ease);
  //     setState(() {});
  //   });
  // }
}
