import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weather_app/core/services/api/models/city_list.dart';
import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/ui/screens/vm/weather_vm.dart';
import 'package:weather_app/presentation/values/values.dart';

class CityDropDownList extends HookConsumerWidget {
  const CityDropDownList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityName = useState('Lagos');
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        barrierColor: const Color(0xFF757575),
        backgroundColor: AppColors.primaryBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) => CitiesDropDown(
          cityName: cityName,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Select City:',
            style: AppText.primaryHeaderText(
              context,
              AppColors.primaryBgColor,
              18.sp,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                cityName.value,
                style: AppText.primaryBodyText(
                  context,
                  AppColors.primaryBgColor,
                  16.sp,
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryBgColor,
                size: 30.sp,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CitiesDropDown extends HookConsumerWidget {
  final ValueNotifier<String> cityName;
  const CitiesDropDown({
    required this.cityName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
      height: 800.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                'Select City',
                style:
                    AppText.primaryHeaderText(context, AppColors.kWhite, 20.sp),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.close,
                  color: AppColors.kWhite,
                  size: 30.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          ListView.separated(
            shrinkWrap: true,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final item = cities[index];
              return GestureDetector(
                onTap: () {
                  cityName.value = item.name;
                  ref
                      .read(weatherProvider.notifier)
                      .getWeather(item.lat, item.lng);
                  Navigator.of(context).pop();
                },
                child: Text(
                  item.name,
                  style:
                      AppText.primaryBodyText(context, AppColors.kWhite, 16.sp),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
