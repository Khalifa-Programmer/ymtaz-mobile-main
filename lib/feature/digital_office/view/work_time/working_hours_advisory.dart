import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/data/models/work_days_and_times.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/working_hours/days_working_hours.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alerts.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';

class WorkingHoursAdvisory extends StatelessWidget {
  const WorkingHoursAdvisory({super.key, required this.serviceId});

  final int serviceId;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool) {
        context.read<OfficeProviderCubit>().resetWorkingHours();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(getAppBarTitle(),
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
          centerTitle: true,
        ),
        body: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listenWhen: (previous, current) =>
              current is LoadingWorkingHours ||
              current is LoadingPostWorkingHours ||
              current is ErrorWorkingHours ||
              current is ErrorPostWorkingHours ||
              current is LoadedWorkingHours ||
              current is LoadedPostWorkingHours,
          listener: (context, state) {
            state.whenOrNull(
              errorPostWorkingHours: (message) {
                context.pop();
                AppAlerts.showAlert(
                    context: context,
                    message: message,
                    buttonText: "اعادة المحاولة",
                    type: AlertType.error);
              },
              loadedPostWorkingHours: () async {
                context.pop();
                AppAlerts.showAlert(
                    context: context,
                    message: "تم اضافة المواعيد بنجاح",
                    buttonText: "استمرار",
                    type: AlertType.success);
              },
              loadingPostWorkingHours: () {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: appColors.primaryColorYellow,
                    ),
                  ),
                );
              },
            );
          },
          // buildWhen: (previous, current) =>
          // // current is LoadedWorkingHours || current is ErrorWorkingHours,
          builder: (context, state) {
            return getit<OfficeProviderCubit>().workDaysAndTimes == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Animate(
                    effects: [FadeEffect(delay: 200.ms)],
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          DaysWorkingHours(serviceId),
                          context
                                      .read<OfficeProviderCubit>()
                                      .dayIndexSelected ==
                                  0
                              ? Center(
                                  child: Column(
                                    children: [
                                      verticalSpace(150.h),
                                      SvgPicture.asset(
                                        AppAssets.nodatanew,
                                        height: 100.h,
                                      ),
                                      verticalSpace(20.h),
                                      Text("اختر يوم لعرض المواعيد",
                                          style: TextStyles.cairo_14_bold
                                              .copyWith(
                                                  color: appColors.grey15))
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  String getAppBarTitle() {
    switch (serviceId) {
      case 1:
        return "مواقيت العمل للمواعيد";
      case 2:
        return "مواقيت العمل للخدمات";
      case 3:
        return "مواقيت العمل للاستشارات";
      default:
        return "مواقيت العمل";
    }
  }
}

class DayDataContainer extends StatefulWidget {
  const DayDataContainer(
      {super.key,
      required this.day,
      required this.dayIndex,
      required this.serviceId});

  final String day;
  final int dayIndex;
  final int serviceId;

  @override
  State<DayDataContainer> createState() => _DayDataContainerState();
}

class _DayDataContainerState extends State<DayDataContainer> {
  @override
  Widget build(BuildContext context) {
    List<TimeSlot> times = context
        .read<OfficeProviderCubit>()
        .getAdvisoryTimesForDay(widget.dayIndex, widget.serviceId);

    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              color: appColors.grey5,
              thickness: 0.4,
              height: 0.4,
            ),
            Container(
              color: appColors.grey3,
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 4.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تفعيل مواعيد اليوم",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: true,
                      onChanged: (bool value) {},
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: appColors.grey5,
              thickness: 0.4,
              height: 0.4,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
              child: Row(
                children: [
                  Text(
                    "المواعيد ليوم ${widget.day}",
                    style: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.blue100),
                  ),
                  const Spacer(),
                  CupertinoButton(
                      onPressed: () {
                        showMaterialModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              topRight: Radius.circular(20.r),
                            ),
                            side: BorderSide(
                                color: appColors.grey5.withOpacity(0.5)),
                          ),
                          enableDrag: true,
                          backgroundColor: Colors.white,
                          context: context,
                          builder: (context) {
                            return AddTimeSlot(
                              dayIndex: widget.dayIndex,
                              call: () {
                                setState(() {});
                              },
                              serviceId: widget.serviceId,
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle,
                            color: appColors.primaryColorYellow,
                            size: 17.r,
                          ),
                          horizontalSpace(5),
                          Text(
                            "اضافة موعد",
                            style: TextStyles.cairo_12_bold
                                .copyWith(color: appColors.primaryColorYellow),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            times.isEmpty
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.sp, vertical: 5.sp),
                    child: Text(
                      "لا يوجد مواعيد مضافة",
                      style: TextStyles.cairo_12_regular
                          .copyWith(color: appColors.grey5),
                    ),
                  )
                : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: times.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.sp, vertical: 1.sp),
                            child: ListTile(
                              title: Text(
                                "الفترة ${index + 1}",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                              subtitle: Text(
                                " من ${times[index].from}  الي ${times[index].to}",
                                style: TextStyles.cairo_12_regular
                                    .copyWith(color: appColors.grey5),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CupertinoButton(
                                    onPressed: () {
                                      context
                                          .read<OfficeProviderCubit>()
                                          .deleteTimeSlot(
                                              times[index], widget.dayIndex);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: appColors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      CustomButton(
                        onPress: () {
                          getit<OfficeProviderCubit>().storeWorkingDays();
                        },
                        title: 'حفظ',
                      ),
                    ],
                  )
          ],
        );
      },
    );
  }
}

class AddTimeSlot extends StatefulWidget {
  AddTimeSlot(
      {super.key,
      required this.dayIndex,
      required this.serviceId,
      required this.call});

  final int dayIndex;
  final int serviceId;
  Null Function() call;

  @override
  State<AddTimeSlot> createState() => _AddTimeSlotState();
}

class _AddTimeSlotState extends State<AddTimeSlot> {
  String? from;
  String? to;

  bool isSaveButtonEnabled() {
    if (from == null || to == null) return false;
    final fromTime = TimeOfDay(
      hour: int.parse(from!.split(":")[0]),
      minute: int.parse(from!.split(":")[1]),
    );
    final toTime = TimeOfDay(
      hour: int.parse(to!.split(":")[0]),
      minute: int.parse(to!.split(":")[1]),
    );
    final difference = toTime.hour * 60 +
        toTime.minute -
        (fromTime.hour * 60 + fromTime.minute);
    return difference >= 15;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<OfficeProviderCubit>(),
      child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Container(
            height: 300.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 8.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CupertinoButton(
                    child: const Icon(CupertinoIcons.xmark,
                        color: appColors.grey5),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("بداية الفترة من",
                        style: TextStyles.cairo_14_semiBold.copyWith(
                          color: appColors.black,
                        )),
                    CupertinoButton(
                        child: Text(
                          from ?? "اختر التوقيت",
                          style: TextStyles.cairo_14_bold.copyWith(
                            color: appColors.primaryColorYellow,
                          ),
                        ),
                        onPressed: () async {
                          final selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(
                                data: MediaQuery.of(context)
                                    .copyWith(alwaysUse24HourFormat: false),
                                child: child!,
                              );
                            },
                          );
                          if (selectedTime != null) {
                            from = formatTime24Hour(selectedTime);
                            to = null; // Reset 'to' time when 'from' is changed
                            setState(() {});
                          }
                        })
                  ],
                ),
                verticalSpace(20.sp),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("نهاية الفترة ",
                        style: TextStyles.cairo_14_semiBold.copyWith(
                          color: appColors.black,
                        )),
                    verticalSpace(10.sp),
                    CupertinoButton(
                        onPressed: from == null
                            ? null
                            : () async {
                                final selectedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false),
                                      child: child!,
                                    );
                                  },
                                );
                                if (selectedTime != null) {
                                  final selectedTimeStr =
                                      formatTime24Hour(selectedTime);
                                  if (selectedTimeStr.compareTo(from!) > 0) {
                                    final fromTime = TimeOfDay(
                                      hour: int.parse(from!.split(":")[0]),
                                      minute: int.parse(from!.split(":")[1]),
                                    );
                                    final toTime = TimeOfDay(
                                      hour: int.parse(
                                          selectedTimeStr.split(":")[0]),
                                      minute: int.parse(
                                          selectedTimeStr.split(":")[1]),
                                    );
                                    final difference = toTime.hour * 60 +
                                        toTime.minute -
                                        (fromTime.hour * 60 + fromTime.minute);
                                    if (difference >= 15) {
                                      to = selectedTimeStr;
                                      setState(() {});
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            'يجب أن يكون الفرق بين وقت البداية والنهاية 15 دقيقة على الأقل',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                      msg:
                                          'يجب أن يكون وقت النهاية بعد وقت البداية',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  }
                                }
                              },
                        child: Text(
                          to ?? "اختر التوقيت",
                          style: TextStyles.cairo_14_bold.copyWith(
                            color: appColors.primaryColorYellow,
                          ),
                        ))
                  ],
                ),
                verticalSpace(20.sp),
                Center(
                  child: CupertinoButton(
                      color: appColors.primaryColorYellow,
                      onPressed: isSaveButtonEnabled()
                          ? () {
                              final timeSlot = TimeSlot(from: from, to: to);
                              getit<OfficeProviderCubit>().addTimeSlot(
                                  timeSlot, widget.dayIndex, widget.serviceId);
                              Navigator.of(context).pop();
                              widget.call();
                            }
                          : null,
                      child: Text(
                        "حفظ",
                        style: TextStyles.cairo_10_bold
                            .copyWith(color: Colors.white),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
