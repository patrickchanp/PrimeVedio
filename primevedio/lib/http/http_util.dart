// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:primevedio/utils/log_util.dart';
//
// import 'http_options.dart';
//
// class HttpUtil {
//   static const String GET = 'get';
//   static const String POST = 'post';
//
//     Dio dio =  Dio(HttpOptions.getInstance);
//  Future<void> _request(
//       Dio dio,
//       String url,
// String method,
//
//     Function callBack, {
//         Map<String, dynamic>? params,
//         String? jsonData,
//         FormData? formData,
//         var tag,
//       }) async {
//     try {
//       Response response;
//       if (method == GET) {
//         //GET请求
//         if (params != null && params.isNotEmpty) {
// //          FormData formData = new FormData.from(params);
//           if (HttpOptions.isInDebugMode) _urlPrint(url, params: params);
//           response = await dio.get(url, queryParameters: params);
//         } else {
//           if (HttpOptions.isInDebugMode) _urlPrint(url);
//           response = await dio.get(url);
//         }
//       }
//       }
//       // String responseData = json.encode(response.data).trim();
//       // if ((responseData?.length ?? 0) > 10000) {
//       //   //避免数据过大，打印后会异常
//       //   LogUtils.printLog('response data: ' + responseData.substring(0, 10000));
//       // } else {
//       //   LogUtils.printLog('response data: ' + responseData);
//       // }
// //      statusCode = response.statusCode;
// //      LogUtils.printLog('status:' + response.statusCode.toString());
// //      if (statusCode != 200) {
// //        errorMsg = '网络请求出错，状态码：' + statusCode.toString();
// //        if (errorCallBack != null) {
// //          tag == null ? errorCallBack(errorMsg) : errorCallBack(errorMsg, tag);
// //        }
// //        LogUtils.printLog('errorMsg: $errorMsg');
// //        return;
// //      }
//     } on DioError catch (e) {
//       LogUtils.printLog(e?.message ?? "");
//     }
//   }
//
//
//
//
//    void _urlPrint(String url, {Map<String, dynamic>? params, String? jsonData, FormData? formData}) {
//     String? urlStr;
//     StringBuffer sb = new StringBuffer();
//     sb.write(HttpOptions.baseUrl);
//     sb.write(url + '?');
//     if (params != null && params.isNotEmpty) {
//       params.forEach((key, value) {
// //        if (value is String)
//         sb.write(key + '=' + value.toString() + '&');
//       });
//     } else if (jsonData!.isNotEmpty) {
//       sb.write(jsonData);
//     } else {
//       urlStr = sb.toString();
//     }
//     if ((params!.isNotEmpty) ) {
//       urlStr = urlStr!.substring(0, urlStr.length - 1);
//     }
//     LogUtils.printLog("url:  $urlStr");
//   }
//
