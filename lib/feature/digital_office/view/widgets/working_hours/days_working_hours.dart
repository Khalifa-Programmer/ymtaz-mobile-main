import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../logic/office_provider_cubit.dart';
import '../../../logic/office_provider_state.dart';
import '../../work_time/working_hours_advisory.dart';
import 'day_work_custom.dart';

class DaysWorkingHours extends StatefulWidget {
  const DaysWorkingHours(this.serviceId, {super.key});

  final int serviceId;

  @override
  State<DaysWorkingHours> createState() => _DaysWorkingHoursState();
}

class _DaysWorkingHoursState extends State<DaysWorkingHours> {
  @override
  Widget build(BuildContext context) {
    final cubit = getit<OfficeProviderCubit>();

    // List of day names and corresponding switch states
    final days = [
      {'name': 'الاحد', 'isSwitched': cubit.isSunday, 'index': 1},
      {'name': 'الاثنين', 'isSwitched': cubit.isMonday, 'index': 2},
      {'name': 'الثلاثاء', 'isSwitched': cubit.isTuesday, 'index': 3},
      {'name': 'الاربعاء', 'isSwitched': cubit.isWednesday, 'index': 4},
      {'name': 'الخميس', 'isSwitched': cubit.isThursday, 'index': 5},
      {'name': 'الجمعة', 'isSwitched': cubit.isFriday, 'index': 6},
      {'name': 'السبت', 'isSwitched': cubit.isSaturday, 'index': 7},
    ];

    return Column(
      children: [
        SizedBox(
          height: 85.h,
          width: double.infinity,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              return CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  context.read<OfficeProviderCubit>().changeDayIndexSelected(
                      int.parse(day['index'].toString()));
                  context.read<OfficeProviderCubit>().getAdvisoryTimesForDay(
                      int.parse(day['index'].toString()), widget.serviceId);
                  setState(() {});
                },
                child: BlocBuilder<OfficeProviderCubit, OfficeProviderState>(
                  builder: (context, state) {
                    return DayWorkCustom(
                      service: widget.serviceId.toString(),
                      dayName: day['name'].toString(),
                      isSwitched:
                          day['isSwitched'].toString() == 'true' ? true : false,
                      isSelected:
                          cubit.dayIndexSelected == day['index'] ? true : false,
                      dayNum: day['index'].toString(),
                    );
                  },
                ),
              );
            },
          ),
        ),
        verticalSpace(16.sp),
        cubit.dayIndexSelected == 0
            ? const SizedBox()
            : DayDataContainer(
                day: days[cubit.dayIndexSelected - 1]['name'].toString(),
                dayIndex: cubit.dayIndexSelected,
                serviceId: widget.serviceId,
              ),
      ],
    );
  }
}
