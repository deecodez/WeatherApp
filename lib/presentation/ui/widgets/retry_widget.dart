import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/presentation/components/app_text_theme.dart';
import 'package:weather_app/presentation/values/values.dart';

class RetryWidget extends StatelessWidget {
  final String errorText;
  final void Function() onTap;
  const RetryWidget({
    required this.errorText,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 10.h, bottom: 10.h, left: 20.w, right: 20.w),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(
            errorText,
            style: AppText.primaryBodyText(
              context,
              AppColors.kWhite,
              16.sp,
            ),
          ),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              radius: 30.r,
              child: Icon(
                Icons.refresh,
                size: 30.sp,
                color: AppColors.kWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}
