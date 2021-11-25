import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/common/common_video_player.dart';
import 'package:primevedio/common/indicator.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/video_detail_model.dart';
import 'package:primevedio/ui/playpage/video_detail.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:video_player/video_player.dart';

import 'guess_like.dart';

class PlayPage extends StatefulWidget {
  final int ids;
  final int typeId;
  const PlayPage({Key? key, required this.ids, required this.typeId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  VideoPlayerController? _controller;
  List videoUrl = [];
  VideoDetailContent? getVideoDetail;

  void getVideoByIndex(int index) {
    _controller?.dispose();
    _controller = VideoPlayerController.network(videoUrl[index][1])
      ..initialize()
      ..addListener(() {
        setState(() {});
      })
      ..play();
  }

  _getVideoUrl() async {
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
          String vodInfo = getVideoDetail!.vodPlayUrl;
          if (vodInfo.isNotEmpty) {
            videoUrl = vodInfo.split('#').map((e) => e.split('\$')).toList();
            getVideoByIndex(0);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _getVideoUrl();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller!.dispose();
    super.dispose();
  }

  Widget _buildDetailContent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: UIData.spaceSizeHeight18),
          color: UIData.primaryColor,
          child: TabBar(
            indicator: StubTabIndicator(color: UIData.primarySwatch),
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: UIData.fontSize20,
            ),
            tabs: const [
              Tab(
                text: '详情',
              ),
              Tab(
                text: '猜你喜欢',
              ),
            ],
            controller: _tabController,
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            VideoDetail(
              ids: widget.ids,
              onChange: (index) => getVideoByIndex(index),
            ),
            GuessLike(
              typeId: widget.typeId,
            ),
          ],
        ))
      ],
    );
  }

  Widget _playVideoContent() {
    return Column(children: [
      SizedBox(
        height: UIData.spaceSizeHeight228,
        child: videoUrl.isNotEmpty
            ? CommonVideoPlayer(
                videoPlayerController: _controller,
              )
            : Container(),
      ),
      Expanded(
        child: SizedBox(
          height: UIData.spaceSizeHeight228,
          child: _buildDetailContent(),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.primaryColor,
      appBar: AppBar(
        backgroundColor: UIData.primaryColor,
      ),
      body: _playVideoContent(),
    );
  }
}
