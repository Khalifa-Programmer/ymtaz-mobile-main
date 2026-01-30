import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/helpers/extentions.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';

class EditProfileInstructions extends StatelessWidget {
  const EditProfileInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('استكمال البيانات',
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0.sp),
                margin: EdgeInsets.symmetric(
                    vertical: 20.0.sp, horizontal: 20.0.sp),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 9,
                      offset: const Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(AppAssets.attachIcon),
                    SizedBox(height: 20.h),
                    Text(
                      'أبرز المرفقات التي قد تحتاجها لاستكمال ملفك كمقدم خدمة معتمد لدى يمتاز :',
                      textAlign: TextAlign.center,
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.black,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    const InfoRowWidget(
                      iconPath: AppAssets.idAttach,
                      title: 'مطابقة الهوية الوطنية للفرد والممثل النظامي.',
                      description:
                          'التحقق من هويتك يعزز من أمان حسابك ويمنحك الثقة في التعامل.قم بتأكيد هويتك لحماية حسابك',
                    ),
                    verticalSpace(16.h),
                    const InfoRowWidget(
                      iconPath: AppAssets.fileAttach,
                      title: 'مطابقة ترخيص المهنة إن وجد.',
                      description:
                          'مطابقة تراخيصك يمنحك المصداقية اللازمة للتعامل بثقة واحترافية.',
                    ),
                    verticalSpace(16.h),
                    const InfoRowWidget(
                      iconPath: AppAssets.degreeAttach,
                      title:
                          'مطابقة الدرجة العلمية أو المؤهل العلمي عند الطلب.',
                      description:
                          'شهادتك العلمية هي دليل على خبرتك، أرفقها لتعزيز فرصك',
                    ),
                    verticalSpace(16.h),
                    const InfoRowWidget(
                      iconPath: AppAssets.companyAttach,
                      title: 'مطابقة السجل التجاري للشركات والمنشآت.',
                      description:
                          'تقديم ترخيص الشركة يعزز من مكانتك ويثبت جدارتك في السوق.',
                    ),
                    verticalSpace(16.h),
                    const Divider(
                      color: appColors.grey5,
                      thickness: 0.3,
                    ),
                    verticalSpace(16.h),
                    const InfoRowWidgetWithDescription(
                      iconPath: AppAssets.timeAttach,
                      title: 'تفعيل الحساب',
                      description: '''
• الظهور كمقدم خدمة في الدليل الرقمي يتم بشكل مجاني.\n
• كافة بيانات ووثائق العضوية تُعامل بعناية وسرية تامة وفقًا لما تقتضيه الأنظمة السعودية.\n
• كافة ملفات العضوية تُمنح العناية والدراسة اللازمة من قبل الإدارة المختصة قبل تفعيلها.\n
• في حال وجود أي ملاحظة على أي ملف، سيتم تفعيل خاصية التحديث مرة أخرى لطالب العضوية لتلافي الملاحظات إن وجدت.
''',
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                child: CupertinoButton(
                  color: appColors.primaryColorYellow,
                  child: Text(
                    'استكمال البيانات',
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.white,
                    ),
                  ),
                  onPressed: () => context.pushNamed(Routes.editProvider),
                ),
              ),
              verticalSpace(70.h)
            ],
          ),
        ));
  }
}

class InfoRowWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const InfoRowWidget({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title,
            maxLines: 10,
            style: TextStyles.cairo_11_bold.copyWith(
              color: appColors.blue100,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoRowWidgetWithDescription extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const InfoRowWidgetWithDescription({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.cairo_12_bold.copyWith(
                  color: appColors.blue100,
                ),
              ),
              SizedBox(height: 10.h), // Adjust vertical space
              Text(
                description,
                maxLines: 20,
                textAlign: TextAlign.start,
                style: TextStyles.cairo_10_semiBold.copyWith(
                  color: appColors.grey20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
