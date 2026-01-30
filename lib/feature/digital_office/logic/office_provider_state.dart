import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_available_types_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_types_add_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/create_services_ymtaz_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_clients_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_from_client_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_from_provider_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_reply_success_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_ymtaz_response_model.dart';

import '../data/models/appointment_offers_lawyer.dart';
import '../data/models/appointment_office_reservations_client.dart';
import '../data/models/response_lawyer_to_appointment_offer.dart';
import '../data/models/response_lawyer_to_offer.dart';
import '../data/models/service_lawyer_offres_response.dart';

part 'office_provider_state.freezed.dart';

@freezed
class OfficeProviderState<T> with _$OfficeProviderState<T> {
  const factory OfficeProviderState.initial() = _Initial;

  const factory OfficeProviderState.loadingServices() = _LoadingServices;

  const factory OfficeProviderState.loadedServices(
      ServicesYmtazResponseModel data) = _LoadedServices;

  const factory OfficeProviderState.errorServices(String message) =
  _ErrorServices;

  const factory OfficeProviderState.selectedService() = _SelectedService;

  const factory OfficeProviderState.loadingRequestServices() =
  _LoadingRequestServices;

  const factory OfficeProviderState.loadedRequestServices(
      CreateServicesYmtazResponseModel data) = _LoadedRequestServices;

  const factory OfficeProviderState.errorRequestServices(String message) =
  _ErrorRequestServices;

  // get services from clients and reply to them

  const factory OfficeProviderState.loadingServicesRequestFromClients() =
  LoadingServicesRequestFromClients;

  const factory OfficeProviderState.loadedServicesRequestFromClients(
      ServicesFromClientsResponse data) = LoadedServicesRequestFromClients;

  const factory OfficeProviderState.errorServicesRequestFromClients(
      String message) = ErrorServicesRequestFromClients;

  const factory OfficeProviderState.loadingAppointmentsRequestFromClients() =
  LoadingAppointmentsRequestFromClients;

  const factory OfficeProviderState.loadedAppointmentsRequestFromClients(
      AppointmentOfficeReservationsClient data) =
  LoadedAppointmentssRequestFromClients;

  const factory OfficeProviderState.errorAppointmentsRequestFromClients(
      String message) = ErrorAppointmentsRequestFromClients;

  const factory OfficeProviderState.loadingServicesRequestFromProviders() =
  LoadingServicesRequestFromProviders;

  const factory OfficeProviderState.loadedServicesRequestFromProviders(
      ServicesFromProviderResponse data) = LoadedServicesRequestFromProviders;

  const factory OfficeProviderState.errorServicesRequestFromProviders(
      String message) = ErrorServicesRequestFromProviders;

  const factory OfficeProviderState.loadingServicesReplyFromClients() =
  LoadingServicesReplyFromClients;

  const factory OfficeProviderState.loadedServicesReplyFromClients(
      ServicesReplySuccessResponse data) = LoadedServicesReplyFromClients;

  const factory OfficeProviderState.errorServicesReplyFromClients(
      String message) = ErrorServicesReplyFromClients;

  const factory OfficeProviderState.loadingServicesReplyFromProviders() =
  LoadingServicesReplyFromProviders;

  const factory OfficeProviderState.loadedServicesReplyFromProviders(
      ServicesReplySuccessResponse data) = LoadedServicesReplyFromProviders;

  const factory OfficeProviderState.errorServicesReplyFromProviders(
      String message) = ErrorServicesReplyFromProviders;

  // get advisory and add advisory

  const factory OfficeProviderState.loadingAdvisoryAvaliable() =
  LoadingAdvisoryAvaliable;

  const factory OfficeProviderState.loadedAdvisoryAvaliable(
      AdvisoryAvailableTypesResponse data) = LoadedAdvisoryAvaliable;

  const factory OfficeProviderState.errorAdvisoryAvaliable(String message) =
  ErrorAdvisoryAvaliable;

  const factory OfficeProviderState.loadingAddAdvisory() = LoadingAddAdvisory;

  const factory OfficeProviderState.loadedAddAdvisory(
      AdvisoryTypesAddResponse data) = LoadedAddAdvisory;

  const factory OfficeProviderState.errorAddAdvisory(String message) =
  ErrorAddAdvisory;

  // get my clients
  const factory OfficeProviderState.loadingMyClients() = LoadingMyClients;

  const factory OfficeProviderState.loadedMyClients(MyClientsResponse data) =
  LoadedMyClients;

  const factory OfficeProviderState.errorMyClients(String message) =
  ErrorMyClients;

  // post workijng hours
  const factory OfficeProviderState.loadingPostWorkingHours() =
  LoadingPostWorkingHours;

  const factory OfficeProviderState.loadedPostWorkingHours() =
  LoadedPostWorkingHours;

  const factory OfficeProviderState.errorPostWorkingHours(String message) =
  ErrorPostWorkingHours;

  // get workijng hours

  const factory OfficeProviderState.loadingWorkingHours() = LoadingWorkingHours;

  const factory OfficeProviderState.loadedWorkingHours() = LoadedWorkingHours;

  const factory OfficeProviderState.errorWorkingHours(String message) =
  ErrorWorkingHours;

  // get appintments types

  const factory OfficeProviderState.loadingAppointmentsTypes() =
  LoadingAppointmentsTypes;

  const factory OfficeProviderState.loadedAppointmentsTypes() =
  LoadedAppointmentsTypes;

  const factory OfficeProviderState.errorAppointmentsTypes(String message) =
  ErrorAppointmentsTypes;

  // create appointments types

  const factory OfficeProviderState.loadingCreateAppointmentsTypes() =
  LoadingCreateAppointmentsTypes;

  const factory OfficeProviderState.loadedCreateAppointmentsTypes() =
  LoadedCreateAppointmentsTypes;

  const factory OfficeProviderState.errorCreateAppointmentsTypes(
      String message) = ErrorCreateAppointmentsTypes;

  // get advisory services requests

  const factory OfficeProviderState.loadingAdvisoryServicesRequests() =
  LoadingAdvisoryServicesRequests;

  const factory OfficeProviderState.loadedAdvisoryServicesRequests() =
  LoadedAdvisoryServicesRequests;

  const factory OfficeProviderState.errorAdvisoryServicesRequests(
      String message) = ErrorAdvisoryServicesRequests;

  // get analysis for products
  const factory OfficeProviderState.loadingAnalytics() = LoadingAnalytics;

  const factory OfficeProviderState.loadedAnalytics() = LoadedAnalytics;

  const factory OfficeProviderState.errorAnalytics(String message) =
  ErrorAnalytics;

  // days times
  const factory OfficeProviderState.changeDayIndexSelected() =
  ChangeDayIndexSelected;

  // add data
  const factory OfficeProviderState.addData() = AddData;

  // hide services

  const factory OfficeProviderState.loadingHideServices() = LoadingHideServices;

  const factory OfficeProviderState.loadedHideServices() = LoadedHideServices;

  const factory OfficeProviderState.errorHideServices(String message) =
  ErrorHideServices;

  // delete services

  const factory OfficeProviderState.loadingDeleteServices() =
  LoadingDeleteServices;

  const factory OfficeProviderState.loadedDeleteServices() =
  LoadedDeleteServices;

  const factory OfficeProviderState.errorDeleteServices(String message) =
  ErrorDeleteServices;

  // offers services requests

  const factory OfficeProviderState.loadingOffersServicesRequests() =
  LoadingOffersServicesRequests;

  const factory OfficeProviderState.loadedOffersServicesRequests(
      ServiceLawyerOffresResponse data) = LoadedOffersServicesRequests;

  const factory OfficeProviderState.errorOffersServicesRequests(
      String message) = ErrorOffersServicesRequests;

  // offers services requests

  const factory OfficeProviderState.loadingOffersAppointmentsRequests() =
  LoadingOffersAppointmentsRequests;

  const factory OfficeProviderState.loadedOffersAppointmentsRequests(
      AppointmentOffersLawyer data) = LoadedOffersAppointmentsRequests;

  const factory OfficeProviderState.errorOffersAppointmentsRequests(
      String message) = ErrorOffersAppointmentsRequests;

  // offer send

  const factory OfficeProviderState.loadingOfferSend() = LoadingOfferSend;

  const factory OfficeProviderState.loadedOfferSend(
      ResponseLawyerToOffer data) = LoadedOfferSend;

  const factory OfficeProviderState.errorOfferSend(String message) =
  ErrorOfferSend;

  const factory OfficeProviderState.loadingAppointmentOfferSend() =
  LoadingAppointmentOfferSend;

  const factory OfficeProviderState.loadedAppointmentOfferSend(
      ResponseLawyerToAppointmentOffer data) = LoadedAppointmentOfferSend;

  const factory OfficeProviderState.errorAppointmentOfferSend(String message) =
  ErrorAppointmentOfferSend;

  // start appointment

  const factory OfficeProviderState.loadingStartAppointment() =
  LoadingStartAppointment;

  const factory OfficeProviderState.loadedStartAppointment() =
  LoadedStartAppointment;

  const factory OfficeProviderState.errorStartAppointment(String message) =
  ErrorStartAppointment;
}
