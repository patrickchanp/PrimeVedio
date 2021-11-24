import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/common/indicator.dart';
import 'package:primevedio/ui/play_page/video_player_screen.dart';
import 'package:primevedio/ui/play_page/video_detail.dart';
import 'package:primevedio/utils/ui_data.dart';

class PlayPage extends StatefulWidget {
  final int ids;
  const PlayPage({Key? key, required this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIData.primaryColor,
      appBar: AppBar(
        // 修改返回的icon
        // leading: IconButton(
        //   icon: const Icon(Icons.android_rounded),
        //   onPressed: () => {Navigator.of(context).pop('刷新')},
        // ),
        backgroundColor: UIData.primaryColor,
      ),
      body: PlayVideoContent(ids: widget.ids),
    );
  }
}

class PlayVideoContent extends StatefulWidget {
  final int ids;
  const PlayVideoContent({Key? key, required this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PlayVideoContentState();
}

class _PlayVideoContentState extends State<PlayVideoContent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: UIData.spaceSizeHeight228,
        // color: Colors.red,
        child: const VideoPlayerScreen(),
      ),
      Expanded(
        child: DetailContent(ids: widget.ids),
      )
    ]);
  }
}

class DetailContent extends StatefulWidget {
  final int ids;
  const DetailContent({Key? key, required this.ids}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            ),
            const Text('test')
          ],
        ))
      ],
    );
  }
}
