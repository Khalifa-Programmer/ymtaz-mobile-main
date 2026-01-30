import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/feature/library_guide/presentation/book_details_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../../layout/services/presentation/widgets/no_data_services.dart';
import '../data/model/books_response.dart';

class SubBooksScreen extends StatelessWidget {
  const SubBooksScreen({super.key, required this.data, required this.title});

  final List<Book> data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: data.isEmpty
          ? const NodataFound()
          : Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
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
            ),
    );
  }

  Widget _buildMainCategoryItem(BuildContext context, int index) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var books = data[index];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BookDetails(data: books, title: data[index].name!),
            ));
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
              width: 4.w,
              height: 70.h,
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
            Icon(
              Icons.menu_book_sharp,
              size: 24.sp,
              color: appColors.primaryColorYellow,
            ),
            horizontalSpace(20.w),
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
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.userAlt,
                        size: 12.sp,
                        color: appColors.grey15,
                      ),
                      horizontalSpace(10.w),
                      Text(data[index].authorName?.trim() ?? "مؤلف غير معروف",
                          textAlign: TextAlign.start,
                          style: TextStyles.cairo_12_semiBold.copyWith(
                            color: appColors.grey15,
                          )),
                    ],
                  ),
                ],
              ),
            ),
            horizontalSpace(24.w),
          ],
        ),
      ),
    );
  }
}
