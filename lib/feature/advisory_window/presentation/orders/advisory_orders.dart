import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../logic/advisory_cubit.dart';
import 'completed_service.dart';

class AdvisoryOrders extends StatelessWidget {
  const AdvisoryOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>()..getAdvisories(),
      child: BlocConsumer<AdvisoryCubit, AdvisoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "استشاراتي",
                style: TextStyles.cairo_16_bold.copyWith(
                  color: appColors.black,
                ),
              ),
            ),
            body: Container(child: CompletedAdvisory()),
          );
        },
      ),
    );
  }
}
