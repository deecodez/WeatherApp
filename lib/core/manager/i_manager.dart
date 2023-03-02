import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';

abstract class IManager {
  Future<GetCityWeatherRes> getCityWeather(double lat, double lon);
  // Future<GetCityWeatherRes> getCityWeather(
  //     [double lat = 0.0, double lon = 0.0]);
}
