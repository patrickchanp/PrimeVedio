import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/utils/common_text.dart';
import 'package:primevedio/utils/ui_data.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: UIData.primaryColor,
          title: CommonText.dialogText('关于我们', color: Colors.white),
        ),
        backgroundColor: UIData.primaryColor,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: UIData.spaceSizeHeight75,
              ),
              CommonText.aboutText('Prime_Video\n1.0.0+1'),
              SizedBox(
                height: UIData.spaceSizeHeight54,
              ),
              CommonText.usText('本软件仅供学习交流\n如有雷同，纯属克隆')
            ],
          ),
        ));
  }
}
