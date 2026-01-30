import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_card.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/spacing.dart';
import '../../data/models/services_from_client_response.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';
import 'service_screen_details_client.dart';

class ClientServicesScreen extends StatelessWidget {
  const ClientServicesScreen({super.key});

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
              condition: officeProviderCubit.clientOrders != null,
              builder: (BuildContext context) => _buildServiceList(
                  officeProviderCubit.clientOrders!.data!.serviceRequests!),
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
                builder: (context) => ServiceScreenSetailsClient(
                    servicesRequirementsResponse: request)));
      },
      child: ServiceCard(
        serviceName: request.service!.title!,
        servicePrice: request.price!.toString(),
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getStatusText(request.requestStatus!),
        servicePiriorty: request.priority!.title!,
        providerName: request.client!.name!,
        providerImage: request.client!.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.client!.image!,
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

