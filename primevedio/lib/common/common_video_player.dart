import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CommonVideoPlayer extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  const CommonVideoPlayer({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  _CommonVideoPlayerState createState() => _CommonVideoPlayerState();
}

class _CommonVideoPlayerState extends State<CommonVideoPlayer> {
  late Future _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // widget.videoPlayerController!.setLooping(true);
    _initializeVideoPlayerFuture = widget.videoPlayerController!.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    // widget.videoPlayerController!.dispose();
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
                aspectRatio: widget.videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(widget.videoPlayerController!),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        ElevatedButton(
          child: Icon(
            widget.videoPlayerController!.value.isPlaying == false
                ? Icons.play_arrow
                : Icons.pause,
          ),
          onPressed: () {
            setState(() {
              if (widget.videoPlayerController!.value.isPlaying) {
                widget.videoPlayerController!.pause();
              } else {
                widget.videoPlayerController!.play();
              }
            });
          },
        ),
      ],
    );
  }
}
