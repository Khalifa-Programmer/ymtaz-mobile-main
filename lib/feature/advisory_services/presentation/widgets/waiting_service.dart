import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_cubit.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';

import '../../../layout/services/presentation/widgets/services_shimmer_effect.dart';
import 'advisory_service_card.dart';

class WaitingAdvisoryServices extends StatelessWidget {
  const WaitingAdvisoryServices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisorCubit>(),
      child: BlocConsumer<AdvisorCubit, AdvisorState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConditionalBuilder(
                condition: state is SucessMyReservation,
                builder: (BuildContext context) => Column(
                  children: [
                    ConditionalBuilder(
                      condition: getit<AdvisorCubit>()
                          .advisoriesResponseYmtaz!
                          .data!
                          .reservations!
                          .isNotEmpty,
                      builder: (BuildContext context) => ListView.builder(
                        itemCount: getit<AdvisorCubit>()
                            .advisoriesResponseYmtaz!
                            .data!
                            .reservations!
                            .length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible: getit<AdvisorCubit>()
                                        .advisoriesResponseYmtaz!
                                        .data!
                                        .reservations![index]
                                        .reply ==
                                    null
                                ? true
                                : false,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.myAdvisoryOrderDetails,
                                  arguments: getit<AdvisorCubit>()
                                      .advisoriesResponseYmtaz!
                                      .data!
                                      .reservations![index],
                                );
                              },
                              child: AdvisoryServiceCard(
                                serviceName: getit<AdvisorCubit>()
                                    .advisoriesResponseYmtaz!
                                    .data!
                                    .reservations![index]
                                    .advisoryServicesId!
                                    .title!,
                                servicePrice:
                                    '${getit<AdvisorCubit>().advisoriesResponseYmtaz!.data!.reservations![index].price ?? "غير متاح"} ',
                                serviceDate: getDate(getit<AdvisorCubit>().advisoriesResponseYmtaz!.data!.reservations![index].createdAt!),
                                serviceTime: getTime(getit<AdvisorCubit>().advisoriesResponseYmtaz!.data!.reservations![index].createdAt!),
                                serviceStatus: getit<AdvisorCubit>()
                                            .advisoriesResponseYmtaz!
                                            .data!
                                            .reservations![index]
                                            .reply ==
                                        null
                                    ? 'انتظار'
                                    : 'مكتملة',
                                servicePiriorty: getit<AdvisorCubit>()
                                            .advisoriesResponseYmtaz!
                                            .data!
                                            .reservations![index]
                                            .importance ==
                                        null
                                    ? 'غير متاح'
                                    : getit<AdvisorCubit>()
                                        .advisoriesResponseYmtaz!
                                        .data!
                                        .reservations![index]
                                        .importance!
                                        .title!,
                                providerName: "يمتاز للاستشارات القانونية",
                                providerImage: '',
                              ),
                            ),
                          );
                        },
                      ),
                      fallback: (BuildContext context) => const Nodata(),
                    ),
                  ],
                ),
                fallback: (BuildContext context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ServiceCardShimmer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
