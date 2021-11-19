import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:primevedio/utils/log_util.dart';

import 'http_options.dart';

class HttpUtil {
  static const String GET = 'get';

  static Future request(
    String url,
    String method, {
    Map<String, dynamic>? params,
    String? jsonData,
    Function? errorCallback,
    FormData? formData,
  }) async {
    Dio dio = HttpOptions.dio;
    Response response;
    try {
      if (method == GET) {
        //GET请求
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
        int? statusCode = response.statusCode;
        LogUtils.printLog('status:' + response.statusCode.toString());
        if (statusCode != 200) {
          String errorMsg = '网络请求出错，状态码：' + statusCode.toString();
          LogUtils.printLog('errorMsg: $errorMsg');
          return;
        }
        return json.decode(response.data);
      }
    } on DioError catch (e) {
      LogUtils.printLog(e.message);
    }
    if (HttpOptions.isInDebugMode) _urlPrint(url, params: params);
  }

  static void _urlPrint(String url,
      {Map<String, dynamic>? params, String? jsonData, FormData? formData}) {
    String? urlStr;
    StringBuffer sb = StringBuffer();
    sb.write(HttpOptions.baseUrl);
    sb.write(url + '?');
    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        sb.write(key + '=' + value.toString() + '&');
      });
    } else if (jsonData != null && jsonData.isNotEmpty) {
      sb.write(jsonData);
    } else {
      urlStr = sb.toString();
    }
    if ((params != null && params.isNotEmpty || formData != null)) {
      urlStr = urlStr!.substring(0, urlStr.length - 1);
    }
    LogUtils.printLog("url:  $urlStr");
  }
}
