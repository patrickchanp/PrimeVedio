import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';
import 'package:primevedio/video_player/video_player.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late PackageInfo _packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '');
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.primaryColor,
          title: CommonText.dialogText('关于我们', color: Colors.white),
        ),
        backgroundColor: UIData.primaryColor,
        body: Center(
          child: ListView(
            children: [
              SizedBox(
                height: UIData.spaceSizeHeight75,
              ),
              CommonText.aboutText(_packageInfo.appName),
              CommonText.aboutText(_packageInfo.version),
              SizedBox(
                height: UIData.spaceSizeHeight54,
              ),
              CommonText.usText('本软件仅供学习交流\n如有雷同，纯属克隆'),
              // const Center(
              //   // 该组件宽高默认填充父控件，你也可以自己设置宽高
              //   child: VideoPlayerUI.network(
              //     url:
              //         'https://gss3.baidu.com/6LZ0ej3k1Qd3ote6lo7D0j9wehsv/tieba-smallvideo-transcode-crf/60609889_0b5d29ee8e09fad4cc4f40f314d737ca_0.mp4',
              //     title: '示例视频',
              //   ),
              // ),
            ],
          ),
        ));
  }
}
