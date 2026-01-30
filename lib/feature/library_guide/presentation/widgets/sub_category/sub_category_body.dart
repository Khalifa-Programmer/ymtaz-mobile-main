import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../layout/account/presentation/guest_screen.dart';
import '../../../data/model/books_response.dart';
import '../../sub_books_screen.dart';

class SubBooksBody extends StatelessWidget {
  const SubBooksBody({super.key, required this.data});

  final List<SubCategory> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const NodataFound()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildMainCategoryItem(context, index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return verticalSpace(10.h);
              },
            ),
          );
  }

  Widget _buildMainCategoryItem(BuildContext context, int index) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var books = data[index].books;
        var userType = CacheHelper.getData(key: "userType");
        if (userType == "client" || userType == "provider") {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SubBooksScreen(data: books ?? [], title: data[index].name!),
              ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GestScreen(),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              // Shadow color
              spreadRadius: 3,
              // Spread radius
              blurRadius: 10,
              // Blur radius
              offset: const Offset(0, 3), // Offset in x and y direction
            ),
          ],
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 60.h,
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? appColors.blue90
                    : appColors.primaryColorYellow,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            horizontalSpace(20.w),
            SvgPicture.asset(
              AppAssets.digital ?? '',
              width: 24.sp,
              height: 24.sp,
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            horizontalSpace(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data[index].name!.trim(),
                      textAlign: TextAlign.start,
                      style: TextStyles.cairo_13_bold.copyWith(
                        color: appColors.blue100,
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: appColors.primaryColorYellow.withOpacity(0.5)),
              child: Text("${data[index].books!.length} كتاب",
                  style: TextStyles.cairo_12_bold.copyWith(
                    color: appColors.blue90,
                  )),
            ),
            horizontalSpace(24.w),
          ],
        ),
      ),
    );
  }
}
