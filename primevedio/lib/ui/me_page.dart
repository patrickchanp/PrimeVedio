import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevedio/http/http_util.dart';
import 'package:primevedio/http/http_util2.dart';
import 'package:primevedio/utils/log_util.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('test'),
        RaisedButton(onPressed: () => HttpUtil2.test()
            // getRequestData1();
            )
      ],
    );
  }

  void getRequestData1() async {
    Dio dio = Dio();
    String url = "http://dy.51isu.com:11801/api.php/provide/vod/";
    Response response = await dio.get(url);
    // .then((value) => value.data)
    // .catchError((e) => print(e));
    var data = response.data;
    LogUtils.printLog(data);
  }

  void getRequestData2() async {
    Dio dio = Dio();
    String url = "http://dy.51isu.com:11801/api.php/provide/vod/";
    Response response = await dio.get(url);
    // .then((value) => value.data)
    // .catchError((e) => print(e));
    var data = response.data;
    LogUtils.printLog(data);
  }
}
