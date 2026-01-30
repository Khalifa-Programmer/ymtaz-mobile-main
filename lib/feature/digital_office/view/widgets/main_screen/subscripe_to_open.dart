import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';

class SubscripeToOpenOffice extends StatelessWidget {
  const SubscripeToOpenOffice({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.noAccount,
            width: 200.0,
          ),
          verticalSpace(30.h),
          Text(
            'هل أنت مستعد لتقديم الخدمات؟',
            style: TextStyles.cairo_18_bold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(20.h),
          Text(
            'قم بالاشتراك الآن وامنح عملائك أفضل الخدمات!',
            textAlign: TextAlign.center,
            style:
                TextStyles.cairo_14_semiBold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(30.h),
          CustomButton(
            title: "اشترك الان",
            onPress: () {
              context.pushNamed(Routes.packages);
            },
          ),
        ],
      ),
    );
  }
}
