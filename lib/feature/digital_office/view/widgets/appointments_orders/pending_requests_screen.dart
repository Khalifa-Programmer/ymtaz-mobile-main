import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/appointments_orders/view_services_pending_details.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_card.dart';

import '../../../data/models/appointment_offers_lawyer.dart';
import '../../../logic/office_provider_cubit.dart';
import '../../../logic/office_provider_state.dart';

class AppointmetnsPendingRequestsScreen extends StatelessWidget {
  const AppointmetnsPendingRequestsScreen({super.key, required this.offers});

  final List<Offer> offers;

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

  Widget _buildServiceList(List<Offer> serviceRequests) {
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

  Widget _buildServiceListItem(Offer request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(request.toJson());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppointmetnsPendingDetailsClientScrenn(offer: request)));
      },
      child: ServiceOfferCard(
        serviceName: request.reservationType!.name!,
        servicePrice: "",
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getOfferStatusText(request.status ?? ''),
        servicePiriorty: request.importance?.title ?? '',
        providerName: request.accountId!.name!,
        providerImage: request.accountId!.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.accountId!.image!,
      ),
    );
  }
}
