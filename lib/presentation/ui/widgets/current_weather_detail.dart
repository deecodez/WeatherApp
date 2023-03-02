import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';
import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/components/get_weather_icon.dart';
import 'package:weather_app/presentation/components/string_extension.dart';
import 'package:weather_app/presentation/values/values.dart';

class CurrentWeatherDetails extends StatelessWidget {
  final GetCityWeatherRes data;
  const CurrentWeatherDetails({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w, bottom: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              data.name!,
              style: AppText.primaryHeaderText(
                context,
                AppColors.kWhite,
                25.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getWeatherIcon(data.weather![0].id!),
                    style: AppText.primaryHeaderText(
                      context,
                      AppColors.primaryBgColor,
                      50.sp,
                    ),
                  ),
                  FittedBox(
                    child: SizedBox(
                      width: 200.w,
                      child: Text(
                        data.weather![0].description!.capitalize(),
                        style: AppText.primaryBodyText(
                          context,
                          AppColors.kWhite,
                          18.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${data.main!.temp!.round()} °C',
                    style: AppText.primaryHeaderText(
                      context,
                      AppColors.kWhite,
                      30.sp,
                    ),
                  ),
                  Text(
                    'Feels like ${data.main!.feelsLike!.round()}°',
                    style: AppText.primaryHeaderText(
                      context,
                      AppColors.kWhite,
                      14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Align(
            alignment: Alignment.center,
            child: Text(
              getMessage(data.main!.temp!.toInt()),
              style: AppText.primaryHeaderText(
                context,
                AppColors.kWhite,
                25.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
