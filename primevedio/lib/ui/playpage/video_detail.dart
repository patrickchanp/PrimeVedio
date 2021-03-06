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
  final ValueChanged<int> onChange;

  const VideoDetail({
    Key? key,
    required this.ids,
    required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  bool isReverse = false;
  VideoDetailContent? getVideoDetail;
  List episode = [];
  late int _currentIndex;

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
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _getVideoDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (getVideoDetail != null) {
      return ListView(
          padding: EdgeInsets.symmetric(horizontal: UIData.spaceSizeWith16),
          children: [
            Container(
              color: UIData.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText.normalText('??????', color: Colors.white),
                      GestureDetector(
                        child: const Icon(
                          MyIcons.sortIcon,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            isReverse = !isReverse;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      height: UIData.spaceSizeHeight40,
                      child: getVideoDetail!.vodPlayUrl.isNotEmpty
                          ? ListView.builder(
                              itemCount: episode.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: UIData.spaceSizeWith4),
                                      color: _currentIndex != index
                                          ? Colors.white
                                          : UIData.episodeColor,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: UIData.spaceSizeWith24),
                                        child: CommonText.normalText(
                                          episode.isNotEmpty
                                              ? isReverse
                                                  ? '${episode[index][0]}'
                                                  : '${episode.reversed.toList()[index][0]}'
                                              : '',
                                          color: _currentIndex == index
                                              ? UIData.primarySwatch
                                              : Colors.black,
                                        ),
                                      )),
                                  onTap: () {
                                    changeEpisode(index);
                                    widget.onChange(index);
                                  },
                                );
                              },
                            )
                          : Center(
                              child: CommonText.mainTitle('????????????'),
                            ),
                    ),
                  ),
                  CommonText.normalText('??????\n', color: Colors.white),
                  CommonText.titleText(
                    '?????????${getVideoDetail!.vodName}\n?????????${getVideoDetail!.vodDirector}',
                  ),
                  CommonText.titleText('?????????${getVideoDetail!.vodActor}',
                      overflow: TextOverflow.clip),
                  CommonText.titleText(
                      '?????????${getVideoDetail!.vodYear}\n?????????${getVideoDetail!.vodLang}'),
                  CommonText.titleText('?????????${getVideoDetail!.vodContent}\n',
                      overflow: TextOverflow.clip)
                ],
              ),
            ),
          ]);
    } else {
      return Container(
          color: UIData.primaryColor,
          child: Center(
            child: CommonText.mainTitle('?????????'),
          ));
    }
  }

  void changeEpisode(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }
}
