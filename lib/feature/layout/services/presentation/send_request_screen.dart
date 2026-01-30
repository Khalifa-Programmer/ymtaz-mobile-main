import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../data/model/available_lawyers_for_service_model.dart';
import '../logic/services_cubit.dart';

class SendRequestScreen extends StatelessWidget {
  final List<Lawyer> selectedLawyers;

  SendRequestScreen({required this.selectedLawyers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, "إرسال الطلب"),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(),
              Text(
                "إرسال الطلب للمختارين",
                style: TextStyles.cairo_14_bold,
              ),
              verticalSpace(5.h),
              Text(
                "سيتم إرسال الطلب للمحامين المختارين وسيتم الرد علىطلبكم بعروض الاسعار من قبل المحامين في أقرب وقت ممكن",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.grey15),
              ),
              verticalSpace(40.h),
              Container(
                width: double.infinity,
                child: CupertinoButton(
                  color: appColors.primaryColorYellow,
                  onPressed: () {
                    var serviseCubit = getit<ServicesCubit>();
                    for (int i = 0; i < selectedLawyers.length; i++) {
                      serviseCubit.requestData.fields.add(MapEntry(
                        "lawyer_ids[$i]",
                        selectedLawyers[i].id!,
                      ));
                    }
                    FormData data = serviseCubit.requestData;
                    serviseCubit.requestService(data);
                  },
                  child: Text(
                    "تأكيد الطلب ",
                    style: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.white),
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
