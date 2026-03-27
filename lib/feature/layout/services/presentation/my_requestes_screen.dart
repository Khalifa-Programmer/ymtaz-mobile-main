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
              body: BlocBuilder<ServicesCubit, ServicesState>(
                builder: (context, state) {
                  final cubit = context.read<ServicesCubit>();

                  if (state is GetServices) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is GetServicesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64, color: Colors.red),
                          const SizedBox(height: 16),
                          Text(state.message, 
                            textAlign: TextAlign.center,
                            style: TextStyles.cairo_14_semiBold
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => cubit.getMyServicesRequestOffers(),
                            child: const Text("إعادة المحاولة"),
                          )
                        ],
                      ),
                    );
                  }

                  if (cubit.myServicesRequestResponse == null) {
                    return ShimmerServiceOfferCardPending();
                  }

                  return TabBarView(children: [
                    _buildOffersTab(cubit),
                    _buildPendingAcceptanceTab(cubit),
                    _buildAcceptedTab(cubit),
                  ]);
                },
              ),
            ));
      },
    );
  }

  Widget _buildOffersTab(ServicesCubit cubit) {
    final combinedOffers = [
      ...?cubit.myServicesRequestResponse?.data?.offers?.pendingOffer,
      ...?cubit.myServicesRequestResponse?.data?.offers?.declined
    ];
    return ReqestsScreen(request: combinedOffers);
  }

  Widget _buildPendingAcceptanceTab(ServicesCubit cubit) {
    return ReqestsScreen(
      request: cubit.myServicesRequestResponse?.data?.offers?.pendingAcceptance ?? [],
    );
  }

  Widget _buildAcceptedTab(ServicesCubit cubit) {
    return ReqestsScreen(
      request: cubit.myServicesRequestResponse?.data?.offers?.accepted ?? [],
    );
  }
}
