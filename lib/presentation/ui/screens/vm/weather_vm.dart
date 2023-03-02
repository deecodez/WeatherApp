import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/core/controller/generic_state_notifier.dart';
import 'package:weather_app/core/manager/manager.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';

final weatherProvider = StateNotifierProvider.autoDispose<GetWeatherVM,
    RequestState<GetCityWeatherRes>>(
  (ref) => GetWeatherVM(ref),
);

class GetWeatherVM extends RequestStateNotifier<GetCityWeatherRes> {
  final Manager _manager;

  GetWeatherVM(Ref ref) : _manager = ref.read(managerServiceProvider) {
    //Fetch Lagos weather lag at default
    getWeather(6.4500, 3.4000);
  }

  void getWeather(double lat, double lon) =>
      makeRequest(() => _manager.getCityWeather(lat, lon));
}
