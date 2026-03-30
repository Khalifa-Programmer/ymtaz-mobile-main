import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/colors.dart';
import '../../../../config/themes/styles.dart';
import '../../../../core/widgets/custom_button.dart';

class AdvisoryRatingDialog extends StatefulWidget {
  const AdvisoryRatingDialog({Key? key}) : super(key: key);

  @override
  State<AdvisoryRatingDialog> createState() => _AdvisoryRatingDialogState();
}

class _AdvisoryRatingDialogState extends State<AdvisoryRatingDialog> {
  double _rating = 0.0;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "تقييم تجربتك",
              style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
            ),
            verticalSpace(20.h),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: appColors.primaryColorYellow,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            verticalSpace(20.h),
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "تعليقك...",
                hintStyle: TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: appColors.grey5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(color: appColors.grey5),
                ),
              ),
            ),
            verticalSpace(20.h),
            CustomButton(
              onPress: () {
                // Submit rating using _rating and _commentController.text
                Navigator.pop(context, {'rating': _rating, 'comment': _commentController.text});
              },
              title: "إرسال",
              height: 45.h,
              fontSize: 14.sp,
              bgColor: appColors.primaryColorYellow,
            ),
          ],
        ),
      ),
    );
  }

  Widget verticalSpace(double height) => SizedBox(height: height);
}
