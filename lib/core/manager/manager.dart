import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/core/manager/i_manager.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';
import 'package:weather_app/core/services/api/service.dart';

final managerServiceProvider = Provider<Manager>((ref) {
  final managerService = ref.watch(serviceProvider);

  return Manager(managerService);
});

class Manager extends IManager {
  final Service _service;
  Manager(this._service);

  @override
  Future<GetCityWeatherRes> getCityWeather(double lat, double lon) async {
    return await _service.getCityWeather(lat, lon);
  }

  // @override
  // Future<GetCityWeatherRes> getCityWeather(
  //     [double lat = 0.0, double lon = 0.0]) async {
  //   return await _service.getCityWeather(lat, lon);
  // }
}
