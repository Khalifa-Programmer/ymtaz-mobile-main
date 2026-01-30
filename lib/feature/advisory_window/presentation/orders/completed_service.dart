import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/router/routes.dart';

import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../../layout/services/presentation/widgets/services_shimmer_effect.dart';
import '../../logic/advisory_cubit.dart';
import 'advisory_service_card.dart';

class CompletedAdvisory extends StatelessWidget {
  const CompletedAdvisory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisoryCubit>(),
      child: BlocConsumer<AdvisoryCubit, AdvisoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {},
            child: ListView(
              children: [
                ConditionalBuilder(
                  condition:
                      getit<AdvisoryCubit>().advisoriesResponseDigital != null,
                  builder: (BuildContext context) => Column(
                    children: [
                      ConditionalBuilder(
                        condition: getit<AdvisoryCubit>()
                            .advisoriesResponseDigital!
                            .data!
                            .reservations!
                            .isNotEmpty,
                        builder: (BuildContext context) => ListView.builder(
                          itemCount: getit<AdvisoryCubit>()
                              .advisoriesResponseDigital!
                              .data!
                              .reservations!
                              .length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Visibility(
                              visible: getit<AdvisoryCubit>()
                                          .advisoriesResponseDigital!
                                          .data!
                                          .reservations![index]
                                          .lawyer ==
                                      null
                                  ? false
                                  : true,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.myAdvisoryOrderDetails,
                                    arguments: getit<AdvisoryCubit>()
                                        .advisoriesResponseDigital!
                                        .data!
                                        .reservations![index],
                                  );
                                },
                                child: AdvisoryServiceCard(
                                  serviceName: getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .advisoryServicesSub!
                                      .name!,
                                  servicePrice:
                                      '${getit<AdvisoryCubit>().advisoriesResponseDigital!.data!.reservations![index].price ?? "غير متاح"} ',
                                  serviceDate: getDate(getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .createdAt!),
                                  serviceTime: getTime(getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .createdAt!),
                                  serviceStatus: getStatusText(int.parse(
                                      getit<AdvisoryCubit>()
                                          .advisoriesResponseDigital!
                                          .data!
                                          .reservations![index]
                                          .requestStatus!)),
                                  servicePiriorty: getit<AdvisoryCubit>()
                                              .advisoriesResponseDigital!
                                              .data!
                                              .reservations![index]
                                              .importance ==
                                          null
                                      ? 'غير متاح'
                                      : getit<AdvisoryCubit>()
                                          .advisoriesResponseDigital!
                                          .data!
                                          .reservations![index]
                                          .importance!
                                          .title!,
                                  providerName: getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .lawyer!
                                      .name!,
                                  providerImage: getit<AdvisoryCubit>()
                                          .advisoriesResponseDigital!
                                          .data!
                                          .reservations![index]
                                          .lawyer!
                                          .image ??
                                      'https://api.ymtaz.sa/uploads/person.png',
                                  type: getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .advisoryServicesSub!
                                      .name!,
                                  generalType: getit<AdvisoryCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index]
                                      .advisoryServicesSub!
                                      .generalCategory!
                                      .name!,
                                ),
                              ),
                            );
                          },
                        ),
                        fallback: (BuildContext context) => Nodata(),
                      ),
                    ],
                  ),
                  fallback: (BuildContext context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ServiceCardShimmer(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
