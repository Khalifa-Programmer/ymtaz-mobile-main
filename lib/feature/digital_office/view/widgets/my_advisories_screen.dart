import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';

import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../../layout/services/presentation/widgets/service_card.dart';
import '../../data/models/lawyer_advisory_requests_responnse.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';
import 'advisory_details.dart';

class MyAdvisoryScreen extends StatelessWidget {
  MyAdvisoryScreen({super.key, required this.data});

  LawyerAdvisoriesRequestsResponnse data;

  @override
  Widget build(BuildContext context) {
    final officeProviderCubit = getit<OfficeProviderCubit>();

    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {
        // Handle state changes if needed
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            officeProviderCubit.loadAdvisory();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: data.data!.reservations != null,
              builder: (BuildContext context) =>
                  _buildServiceList(data.data!.reservations!),
              fallback: (BuildContext context) =>
                  _buildLoadingIndicator(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<Reservation> advisoryRequests) {
    if (advisoryRequests.isNotEmpty) {
      return ListView.builder(
        itemCount: advisoryRequests.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final request = advisoryRequests[index];
          return _buildServiceListItem(request, context);
        },
      );
    } else {
      return const Center(
        child: Nodata(),
      );
    }
  }

  Widget _buildServiceListItem(Reservation request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewAdvisoryDetails(
                    servicesRequirementsResponse: request)));
      },
      child: AdvisoryServiceCard(
        serviceName: request.advisoryServicesSub!.name!,
        servicePrice: request.price?.toString() ?? 'غير متاح',
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getStatusText(int.parse(request.requestStatus!)),
        servicePiriorty: request.importance!.title!,
        providerName: request.account!.name!,
        providerImage: request.account!.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.account!.image!,
        type: request
            .advisoryServicesSub!.generalCategory!.paymentCategoryType!.name!,
        generalType: request.advisoryServicesSub!.generalCategory!.name!,
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
