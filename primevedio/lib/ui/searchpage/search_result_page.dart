import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/common/common_grid_view.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/swiper_list.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchResultPage extends StatefulWidget {
  final String keys;

  const SearchResultPage({Key? key, required this.keys}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //当前页数
  int page = 1;
  late int typeId = 0;

  //数据
  List<PageList>? getSearchResultList = [];
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

  //有性能问题
  _loadData(final bool onRefresh) async {
    if (onRefresh) {
      page = 1;
    } else {
      page += 1;
    }
    Map<String, Object> params = {
      'ac': 'detail',
      'wd': widget.keys,
      'pg': page,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      PageViewListModel model = PageViewListModel.fromJson(value);
      //解决异步场景
      if (!mounted) {
        return;
      }
      setState(() {
        if (model.total > 0 && model.list.isNotEmpty) {
          if (onRefresh) {
            getSearchResultList!.clear();
            getSearchResultList = model.list;
            _refreshController.refreshCompleted();
          } else {
            getSearchResultList!.addAll(model.list);
            _refreshController.loadComplete();
          }
          if (getSearchResultList!.length >= model.total) {}
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
                enablePullUp: true,
                enablePullDown: true,
                onLoading: _onLoading,
                //加载下一页回调
                onRefresh: _onRefresh,
                //刷新回调
                child: CommonGridViewPage(
                  getSwiperList: getSearchResultList,
                  typeId: int.tryParse(
                      getSearchResultList!.map((e) => e.typeId).toString()),
                )),
          )
        : Container(
            alignment: Alignment.center,
            child: CommonText.mainTitle('暂无相关资源，换个关键词试试'),
          );
  }
}
