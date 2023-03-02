import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.forEach((k, v) => debugPrint('$k: $v'));

    log("queryParameters:");
    options.queryParameters.forEach((k, v) => debugPrint('$k: $v'));
    if (options.data != null) {
      log("Body: ${options.data}");
    }
    debugPrint(

        // ignore: unnecessary_null_comparison
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    return super.onRequest(options, handler);
  }
}

@override
Future onResponse(Response response, ResponseInterceptorHandler handler) async {
  debugPrint("Headers:");
  response.headers.forEach((k, v) => debugPrint('$k: $v'));
  debugPrint("Response: ${response.data}");
  debugPrint("<-- END HTTP");
  return handler.next(response);
}
