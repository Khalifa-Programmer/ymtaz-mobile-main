import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/service_screen_details_lawyer.dart';

import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../../layout/services/presentation/widgets/service_card.dart';
import '../../data/models/services_from_provider_response.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';

class ProviderServicesScreen extends StatelessWidget {
  const ProviderServicesScreen({super.key});

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
            officeProviderCubit.loadServices();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: officeProviderCubit.providerOrders != null,
              builder: (BuildContext context) => _buildServiceList(
                  officeProviderCubit.providerOrders!.data!.serviceRequests!),
              fallback: (BuildContext context) =>
                  _buildLoadingIndicator(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<ServiceRequest> serviceRequests) {
    if (serviceRequests.isNotEmpty) {
      return ListView.builder(
        itemCount: serviceRequests.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final request = serviceRequests[index];
          return _buildServiceListItem(request, context);
        },
      );
    } else {
      return const Center(
        child: Nodata(),
      );
    }
  }

  Widget _buildServiceListItem(ServiceRequest request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceScreenSetailsProvider(
                    servicesRequirementsResponse: request)));
      },
      child: ServiceCard(
        serviceName: request.service!.title!,
        servicePrice: request.price!.toString(),
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getStatusText(request.requestStatus!),
        servicePiriorty: request.priority!.title!,
        providerName:
            '${request.requesterLawyer!.firstName!} ${request.requesterLawyer!.secondName!} ${request.requesterLawyer!.fourthName!}',
        providerImage: request.requesterLawyer!.photo == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.requesterLawyer!.photo!,
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
