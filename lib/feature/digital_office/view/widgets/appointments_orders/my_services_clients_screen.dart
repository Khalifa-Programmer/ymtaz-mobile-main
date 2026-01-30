import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/digital_office/data/models/appointment_office_reservations_client.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_card.dart';

import '../../../logic/office_provider_cubit.dart';
import '../../../logic/office_provider_state.dart';
import 'appointment_screen_details_client.dart';

class AppointmetnsOredersScreen extends StatelessWidget {
  const AppointmetnsOredersScreen({super.key});

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
            officeProviderCubit.loadAppoinemtns();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: officeProviderCubit.appointmentsRequested != null,
              builder: (BuildContext context) => _buildServiceList(
                  officeProviderCubit
                      .appointmentsRequested!.data!.reservations!),
              fallback: (BuildContext context) =>
                  _buildLoadingIndicator(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<Reservation> serviceRequests) {
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

  Widget _buildServiceListItem(Reservation request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AppointmentScreenSetailsClient(offer: request)));
      },
      child: ServiceCard(
        serviceName: request.reservationType!.name!,
        servicePrice: request.price!.toString(),
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getStatusText(1),
        servicePiriorty:
            request.reservationImportance?.title ?? 'مستوى غير معروف',
        providerName: request.account!.name!,
        providerImage: request.account!.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.account!.image!,
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
