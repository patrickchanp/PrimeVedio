import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:primevedio/utils/log_util.dart';

import 'http_options.dart';

class HttpUtil {
  static const String GET = 'get';
  static const String POST = 'post';

  static Future<Response?> request(
    Dio dio,
    String url,
    String method,
    Function callBack, {
    required Map<String, dynamic> params,
    required Function errorCallBack,
  }) async {
    try {
      Response response;
      if (method == GET) {
        //GET请求
        if (params.isNotEmpty) {
//          FormData formData = new FormData.from(params);
          if (HttpOptions.isInDebugMode) {
            _urlPrint(
              url,
              params: params,
              jsonData: '',
            );
          }
          response = await dio.get(url, queryParameters: params);
        } else {
          if (HttpOptions.isInDebugMode) {
            _urlPrint(url, params: {});
          }
          response = await dio.get(url);
        }
        // String responseData = json.encode(response.data).trim();
        // if ((responseData?.length ?? 0) > 10000) {
        //   //避免数据过大，打印后会异常
        //   LogUtils.printLog(
        //       'response data: ' + responseData.substring(0, 10000));
        // } else {
        //   LogUtils.printLog('response data: ' + responseData);
        // }
        int? statusCode = response.statusCode;
        LogUtils.printLog('status' + response.statusCode.toString(), tag: '');
        if (statusCode != 200) {
          String errorMessage = '请求出错，状态码' + statusCode.toString();
          LogUtils.printLog('errorLog:$errorMessage', tag: '');
          return null;
        }
        return response;
      }
    } on DioError catch (e) {
      LogUtils.printLog(e.message);
    }
  }

  static void _urlPrint(String url,
      {required Map<String, dynamic> params, String jsonData = ''}) {
    String urlStr;
    StringBuffer sb = StringBuffer();
    sb.write(HttpOptions.baseUrl);
    sb.write(url + '?');
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        sb.write(key + '=' + value.toString() + '&');
      });
    } else if (jsonData.isNotEmpty) {
      sb.write(jsonData);
    }
    urlStr = sb.toString();
    if ((params.isNotEmpty)) {
      urlStr = urlStr.substring(0, urlStr.length - 1);
    }
    LogUtils.printLog("url:  $urlStr", tag: '');
  }
}
