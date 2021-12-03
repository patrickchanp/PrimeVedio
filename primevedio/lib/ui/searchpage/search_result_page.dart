import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/search_result_model.dart';
import 'package:primevedio/ui/playpage/play_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/log_util.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultPage extends StatefulWidget {
  final String keys;
  const SearchResultPage({Key? key, required this.keys}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //每页显示的数量
  static const int pageSize = 10;
  //当前页数
  int page = 1;
  //是否加载过数据
  late bool loaded;
  //是否允许上拉
  late bool _enablePullUp = true;
  //数据
  List<SearchResult>? getSearchResultList = [];
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

  _loadData(final bool onRefresh) async {
    int pageNum;
    if (onRefresh) {
      pageNum = 1;
    } else {
      pageNum = page + 1;
    }
    Map<String, Object> params = {
      'ac': 'detail',
      'wd': widget.keys,
      // 'pg': 1,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      SearchResultModel model = SearchResultModel.fromJson(value);
      //总数小于等于
      if (model.pagecount <= model.total) {
        _enablePullUp = false;
      }
      if (model.total > 0 && model.list.isNotEmpty) {
        page = pageNum;
        if (onRefresh) {
          loaded = true;
          getSearchResultList!.clear();
          getSearchResultList = model.list;
          _refreshController.refreshCompleted();
        } else {
          getSearchResultList!.add(value);
          if (mounted) {
            setState(() {});
          }
          _refreshController.loadComplete();
        }
      }
      setState(() {
        // getSearchResultList = model.list;
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
    return Scaffold(
      backgroundColor: UIData.primaryColor,
      appBar: AppBar(
        backgroundColor: UIData.primaryColor,
        title: CommonText.normalText('搜索结果页', color: Colors.white),
      ),
      body: _searchResult(),
    );
  }

  Widget _searchResult() {
    return getSearchResultList!.isNotEmpty
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullUp: _enablePullUp,
              enablePullDown: true,
              onLoading: _onLoading, //加载下一页回调
              onRefresh: _onRefresh, //刷新回调
              child: GridView.builder(
                shrinkWrap: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  mainAxisSpacing: UIData.spaceSizeHeight22,
                  crossAxisSpacing: UIData.spaceSizeWith24,
                ),
                itemCount: getSearchResultList!.length,
                itemBuilder: (context, int index) => _buildItem(index),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            child: CommonText.mainTitle('暂无相关资源，换个关键词试试'),
          );
  }

  _buildItem(int index) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                      getSearchResultList![index].vodPic),
                  fit: BoxFit.cover),
            ),
            height: UIData.spaceSizeHeight202,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: CommonText.titleText(getSearchResultList![index].vodName),
          )
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlayPage(
            ids: getSearchResultList![index].vodId,
            typeId: getSearchResultList![index].typeId,
          );
        }));
      },
    );
  }
}
