import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_cubit.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';

import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../../layout/services/presentation/widgets/services_shimmer_effect.dart';
import 'advisory_service_card.dart';

class CompletedAdvisory extends StatelessWidget {
  const CompletedAdvisory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisorCubit>(),
      child: BlocConsumer<AdvisorCubit, AdvisorState>(
        listener: (context, state) {
          // TODO: implement listener
        },
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
                          .advisoriesResponseDigital!
                          .data!
                          .reservations!
                          .isNotEmpty,
                      builder: (BuildContext context) => ListView.builder(
                        itemCount: getit<AdvisorCubit>()
                            .advisoriesResponseDigital!
                            .data!
                            .reservations!
                            .length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Visibility(
                            visible: getit<AdvisorCubit>()
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
                                  arguments: getit<AdvisorCubit>()
                                      .advisoriesResponseDigital!
                                      .data!
                                      .reservations![index],
                                );
                              },
                              child: AdvisoryServiceCard(
                                serviceName: getit<AdvisorCubit>()
                                    .advisoriesResponseDigital!
                                    .data!
                                    .reservations![index]
                                    .advisoryServicesId!
                                    .title!,
                                servicePrice:
                                    '${getit<AdvisorCubit>().advisoriesResponseDigital!.data!.reservations![index].price ?? "غير متاح"} ',
                                serviceDate: getDate(getit<AdvisorCubit>().advisoriesResponseDigital!.data!.reservations![index].createdAt!),
                                serviceTime: getTime(getit<AdvisorCubit>().advisoriesResponseDigital!.data!.reservations![index].createdAt!),
                                serviceStatus: getit<AdvisorCubit>()
                                            .advisoriesResponseDigital!
                                            .data!
                                            .reservations![index]
                                            .reply ==
                                        null
                                    ? 'انتظار'
                                    : 'مكتملة',
                                servicePiriorty: getit<AdvisorCubit>()
                                            .advisoriesResponseDigital!
                                            .data!
                                            .reservations![index]
                                            .importance ==
                                        null
                                    ? 'غير متاح'
                                    : getit<AdvisorCubit>()
                                        .advisoriesResponseDigital!
                                        .data!
                                        .reservations![index]
                                        .importance!
                                        .title!,
                                providerName: '',
                                providerImage:
                                    'https://api.ymtaz.sa/uploads/person.png',
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
              ),
            ),
          );
        },
      ),
    );
  }

  String getStatusText(int requestStatus) {
    // Map لتحديد النص المقابل لكل requestStatus
    Map<int, String> statusTextMap = {
      0: 'قيد الانتظار',
      1: 'قيد الدراسة',
      2: 'مكتملة',
    };

    // تحقق مما إذا كانت القيمة موجودة في الخريطة
    return statusTextMap.containsKey(requestStatus)
        ? statusTextMap[requestStatus]!
        : 'حالة غير معروفة';
  }
}
