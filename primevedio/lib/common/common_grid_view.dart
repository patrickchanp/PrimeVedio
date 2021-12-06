import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:primevedio/model/swiper_list.dart';
import 'package:primevedio/ui/playpage/play_page.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class CommonGridViewPage extends StatefulWidget {
  final int? typeId;
  final List<PageList>? getSwiperList;

  const CommonGridViewPage({Key? key, this.typeId, this.getSwiperList})
      : super(key: key);

  @override
  _CommonGridViewPageState createState() => _CommonGridViewPageState();
}

class _CommonGridViewPageState extends State<CommonGridViewPage> {
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
      itemCount: widget.getSwiperList!.length,
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
                  image: CachedNetworkImageProvider(
                      widget.getSwiperList![index].vodPic),
                  fit: BoxFit.cover),
            ),
            height: UIData.spaceSizeHeight202,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: CommonText.titleText(widget.getSwiperList![index].vodName),
          )
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PlayPage(
            ids: widget.getSwiperList![index].vodId,
            typeId: widget.typeId ?? 0,
          );
        }));
      },
    );
  }
}
