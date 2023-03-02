import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/core/services/api/models/res/get_city_wether_res.dart';
import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/values/values.dart';

class CurrentWeatherExtraDetails extends StatelessWidget {
  final GetCityWeatherRes data;
  const CurrentWeatherExtraDetails({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 20.h, left: 24.w, right: 24.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 2.r,
            spreadRadius: 2.r,
            offset: Offset(0.h, 1.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              FaIcon(
                FontAwesomeIcons.wind,
                size: 20.sp,
              ),
              Text(
                '${data.wind!.speed}',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  16.sp,
                ),
              ),
              Text(
                'Wind',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  12.sp,
                ),
              ),
            ],
          ),
          Column(
            children: [
              FaIcon(
                FontAwesomeIcons.cloud,
                size: 20.sp,
              ),
              Text(
                '${data.visibility!.floor()}',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  16.sp,
                ),
              ),
              Text(
                'Humidity',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  12.sp,
                ),
              ),
            ],
          ),
          Column(
            children: [
              FaIcon(
                FontAwesomeIcons.temperatureLow,
                size: 20.sp,
              ),
              Text(
                '${data.main!.humidity}',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  16.sp,
                ),
              ),
              Text(
                'Visibility',
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
