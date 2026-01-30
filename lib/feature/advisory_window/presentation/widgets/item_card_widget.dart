import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../layout/account/presentation/guest_screen.dart';

class ItemCardWidget extends StatelessWidget {
  ItemCardWidget(
      {super.key,
      required this.index,
      required this.name,
      required this.total,
      this.description,
      required this.id,
      required this.onPressed});

  int index;

  String name;

  String? description;

  String total;
  int id;

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var userType = CacheHelper.getData(key: 'userType');

        if (userType == 'guest') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GestScreen()));
          return;
        }
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
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
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
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
                        AppAssets.appointments ?? '',
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
