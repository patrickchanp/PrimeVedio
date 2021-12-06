import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/common/common_grid_view.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/swiper_list.dart';
import 'package:primevedio/ui/playpage/play_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabInfo extends StatefulWidget {
  final int typeId;

  const TabInfo({Key? key, required this.typeId}) : super(key: key);

  @override
  State<TabInfo> createState() => _TabInfoState();
}

class _TabInfoState extends State<TabInfo> {
  int ids = 0;
  int page = 1;

  //数据
  List<PageViewListModel>? getSearchResultList = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _loadData(true);
  }

  void _onLoading() async {
    _loadData(false);
  }

  void _initData() async {
    _loadData(true);
  }

  List<PageList>? getSwiperList = [];

  _loadData(final bool onRefresh) async {
    if (onRefresh) {
      page = 1;
    } else {
      page += 1;
    }
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.typeId,
      'pg': page,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      PageViewListModel model = PageViewListModel.fromJson(value);
      if (!mounted) {
        return;
      }
      setState(() {
        if (model.total > 0 && model.list.isNotEmpty) {
          if (onRefresh) {
            getSwiperList!.clear();
            getSwiperList = model.list;
            _refreshController.refreshCompleted();
          } else {
            getSwiperList!.addAll(model.list);
            _refreshController.loadComplete();
          }
          if (getSwiperList!.length >= model.total) {}
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(
            left: UIData.spaceSizeWith24,
            right: UIData.spaceSizeWith24,
            top: UIData.spaceSizeWith24),
        children: [
          SizedBox(
              height: UIData.spaceSizeHeight176,
              child: _viewPage(typeId: widget.typeId)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeWith16),
            child: CommonText.normalText('最新发布'),
          ),
          CommonGridViewPage(
            getSwiperList: getSwiperList,
          )
        ],
      ),
    );
  }

  Widget _viewPage({required int typeId}) {
    return PageView.builder(
      itemCount: getSwiperList!.length,
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
              image: CachedNetworkImageProvider(getSwiperList![index].vodPic),
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
}
