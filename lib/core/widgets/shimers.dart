import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';

Padding loadingWidget() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: appColors.grey10,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 80.w,
                height: 11.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
              ),
              SizedBox(height: 8.h),
              Container(
                width: 80.w,
                height: 11.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
