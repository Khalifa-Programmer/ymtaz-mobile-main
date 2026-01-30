import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/day_work_custom.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alerts.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';

class WorkingHoursAppointments extends StatelessWidget {
  const WorkingHoursAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقيت العمل للمواعيد',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
        centerTitle: true,
      ),
      body: BlocListener<OfficeProviderCubit, OfficeProviderState>(
        listenWhen: (previous, current) => current is LoadingPostWorkingHours,
        listener: (context, state) {
          state.whenOrNull(
            loadingPostWorkingHours: () {
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
                      const Text("جاري حفظ مواعيد العمل"),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomExpansionTile(
                  dayName: "الاحد",
                  dayNum: "1",
                  service: "1",
                  isSwitched: context.read<OfficeProviderCubit>().isSunday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  service: "1",
                  dayName: "الاثنين",
                  dayNum: "2",
                  isSwitched: context.read<OfficeProviderCubit>().isMonday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  service: "1",
                  dayName: "الثلاثاء",
                  dayNum: "3",
                  isSwitched: context.read<OfficeProviderCubit>().isTuesday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  service: "1",
                  dayName: "الاربعاء",
                  dayNum: "4",
                  isSwitched: context.read<OfficeProviderCubit>().isWednesday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  service: "1",
                  dayName: "الخميس",
                  dayNum: "5",
                  isSwitched: context.read<OfficeProviderCubit>().isThursday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  dayName: "الجمعة",
                  service: "1",
                  dayNum: "6",
                  isSwitched: context.read<OfficeProviderCubit>().isFriday,
                ),
                verticalSpace(10.sp),
                CustomExpansionTile(
                  service: "1",
                  dayName: "السبت",
                  dayNum: "7",
                  isSwitched: context.read<OfficeProviderCubit>().isSaturday,
                ),
                verticalSpace(50.sp),
                CustomButton(
                  onPress: () {
                    if (context
                        .read<OfficeProviderCubit>()
                        .validateWorkingDays()) {
                      context.read<OfficeProviderCubit>().storeWorkingDays();
                    } else {
                      AppAlerts.showAlert(
                          context: context,
                          message: 'يجب اختيار يوم على الاقل و حفظ مواعيده',
                          buttonText: 'حسنا',
                          type: AlertType.error);
                    }
                  },
                  title: 'احفظ الايام',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
