import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';

import '../../../logic/office_provider_state.dart';

class DayWorkCustom extends StatelessWidget {
  DayWorkCustom(
      {super.key,
      required this.service,
      required this.dayName,
      required this.isSwitched,
      required this.dayNum,
      required this.isSelected});

  final String service;
  final String dayName;
  final String dayNum;
  bool isSwitched;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfficeProviderCubit, OfficeProviderState>(
      buildWhen: (previous, current) => current is! ChangeDayIndexSelected,
      builder: (context, state) {
        return Container(
          width: 60.w,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  isSelected ? appColors.primaryColorYellow : appColors.grey3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 1.r,
                blurRadius: 8.r,
                offset: const Offset(0.0, 0.75),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(dayName, style: TextStyles.cairo_10_bold),
              Icon(
                isSwitched ? Icons.check_circle : Icons.circle,
                color:
                    isSwitched ? appColors.primaryColorYellow : appColors.grey3,
              )
            ],
          ),
        );
      },
    );
  }
}
