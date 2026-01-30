import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/view_request_screen.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/service_cards.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';

class ReqestsScreen extends StatelessWidget {
  const ReqestsScreen({super.key, required this.request});

  final List<Offer> request;

  @override
  Widget build(BuildContext context) {
    final officeProviderCubit = getit<ServicesCubit>();

    return BlocConsumer<ServicesCubit, ServicesState>(
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
              condition: request.isNotEmpty || request != null,
              builder: (BuildContext context) {
                return _buildServiceList(request);
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: Nodata(),
                );
              },
            ),
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewOfferScreen(
                      offer: request,
                      currentState: request.status!,
                    )));
      },
      child: ServiceOfferCardPending(
        serviceName: request.service!.title!,
        servicePrice: request.price?.toString() ?? '0',
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: request.status!,
        servicePiriorty: request.priority!.title!,
        providerName: request.lawyer?.name?? " ",
        providerImage: request.lawyer?.image == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.lawyer!.image!,
      ),
    );
  }
}
