import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/my_appointments/data/model/appointment_offers_client.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_cubit.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';
import 'package:yamtaz/feature/my_appointments/presentation/orders/view_request_screen_done.dart';

import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../layout/services/presentation/widgets/service_cards.dart';

class ReqestsAppointmentsDone extends StatelessWidget {
  const ReqestsAppointmentsDone({super.key, required this.request});

  final List<Accepted> request;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        // Handle state changes if needed
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            // officeProviderCubit.loadServices();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(condition: request.isNotEmpty || request != null,
              builder: (BuildContext context) {
                return _buildServiceList(request);
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: Nodata(),
                );
              },),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<Accepted> serviceRequests) {
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

  Widget _buildServiceListItem(Accepted request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewAppointmentDoneScreen(
                  offer: request,)));
      },
      child: ServiceOfferCardPending(
        serviceName: request.reservationType!.name!,
        servicePrice: request.price?.toString() ?? '0',
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: 'accepted',
        servicePiriorty: request.reservationImportance?.title ?? '',
        providerName: request.lawyer!.name!,
        providerImage: request.lawyer!.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.lawyer!.image!,
      ),
    );
  }
}
