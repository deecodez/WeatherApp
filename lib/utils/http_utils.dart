import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/utils/connection_util.dart';

import 'http_utils_string.dart';

class HttpUtils {
  static final BaseOptions options = BaseOptions(
    connectTimeout: 999990,
    receiveTimeout: 89250,
  );

  static Dio getInstance() {
    Dio dio = Dio(options)
      ..interceptors.add(PrettyDioLogger(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
          error: true,
          maxWidth: 90));
    return dio;
  }

  static Future<DioError> buildErrorResponse(DioError err) async {
    switch (err.type) {
      case DioErrorType.connectTimeout:
        if (await ConnectionUtils.getActiveStatus()) {
          err.error = HttpErrorStrings.connectionTimeOutActive;
        } else {
          err.error = HttpErrorStrings.connectionTimeOutNotActive;
        }
        break;
      case DioErrorType.sendTimeout:
        err.error = HttpErrorStrings.sendTimeOut;
        break;
      case DioErrorType.receiveTimeout:
        err.error = HttpErrorStrings.receiveTimeOut;
        break;
      case DioErrorType.response:
        if (err.response!.statusCode == HttpStatus.badRequest) {
          err.error = err.response!.data.toString();
        } else if (err.response!.statusCode == HttpStatus.unauthorized) {
          err.error = 'Unauthorized';
        } else {
          err.error = HttpErrorStrings.badResponse;
        }
        break;
      case DioErrorType.cancel:
        err.error = HttpErrorStrings.operationCancelled;
        break;
      case DioErrorType.other:
        if (!await ConnectionUtils.getActiveStatus()) {
          err.error = HttpErrorStrings.defaultMsg;
        } else {
          err.error = HttpErrorStrings.badResponse;
        }
        break;
      default:
        err.error = HttpErrorStrings.unKnown;
        break;
    }

    return err;
  }

  void refreshToken() {}
}
