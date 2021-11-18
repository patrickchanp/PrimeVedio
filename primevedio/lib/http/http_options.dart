import 'package:dio/dio.dart';

class HttpOptions {
  static Dio dio = Dio(HttpOptions.getInstance);

  static final BaseOptions _options = BaseOptions(
    baseUrl: HttpOptions.baseUrl,
    connectTimeout: HttpOptions.connectTimeout,
    receiveTimeout: HttpOptions.receiveTimeout,
  );

  static BaseOptions get getInstance {
    return _options;
  }

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); //debug模式执行assert打印log
    return inDebugMode;
  }

  static bool isTrialVersion = false;
  static int connectTimeout = 30000;
  static int receiveTimeout = 30000;
  static String baseUrl = "https://dy.51isu.com:11801/api.php/provide/vod";
}
