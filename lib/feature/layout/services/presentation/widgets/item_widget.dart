import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';

class ItemCardWidget extends StatelessWidget {
  ItemCardWidget(
      {super.key,
      required this.index,
      required this.name,
      required this.total,
      this.description,
      this.iconPath,
      required this.id,
      required this.onPressed});

  int index;

  String name;

  String? description;

  String total;
  int id;
  String? iconPath;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        decoration: BoxDecoration(
          color: appColors.white,
          border: Border.all(color: appColors.grey2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4.h,
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? appColors.blue90
                      : appColors.primaryColorYellow,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.r),
                    bottomRight: Radius.circular(15.r),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        iconPath ?? AppAssets.advisories,
                        width: 24.sp,
                        height: 24.sp,
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    name,
                                    textAlign: TextAlign.start,
                                    style: TextStyles.cairo_13_bold.copyWith(
                                      color: appColors.blue100,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12.sp,
                                  color: appColors.blue100,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            description == null
                                ? SizedBox()
                                : Text(
                                    description!,
                                    textAlign: TextAlign.start,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyles.cairo_12_semiBold.copyWith(
                                      color: appColors.grey15,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
