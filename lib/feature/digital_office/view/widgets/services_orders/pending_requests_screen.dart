import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/digital_office/data/models/service_lawyer_offres_response.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/services_orders/view_services_pending_details.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_card.dart';

import '../../../logic/office_provider_cubit.dart';
import '../../../logic/office_provider_state.dart';

class PendingRequestsScreen extends StatelessWidget {
  PendingRequestsScreen({super.key, required this.offers});

  final List<Declined> offers;

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
            officeProviderCubit.servicesRequestsPending();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _buildServiceList(offers),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<Declined> serviceRequests) {
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

  Widget _buildServiceListItem(Declined request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(request.toJson());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ServiceScreenPendingDetailsClient(offer: request)));
      },
      child: ServiceOfferCard(
        serviceName: request.service!.title!.toString(),
        servicePrice: "",
        serviceDate: getDate("2024-12-29T11:38:23.000000Z"),
        serviceTime: getTime("2024-12-29T11:38:23.000000Z"),
        serviceStatus: getOfferStatusText(request.status! ?? ''),
        servicePiriorty: request.priority?.title! ?? '',
        providerName: request.account?.name ?? "",
        providerImage: request.account?.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.account!.image!,
      ),
    );
  }
}
