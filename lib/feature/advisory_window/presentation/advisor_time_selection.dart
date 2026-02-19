import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../core/di/dependency_injection.dart';
import '../../my_appointments/data/model/working_hours_response.dart';
import '../logic/advisory_cubit.dart';

class AdvisorTimeSelection extends StatefulWidget {
  int selectedTimeId = -1;

  String? lawyerId;
  String? serviceId;

  String selectedTimeFrom = "";
  String selectedTimeTo = "";
  int selectedHours = -1;

  DateTime? _selectedDate;
  List<AvailableTime>? _selectedDateTimes;

  AdvisorTimeSelection({super.key});

  @override
  State<AdvisorTimeSelection> createState() => _AdvisorTimeSelectionState();
}

class _AdvisorTimeSelectionState extends State<AdvisorTimeSelection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvisoryCubit, AdvisoryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return getit<AdvisoryCubit>().availableDatesResponse == null
            ? shimmerlOADING()
            : selectAppointment();
      },
    );
  }

  Center selectAppointment() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "اختر موعدًا",
            style: TextStyles.cairo_14_bold,
          ),
          verticalSpace(5.h),
          Text(
            "اختر موعدًا للحصول على استشارة مرئية",
            style:
                TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
          ),
          verticalSpace(10.h),
          Container(
              width: 330.w,
              height: 300.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: appColors.grey3, width: 1)),
              child: SfDateRangePicker(
                enablePastDates: false,
                enableMultiView: false,
                showNavigationArrow: true,
                headerHeight: 50.h,
                backgroundColor: appColors.white,
                view: DateRangePickerView.month,
                selectableDayPredicate: (DateTime date) {
                  // Check if the date is in the availableDates list
                  return getit<AdvisoryCubit>()
                      .availableDatesResponse!
                      .days!
                      .any((availableDate) {
                    DateTime availableDateTime =
                        DateTime.parse(availableDate.date.toString());
                    return date.isAtSameMomentAs(availableDateTime);
                  });
                },
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  setState(() {
                    widget._selectedDateTimes = null;
                    print("here");
                    widget._selectedDate =
                        dateRangePickerSelectionChangedArgs.value;

                    widget._selectedDateTimes = context
                        .read<AdvisoryCubit>()
                        .availableDatesResponse!
                        .days!
                        .firstWhere((availableDate) =>
                            DateTime.parse(availableDate.date.toString()) ==
                            widget._selectedDate)
                        .availableTimes!;
                  });

                  print(widget._selectedDateTimes);
                },
                headerStyle: DateRangePickerHeaderStyle(
                    backgroundColor: appColors.white,
                    textAlign: TextAlign.start,
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                todayHighlightColor: appColors.blue100,
                selectionColor: appColors.primaryColorYellow,
                yearCellStyle: DateRangePickerYearCellStyle(
                    textStyle: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black)),
                selectionMode: DateRangePickerSelectionMode.single,
              )),
          verticalSpace(10.h),
          ConditionalBuilder(
              condition: widget._selectedDateTimes != null &&
                  widget._selectedDate != null,
              builder: (context) => Wrap(
                    spacing: 5.0.r,
                    children: List<Widget>.generate(
                      widget._selectedDateTimes!.length,
                      (int index) {
                        return ChoiceChip(
                          showCheckmark: false,
                          label: Text(
                              "${widget._selectedDateTimes!.elementAt(index).from} - ${widget._selectedDateTimes!.elementAt(index).to}",
                              style: TextStyles.cairo_12_bold.copyWith(
                                  color: widget.selectedTimeId == index
                                      ? appColors.white
                                      : appColors.grey20)),
                          selected: widget.selectedTimeId == index,
                          onSelected: (bool selected) {
                            setState(() {
                              widget.selectedTimeId = selected ? index : -1;
                              widget.selectedTimeFrom = widget
                                  ._selectedDateTimes!
                                  .elementAt(index)
                                  .from!;
                              widget.selectedTimeTo = widget._selectedDateTimes!
                                  .elementAt(index)
                                  .to!;
                            });
                          },
                          selectedColor: appColors.primaryColorYellow,
                          backgroundColor: appColors.grey1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.sp),
                            side: BorderSide(
                                color: widget.selectedTimeId == index
                                    ? appColors.primaryColorYellow
                                    : appColors.grey1,
                                width: 1.sp),
                          ),
                        );
                      },
                    ).toList(),
                  ),
              fallback: (context) => SizedBox()),
          verticalSpace(10.h),
          CustomButton(
              title: "احجز الموعد",
              onPress: () {
                if (widget._selectedDate == null) {
                  showSnackBar(context, "الرجاء اختيار تاريخ");
                } else if (widget.selectedTimeId == -1) {
                  showSnackBar(context, "الرجاء اختيار وقت");
                } else {
                  context.read<AdvisoryCubit>().addTimeAndDateToRequest(
                        getDate(widget._selectedDate!.toString()),
                        widget.selectedTimeFrom,
                        widget.selectedTimeTo,
                      );
                  context.read<AdvisoryCubit>().nextStep();
                }
              })
        ],
      ),
    );
  }
}

Widget shimmerlOADING() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: appColors.grey3,
      highlightColor: appColors.grey1,
      child: Container(
          width: 330.w,
          height: 300.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: appColors.grey3, width: 1)),
          child: SfDateRangePicker()),
    ),
  );
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}
