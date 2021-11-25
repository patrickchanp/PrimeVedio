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

class GuessLike extends StatefulWidget {
  final int typeId;
  const GuessLike({Key? key, required this.typeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GuessLikeState();
}

class _GuessLikeState extends State<GuessLike> {
  List<PageList>? getRecentList = [];

  _getRecentRelease() async {
    Map<String, Object> params = {
      'ac': 'detail',
      't': widget.typeId,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      PageViewListModel model = PageViewListModel.fromJson(value);
      setState(() {
        getRecentList = model.list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getRecentRelease();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith24),
      shrinkWrap: false,
      primary: false,
      itemCount: getRecentList!.length,
      itemBuilder: (context, int index) => _buildItem(index),
    );
  }

  _buildItem(int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: ScreenUtil().screenWidth / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        getRecentList![index].vodPic),
                    fit: BoxFit.cover),
              ),
              height: UIData.spaceSizeHeight104,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    left: UIData.spaceSizeWith16,
                    top: UIData.spaceSizeHeight11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText.titleText(' ${getRecentList![index].vodName}'),
                    CommonText.titleText(getRecentList![index].vodLang),
                    CommonText.titleText(getRecentList![index].vodArea),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlayPage(
            ids: getRecentList![index].vodId,
            typeId: getRecentList![index].typeId,
          );
        }));
      },
    );
  }
}
