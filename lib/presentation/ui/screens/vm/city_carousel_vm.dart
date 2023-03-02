import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/core/manager/manager.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';

final carouselCityProvider =
    StateNotifierProvider.autoDispose<CarouselCityNotifier, CarouselCityState>(
        (ref) {
  return CarouselCityNotifier(ref);
});

class CarouselCityState extends Equatable {
  final List<GetCityWeatherRes> carouselCityModel;
  final bool isLoading;
  const CarouselCityState(
      {required this.carouselCityModel, required this.isLoading});
  factory CarouselCityState.initial() {
    return const CarouselCityState(carouselCityModel: [], isLoading: true);
  }

  CarouselCityState copyWith({
    List<GetCityWeatherRes>? carouselCityModel,
    bool? isLoading,
  }) =>
      CarouselCityState(
          carouselCityModel: carouselCityModel ?? this.carouselCityModel,
          isLoading: isLoading ?? this.isLoading);
  @override
  List<Object?> get props => [carouselCityModel, isLoading];
}

class CarouselCityNotifier extends StateNotifier<CarouselCityState> {
  final Ref ref;
  CarouselCityNotifier(this.ref) : super(CarouselCityState.initial());

  void getCities() async {
    try {
      final res =
          await ref.read(managerServiceProvider).getCityWeather(6.4500, 3.4000);
      state = state.copyWith(
          carouselCityModel: [...state.carouselCityModel, res],
          isLoading: false);
      final res1 =
          await ref.read(managerServiceProvider).getCityWeather(9.0556, 7.4914);
      state = state.copyWith(
          carouselCityModel: [...state.carouselCityModel, res1],
          isLoading: false);
      final res2 =
          await ref.read(managerServiceProvider).getCityWeather(7.3964, 3.9167);
      state = state.copyWith(
          carouselCityModel: [...state.carouselCityModel, res2],
          isLoading: false);
    } catch (e) {
      throw e.toString();
    }
  }

  void addCity(double lat, double lon) async {
    try {
      final res =
          await ref.read(managerServiceProvider).getCityWeather(lat, lon);
      state = state.copyWith(
          carouselCityModel: [...state.carouselCityModel, res],
          isLoading: false);
    } catch (e) {
      throw e.toString();
    }
  }

  void revoveCity(target) {
    state.carouselCityModel.remove(target);

    state = state.copyWith(carouselCityModel: [
      for (final step in state.carouselCityModel)
        if (step == target) state.carouselCityModel.removeLast() else step,
    ]);
  }
  // void revoveCity(String target) {
  //   state.carouselCityModel.remove(target);

  //   state = state.copyWith(carouselCityModel: [
  //     for (final step in state.carouselCityModel)
  //       if (step == target) state.carouselCityModel.removeLast() else step,
  //   ]);
  // }
}
