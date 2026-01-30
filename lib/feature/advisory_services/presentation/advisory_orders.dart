import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_cubit.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';
import 'package:yamtaz/feature/advisory_services/presentation/widgets/completed_service.dart';
import 'package:yamtaz/feature/advisory_services/presentation/widgets/waiting_service.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';

class AdvisoryOrders extends StatelessWidget {
  const AdvisoryOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisorCubit>()..getAdvisories(),
      child: BlocConsumer<AdvisorCubit, AdvisorState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return DefaultTabController(
              length: 2,
              child: Scaffold(
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
                  bottom: TabBar(
                      indicatorColor: appColors.primaryColorYellow,
                      labelStyle: TextStyles.cairo_14_bold,
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                      unselectedLabelColor: const Color(0xFF808D9E),
                      unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                      tabs: const [
                        Tab(
                          text: 'هيئة المستشارين',
                        ),
                        Tab(
                          text: 'الدليل الرقمي',
                        ),
                      ]),
                ),
                body: const TabBarView(children: [
                  WaitingAdvisoryServices(),
                  // UnderStudyServices(),
                  CompletedAdvisory(),
                ]),
              ));
        },
      ),
    );
  }
}
