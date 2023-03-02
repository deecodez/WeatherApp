import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletons/skeletons.dart';
import 'package:weather_app/core/services/api/models/city_list.dart';
import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/ui/screens/vm/city_carousel_vm.dart';

import 'package:weather_app/presentation/values/values.dart';

class CityCarouselView extends StatefulHookConsumerWidget {
  const CityCarouselView({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CityCarouselViewState();
}

class _CityCarouselViewState extends ConsumerState<CityCarouselView> {
  int _current = 0;
  final double height = 150.h;
  final CarouselController _controller = CarouselController();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    ref.read(carouselCityProvider.notifier).getCities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(carouselCityProvider);
    return Column(
      children: [
        GestureDetector(
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
            builder: (context) => Container(
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
                        style: AppText.primaryHeaderText(
                            context, AppColors.kWhite, 20.sp),
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
                          ref
                              .read(carouselCityProvider.notifier)
                              .addCity(item.lat, item.lng);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          item.name,
                          style: AppText.primaryBodyText(
                              context, AppColors.kWhite, 16.sp),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 20.r,
              child: Icon(
                Icons.add,
                size: 20.sp,
                color: AppColors.kWhite,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        vm.isLoading
            ? SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: MediaQuery.of(context).size.width,
                  height: height,
                ),
              )
            : CarouselSlider.builder(
                carouselController: _controller,
                itemCount: vm.carouselCityModel.length,
                itemBuilder: (context, index, realIndex) {
                  final item = vm.carouselCityModel[index];
                  if (vm.carouselCityModel.isEmpty) {
                    return Text('No Text',
                        style: GoogleFonts.poppins(
                            color: AppColors.kWhite, fontSize: 20.sp));
                  }
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0861F7),
                      image: DecorationImage(
                          image: AssetImage("assets/img/bg.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.name!,
                                  style: GoogleFonts.poppins(
                                      color: AppColors.kWhite, fontSize: 20.sp),
                                ),
                                Text(
                                  '${item.main!.temp!.round()} °C',
                                  style: GoogleFonts.poppins(
                                      color: AppColors.kWhite, fontSize: 50.sp),
                                ),
                              ],
                            ),
                            vm.carouselCityModel.length == 1
                                ? const SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(carouselCityProvider.notifier)
                                          .revoveCity(item);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 20.sp,
                                      color: AppColors.kWhite,
                                    )),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    autoPlay: vm.carouselCityModel.length == 1 ? false : true,
                    enlargeCenterPage: false,
                    autoPlayInterval: const Duration(seconds: 7),
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            vm.carouselCityModel,
            // item,
            (index, url) {
              return Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? const Color(0xFF2E5BFF)
                        : const Color.fromRGBO(0, 0, 0, 0.4)),
              );
            },
          ),
        ),
      ],
    );
  }
}
