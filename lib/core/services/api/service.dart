import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:weather_app/core/services/api/api_interceptor.dart';
import 'package:weather_app/core/services/api/error_interceptor.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';
import 'package:weather_app/core/services/global/constant.dart';

final serviceProvider = Provider<Service>((ref) {
  return Service(ref.read);
});

final dioProvider = Provider(
  (ref) => Dio(
    BaseOptions(
      receiveTimeout: 100000,
      connectTimeout: 100000,
      baseUrl: Constants.baseApiUrl,
    ),
  ),
);

class Service {
  final Reader _read;
  Service(this._read) {
    _read(dioProvider).interceptors.add(ApiInterceptor());
    _read(dioProvider).interceptors.add(ErrorInterceptor());
    _read(dioProvider).interceptors.add(PrettyDioLogger());
  }

  Future<GetCityWeatherRes> getCityWeather(double lat, double lon) async {
    const url = 'data/2.5/weather';
    final queryParameter = {
      'lat': lat,
      'lon': lon,
      'appid': Constants.apiKey,
    };
    try {
      final response = await _read(dioProvider).get(
        url,
        queryParameters: queryParameter,
      );
      return GetCityWeatherRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data);
        throw e.response!.data;
      } else {
        debugPrint(e.error);
        throw e.error;
      }
    }
  }
  // Future<GetCityWeatherRes> getCityWeather(
  //     [double lat = 0.0, double lon = 0.0]) async {
  //   final url = 'data/2.5/weather?lat=$lat&lon=$lon&appid=${Constants.apiKey}';
  //   try {
  //     final response = await _read(dioProvider).get(url);
  //     return GetCityWeatherRes.fromJson(response.data);
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       debugPrint(e.response!.data);
  //       throw e.response!.data;
  //     } else {
  //       debugPrint(e.error);
  //       throw e.error;
  //     }
  //   }
  // }
}
