import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/digital_office/data/models/appointment_office_reservations_client.dart';
import 'package:yamtaz/feature/digital_office/data/models/appointment_office_reservations_lawyer.dart' as law;
import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../../layout/services/presentation/widgets/service_card.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';


class MyAppointmetsScreen extends StatelessWidget {
  MyAppointmetsScreen({super.key, required this.data});

  Data data;

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
            officeProviderCubit.loadAppointments();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: data.reservations != null,
              builder: (BuildContext context) =>
                  _buildServiceList(data.reservations!),
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
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             ViewAdvisoryDetails(
          //                 servicesRequirementsResponse: request)));
        },
        child: ServiceCard(
          serviceName: request.reservationType!.name!,
          servicePrice: request.price!.toString(),
          serviceDate: getDate(request.createdAt!),
          serviceTime: getTime(request.createdAt!),
          serviceStatus: getStatusText(2),
          servicePiriorty: request.reservationImportance!.name!,
          providerName:request.reservedFromLawyer!.name!,
          providerImage: request.reservedFromLawyer!.photo == null
              ? 'https://api.ymtaz.sa/uploads/person.png'
              : request.reservedFromLawyer!.photo!,
        ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      width: double.infinity,
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

class MyAppointmetsScreenLawyer extends StatelessWidget {
  MyAppointmetsScreenLawyer({super.key, required this.data});

  law.DataAppointmetnsLawyer data;

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
            officeProviderCubit.loadAppointments();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConditionalBuilder(
              condition: data != null,
              builder: (BuildContext context) =>
                  _buildServiceList(data.reservations!),
              fallback: (BuildContext context) =>
                  _buildLoadingIndicator(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceList(List<law.Reservation> advisoryRequests) {
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

  Widget _buildServiceListItem(law.Reservation request, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ViewAdvisoryDetails(
        //                 servicesRequirementsResponse: request)));
      },
      child: ServiceCard(
        serviceName: request.reservationType!.name!,
        servicePrice:" request.price!.toString(),",
        serviceDate: getDate(request.createdAt!),
        serviceTime: getTime(request.createdAt!),
        serviceStatus: getStatusText(2),
        servicePiriorty: request.reservationImportance!.name!,
        providerName:request.reservedFromLawyer!.name!,
        providerImage: request.reservedFromLawyer!.photo == null
            ? 'https://api.ymtaz.sa/uploads/person.png'
            : request.reservedFromLawyer!.photo!,
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5,
      width: double.infinity,
      child: const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

