import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_category_response.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_cubit.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';

import '../../../core/di/dependency_injection.dart';
import '../../my_appointments/data/model/working_hours_response.dart';

class AdvisoryRequestTime extends StatefulWidget {
  AdvisoryRequestTime(
      {super.key,
      required this.data,
      required this.typeId,
      required this.note,
      required this.importanceId});

  ItemAdvisor data;
  int selectedDateId = -1;
  int selectedTimeId = -1;
  int typeId;
  int importanceId;
  String note;

  String selectedTimeFrom = "";
  String selectedTimeTo = "";
  int selectedHours = -1;

  DateTime? _selectedDate;
  List<AvailableTime>? _selectedDateTimes;

  @override
  State<AdvisoryRequestTime> createState() => _AdvisoryRequestTimeState();
}

class _AdvisoryRequestTimeState extends State<AdvisoryRequestTime> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdvisorCubit, AdvisorState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text('اختر موعد',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
                child: getit<AdvisorCubit>().availableDatesResponse == null
                    ? const Center(
                        child: CupertinoActivityIndicator(),
                      )
                    : selectAppointment(),
              ),
            ));
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
            "يرجي اختيار موعد",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: appColors.blue100,
            ),
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
                enablePastDates: true,
                enableMultiView: false,
                showNavigationArrow: true,
                selectableDayPredicate: (DateTime date) {
                  // Check if the date is in the availableDates list
                  return getit<AdvisorCubit>()
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
                        .read<AdvisorCubit>()
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
                                      : appColors.blue100)),
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
                          selectedColor: appColors.blue100,
                          backgroundColor: appColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.sp),
                            side:
                                const BorderSide(color: appColors.blue100),
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
                if (widget.selectedTimeId != -1) {
                  FormData data = FormData.fromMap({
                    "date": getDate(widget._selectedDate.toString()),
                    "from": widget.selectedTimeFrom,
                    "to": widget.selectedTimeTo,
                    "type_id": widget.typeId,
                    "importance_id": widget.importanceId,
                    "description": widget.note,
                    "advisory_services_id": widget.data.id,
                    "accept_rules": 1,
                    "hours" : 1
                  });


                  context.read<AdvisorCubit>().createAppointment(data);
                }
              })
        ],
      ),
    );
  }

  int findDateId(String targetDate) {
    for (int i = 0; i < widget.data.availableDates!.length; i++) {
      if (getDate(widget.data.availableDates![i].date.toString()) ==
          targetDate) {
        return i;
      }
    }
    // Return -1 if the date is not found
    return -1;
  }
}
