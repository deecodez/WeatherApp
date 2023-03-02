import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

import 'package:weather_app/core/services/api/geolocator_service.dart';

import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/ui/screens/vm/weather_vm.dart';
import 'package:weather_app/presentation/ui/widgets/city_carousel_view.dart';
import 'package:weather_app/presentation/ui/widgets/city_dropdown_list.dart';
import 'package:weather_app/presentation/ui/widgets/current_weather_detail.dart';
import 'package:weather_app/presentation/ui/widgets/current_weather_extra_detail.dart';
import 'package:weather_app/presentation/ui/widgets/retry_widget.dart';
import 'package:weather_app/presentation/values/values.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(weatherProvider);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 2.0,
        actions: [
          GestureDetector(
            onTap: () async {
              final position = await GeolocatorService.getUserLocation();
              ref
                  .read(weatherProvider.notifier)
                  .getWeather(position.latitude, position.longitude);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 21.w),
              child: Icon(
                Icons.location_on,
                color: AppColors.kWhite,
                size: 25.sp,
              ),
            ),
          )
        ],
        title: Text(
          'Weather App',
          style: AppText.primaryHeaderText(
            context,
            AppColors.kWhite,
            25.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(top: 10.h, left: 21.w, right: 21.w),
          children: [
            Column(
              children: [
                const CityDropDownList(),
                const Divider(),
                SizedBox(height: 10.h),
                const CityCarouselView(),
                const Divider(),
                SizedBox(height: 20.h),
                vm.when(
                  success: (data) {
                    return Column(
                      children: [
                        Text(
                          'Current Weather',
                          style: AppText.primaryHeaderText(
                            context,
                            AppColors.primaryBgColor,
                            20.sp,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CurrentWeatherDetails(data: data!),
                        SizedBox(height: 40.h),
                        CurrentWeatherExtraDetails(data: data),
                      ],
                    );
                  },
                  error: (Object error, StackTrace? stackTrace) {
                    return RetryWidget(
                      errorText: error.toString(),
                      onTap: () => ref.refresh(weatherProvider),
                    );
                  },
                  loading: () {
                    return SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: MediaQuery.of(context).size.width,
                        height: 300.h,
                      ),
                    );
                  },
                  idle: () {
                    return SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: MediaQuery.of(context).size.width,
                        height: 300.h,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
