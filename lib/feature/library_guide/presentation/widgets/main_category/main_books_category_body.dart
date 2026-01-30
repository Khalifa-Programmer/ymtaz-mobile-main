import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../data/model/books_response.dart';
import '../../sub_category_books.dart';

class MainBooksBody extends StatelessWidget {
  const MainBooksBody({super.key, required this.data});

  final List<BooksMainCategory> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const NodataFound()
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.85,
                crossAxisCount: 2,
                crossAxisSpacing: 8.0.w,
                mainAxisSpacing: 8.0.h,
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0.h),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _buildMainCategoryItem(context, index);
              },
            ),
          );
  }

  Widget _buildMainCategoryItem(BuildContext context, int index) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var data = this.data[index].subCategories;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubCategoryBooks(
                      data: data!,
                      title: this.data[index].name!,
                    )));
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: index % 4 < 2
                    ? appColors.primaryColorYellow
                    : appColors.blue90,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.digital ?? '',
                  width: 24.sp,
                  height: 24.sp,
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
                verticalSpace(4.h),
                Text(data[index].name!.trim(),
                    textAlign: TextAlign.start,
                    style: TextStyles.cairo_11_bold.copyWith(
                      color: appColors.blue100,
                    )),
                verticalSpace(4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: appColors.primaryColorYellow.withOpacity(0.5)),
                  child: Text("${data[index].subCategories!.length} كتاب",
                      style: TextStyles.cairo_11_semiBold.copyWith(
                        color: appColors.blue90,
                      )),
                ),
              ],
            ),
            Container(
              width: 4,
            ),
          ],
        ),
      ),
    );
  }
}
