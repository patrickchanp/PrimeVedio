import 'package:dio/dio.dart';
import 'package:primevedio/utils/log_util.dart';

class HttpUtil2 {
  static void test() async {
    Dio dio = Dio();
    Response response =
        await dio.get("http://dy.51isu.com:11801/api.php/provide/vod/");
    LogUtils.printLog(response.data);
  }
}
