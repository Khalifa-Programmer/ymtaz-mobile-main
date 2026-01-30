import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/item_widget.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../core/widgets/webpay_new.dart';
import '../logic/services_cubit.dart';

class ServicesSubTypeScreen extends StatefulWidget {
  ServicesSubTypeScreen({super.key, required this.items});

  final Item items;
  bool selectedServices = false;

  @override
  State<ServicesSubTypeScreen> createState() => _ServicesSubTypeScreenState();
}

class _ServicesSubTypeScreenState extends State<ServicesSubTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ServicesCubit>(),
      child: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          state.whenOrNull(
            requestService: () {
              _showLoadingDialog(context);
            },
            requestServiceSuccess: (data) {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebPaymentScreen(link: data.data!.paymentUrl!)));
            },
            errorServices: (error) {
              Navigator.of(context).pop();
              AppAlerts.showAlert(
                  context: context,
                  message: error ?? "حدث خطأ يرجى اعادة المحاولة",
                  buttonText: LocaleKeys.retry.tr(),
                  type: AlertType.error);
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: buildBlurredAppBar(context, LocaleKeys.services.tr()),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: ListView(
                children: [
                  verticalSpace(20.h),
                  Text(
                    "تخصص الخدمة العام",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "اختر التخصص الذي ترغب فيه للحصول على الخدمات المتاحة",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(20.h),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.items.services!.length,
                    itemBuilder: (context, index) {
                      Service item = widget.items.services![index];
                      return ItemCardWidget(
                        index: index,
                        iconPath: AppAssets.services,
                        name: item.title ?? '',
                        total: "0",
                        id: item.id ?? 0,
                        onPressed: () {
                          getit<ServicesCubit>()
                              .selectServideItem(item, item.ymtazLevelsPrices!);
                          Navigator.of(context)
                              .pushNamed(Routes.servicesReservationScreen);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
                horizontalSpace(16.sp),
                const Text("جاري حجز الخدمة"),
              ],
            ),
          ),
        );
      },
    );
  }
}
