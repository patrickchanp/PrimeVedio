import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/video_detail_model.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/log_util.dart';
import 'package:primevedio/utils/my_icons.dart';
import 'package:primevedio/utils/ui_data.dart';

class VideoDetail extends StatefulWidget {
  final int ids;

  const VideoDetail({
    Key? key,
    required this.ids,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  VideoDetailContent? getVideoDetail;
  List? episode;

  _getVideoDetail() async {
    Map<String, Object> params = {
      'ac': 'detail',
      'ids': widget.ids,
    };
    HttpUtil.request(HttpOptions.baseUrl, HttpUtil.GET, params: params)
        .then((value) {
      VideoDetailModel model = VideoDetailModel.fromJson(value);
      if (model.list.isNotEmpty) {
        setState(() {
          getVideoDetail = model.list[0];
          String vodUrl = getVideoDetail!.vodPlayUrl;
          if (vodUrl.isNotEmpty) {
            episode = vodUrl.split('#').map((e) => e.split('\$')).toList();
          }
          // LogUtils.printLog('$episode');
          // LogUtils.printLog('${episode!.map((e) => e[0]).toList()}');
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    episode;
    _getVideoDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return getVideoDetail != null
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
                        child: getVideoDetail!.vodPlayUrl.isNotEmpty
                            ? ListView.builder(
                                itemCount: episode!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: UIData.spaceSizeWith4),
                                        color: Colors.white,
                                        width: UIData.spaceSizeWith110,
                                        child: CommonText.normalText(
                                            episode!.isNotEmpty
                                                ? '${episode!.map((e) => e[0]).toList()[index]}'
                                                : '',
                                            color: Colors.black,
                                            overflow: TextOverflow.fade)),
                                    onTap: () {
                                      setState(() {});
                                    },
                                  );
                                },
                              )
                            : Center(
                                child: CommonText.mainTitle('暂无资源'),
                              ),
                      ),
                    ),
                    CommonText.normalText('介绍\n', color: Colors.white),
                    CommonText.titleText(
                      '名称：${getVideoDetail!.vodName}\n导演：${getVideoDetail!.vodDirector}',
                    ),
                    CommonText.titleText('主演：${getVideoDetail!.vodActor}',
                        overflow: TextOverflow.clip),
                    CommonText.titleText(
                        '年代：${getVideoDetail!.vodYear}\n语言：${getVideoDetail!.vodLang}'),
                    CommonText.titleText('介绍：${getVideoDetail!.vodContent}\n',
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
