import 'package:cached_network_image/cached_network_image.dart';
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

class SearchResultPage extends StatefulWidget {
  final String keys;
  const SearchResultPage({Key? key, required this.keys}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List<SearchResult>? getSearchResultList = [];
  _getSearchResult() async {
    Map<String, Object> params = {
      'ac': 'detail',
      'wd': widget.keys,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      SearchResultModel model = SearchResultModel.fromJson(value);
      setState(() {
        getSearchResultList = model.list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getSearchResult();
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
