import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/reqests_screen.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_cards.dart';

import '../../../../l10n/locale_keys.g.dart';

class MyServicesRequestsScreen extends StatelessWidget {
  const MyServicesRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
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
                  LocaleKeys.services.tr(),
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
                      getit<ServicesCubit>().myServicesRequestResponse != null,
                  builder: (BuildContext context) {
                    final combinedOffers = [
                      ...?getit<ServicesCubit>()
                          .myServicesRequestResponse
                          ?.data
                          ?.offers
                          ?.pendingOffer,
                      ...?getit<ServicesCubit>()
                          .myServicesRequestResponse
                          ?.data
                          ?.offers
                          ?.declined
                    ];
                    return ReqestsScreen(
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
                      getit<ServicesCubit>().myServicesRequestResponse != null,
                  builder: (BuildContext context) {
                    return ReqestsScreen(
                      request: getit<ServicesCubit>()
                              .myServicesRequestResponse!
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
                      getit<ServicesCubit>().myServicesRequestResponse != null,
                  builder: (BuildContext context) {
                    return ReqestsScreen(
                      request: getit<ServicesCubit>()
                              .myServicesRequestResponse!
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
    );
  }
}
