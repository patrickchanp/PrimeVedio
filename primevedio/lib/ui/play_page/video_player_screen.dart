import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:primevedio/http/http_options.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/model/video_detail_model.dart';
import 'package:primevedio/ui/play_page/video_detail.dart';
import 'package:primevedio/utils/log_util.dart';
import 'package:video_player/video_player.dart';

const String VIDEO_URL = 'https://www.runoob.com/try/demo_source/mov_bbb.mp4';

class VideoPlayerScreen extends StatefulWidget {
  final int ids;
  const VideoPlayerScreen({Key? key, required this.ids}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final GlobalKey<_VideoPlayerScreenState> vodPlayerKey = GlobalKey();
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayerFuture;
  VideoDetailContent? getVideoDetail;
  List? episode;
  int _currentIndex = 0;
  void changeIndex() {
    setState(() {
      _currentIndex = key.currentState!.currentIndex;
    });
  }

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
            LogUtils.printLog(
                '${episode!.map((e) => e[1]).toList()[_currentIndex]}');
            // episode!.isNotEmpty
            //     ? VideoPlayerController.network(
            //         '${episode!.map((e) => e[1]).toList()}')
            //     : VideoPlayerController.network(VIDEO_URL);
          }
          // LogUtils.printLog('${episode!.map((e) => e[1]).toList()}');
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        // VideoPlayerController.network(
        // '${episode!.map((e) => e[1]).toList()[_currentIndex]}');
        VideoPlayerController.network(VIDEO_URL);
    _controller.setLooping(true);
    _currentIndex = 0;
    _initializeVideoPlayerFuture = _controller.initialize();
    _getVideoDetail();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                // aspectRatio: _controller.value.aspectRatio,
                aspectRatio: 16 / 9,
                child: VideoPlayer(_controller),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        RaisedButton(
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          },
        ),
      ],
    );
  }
}
