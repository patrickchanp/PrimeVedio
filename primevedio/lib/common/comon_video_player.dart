import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

// const String VIDEO_URL = 'https://www.runoob.com/try/demo_source/mov_bbb.mp4';

class CommonVideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  const CommonVideoPlayer({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late VideoPlayerController _controller;
  late Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller.setLooping(true);
    _controller;
    _initializeVideoPlayerFuture = _controller.initialize();
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
