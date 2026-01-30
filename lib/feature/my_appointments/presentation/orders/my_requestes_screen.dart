import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';

import 'package:yamtaz/feature/my_appointments/data/model/appointment_offers_client.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_cubit.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';
import 'package:yamtaz/feature/my_appointments/presentation/orders/reqests_screen.dart';
import 'package:yamtaz/feature/my_appointments/presentation/orders/requestes_done.dart';

import '../../../layout/services/presentation/widgets/service_cards.dart';

class MyAppointmentsRequestsScreen extends StatelessWidget {
  const MyAppointmentsRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AppointmentsCubit>()..getAppointmentsoffersClient(),
      child: BlocConsumer<AppointmentsCubit, AppointmentsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    "طلبات المواعيد",
                    style: TextStyles.cairo_16_bold.copyWith(
                      color: appColors.black,
                    ),
                  ),
                  bottom: TabBar(
                      indicatorColor: appColors.primaryColorYellow,
                      labelStyle: TextStyles.cairo_14_bold,
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      unselectedLabelColor: const Color(0xFF808D9E),
                      unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                      tabs: const [
                        Tab(
                          text: 'العروض',
                        ),
                        Tab(
                          text: 'قيد التفاوض',
                        ),
                        Tab(
                          text: 'طلباتي',
                        ),
                      ]),
                ),
                body: TabBarView(children: [
                  ConditionalBuilder(
                    condition:
                        getit<AppointmentsCubit>().appointmentOffersClient !=
                            null,
                    builder: (BuildContext context) {
                      final List<Offer> combinedOffers = [
                        ...?getit<AppointmentsCubit>()
                            .appointmentOffersClient
                            ?.data
                            ?.offers
                            ?.pendingOffer,
                        ...?getit<AppointmentsCubit>()
                            .appointmentOffersClient
                            ?.data
                            ?.offers
                            ?.cancelledByClient
                      ];
                      return ReqestsAppointmentsScreen(
                        request: combinedOffers,
                      );
                    },
                    fallback: (BuildContext context) {
                      return Container(
                          height: 400, child: ShimmerServiceOfferCardPending());
                    },
                  ),
                  ConditionalBuilder(
                    condition:
                        getit<AppointmentsCubit>().appointmentOffersClient !=
                            null,
                    builder: (BuildContext context) {
                      return ReqestsAppointmentsScreen(
                        request: getit<AppointmentsCubit>()
                                .appointmentOffersClient!
                                .data!
                                .offers!
                                .pendingAcceptance ??
                            [],
                      );
                    },
                    fallback: (BuildContext context) {
                      return ShimmerServiceOfferCardPending();
                    },
                  ),
                  ConditionalBuilder(
                    condition:
                        getit<AppointmentsCubit>().appointmentOffersClient !=
                            null,
                    builder: (BuildContext context) {
                      return ReqestsAppointmentsDone(
                        request: getit<AppointmentsCubit>()
                                .appointmentOffersClient!
                                .data!
                                .offers!
                                .accepted ??
                            [],
                      );
                    },
                    fallback: (BuildContext context) {
                      return ShimmerServiceOfferCardPending();
                    },
                  ),
                ]),
              ));
        },
      ),
    );
  }
}
