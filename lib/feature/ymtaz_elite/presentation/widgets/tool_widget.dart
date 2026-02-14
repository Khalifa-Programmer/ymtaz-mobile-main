import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/spacing.dart';

class EliteToolSelectionType extends StatelessWidget {
  EliteToolSelectionType(
      {super.key,
      this.isVideo = false,
      required this.name,
      required this.description,
      required this.onSelected});

  bool isVideo = false;
  String name;
  String description;
  Null Function() onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      padding: EdgeInsets.all(17.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: appColors.primaryColorYellow),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                  isVideo ? AppAssets.video : AppAssets.advisories),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(5.h),
                    Text(description),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(15.h),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                onSelected();
              },
              color: appColors.primaryColorYellow,
              child: Text(
                "اطلب الان",
                style:
                    TextStyles.cairo_12_bold.copyWith(color: appColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
