import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/video_detail_model.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

class VideoDetail extends StatefulWidget {
  final int ids;

  const VideoDetail({Key? key, required this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  List<VideoDetailContent>? getVideoDetail = [];
  late List episode;

  _getVideoDetail() async {
    Map<String, Object> params = {
      'ac': 'detail',
      'ids': widget.ids,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoDetailModel model = VideoDetailModel.fromJson(value);
      setState(() {
        getVideoDetail = model.list;
        if (getVideoDetail!
            .map((e) => e.vodPlayUrl)
            .toList()[0]
            .split('#')
            .isNotEmpty) {
          episode = List.generate(
              getVideoDetail!
                  .map((e) => e.vodPlayUrl)
                  .toList()[0]
                  .split('#')
                  .length, (index) {
            return index;
          });
        } else {
          return;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getVideoDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoDetail!.isNotEmpty
        ? ListView(children: [
            Container(
              color: UIData.primaryColor,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText.normalText('选集', color: Colors.white),
                        const Icon(
                          MyIcons.sortIcon,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: UIData.spaceSizeHeight40,
                        child: episode.length != 1
                            ? ListView(
                                scrollDirection: Axis.horizontal,
                                children: episode
                                    .map((e) => Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: UIData.spaceSizeWith4),
                                        color: Colors.white,
                                        width: UIData.spaceSizeWith100,
                                        child: Center(
                                          child: CommonText.normalText(
                                              '第${e + 1}集',
                                              color: Colors.black),
                                        )))
                                    .toList(),
                              )
                            : Center(
                                child: CommonText.mainTitle('暂无资源'),
                              ),
                      ),
                    ),
                    CommonText.normalText('介绍\n', color: Colors.white),
                    CommonText.titleText(
                      '名称：${getVideoDetail!.map((e) => e.vodName).toList()[0]}\n导演：${getVideoDetail!.map((e) => e.vodDirector).toList()[0]}',
                    ),
                    CommonText.titleText(
                        '主演：${getVideoDetail!.map((e) => e.vodActor).toList()[0]}',
                        overflow: TextOverflow.clip),
                    CommonText.titleText(
                        '年代：${getVideoDetail!.map((e) => e.vodYear).toList()[0]}\n语言：${getVideoDetail!.map((e) => e.vodLang).toList()[0]}'),
                    CommonText.titleText(
                        '介绍：${getVideoDetail!.map((e) => e.vodContent).toList()[0]}\n',
                        overflow: TextOverflow.clip)
                  ],
                ),
              ),
            ),
          ])
        : Container(
            color: UIData.primaryColor,
            child: Center(
              child: CommonText.mainTitle('加载中'),
            ));
  }
}
