import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/swiper_list.dart';
import 'package:primevedio/ui/play_page/play_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class GridViewPage extends StatefulWidget {
  final int typeId;
  const GridViewPage({Key? key, required this.typeId}) : super(key: key);

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: UIData.spaceSizeHeight22,
        crossAxisSpacing: UIData.spaceSizeWith24,
      ),
      itemCount: getRecentList!.length,
      itemBuilder: (context, int index) => _buildGridItem(index),
    );
  }

  _buildGridItem(int index) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScreenUtil().radius(12)),
              image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(getRecentList![index].vodPic),
                  fit: BoxFit.cover),
            ),
            height: UIData.spaceSizeHeight202,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: CommonText.titleText(getRecentList![index].vodName),
          )
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlayPage(ids: getRecentList![index].vodId);
        }));
      },
    );
  }
}
