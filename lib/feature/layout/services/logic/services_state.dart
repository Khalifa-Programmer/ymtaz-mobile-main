import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/layout/services/data/model/available_lawyers_for_service_model.dart';
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_request_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';

import '../data/model/respond_clinet_to_offer_response.dart';

part 'services_state.freezed.dart';

@freezed
class ServicesState<T> with _$ServicesState<T> {
  const factory ServicesState.initial() = _Initial;

  const factory ServicesState.loadingServices() = LoadingServices;

  const factory ServicesState.loadedServices(
      ServicesRequirementsResponse data) = LoadedServices;

  const factory ServicesState.errorServices(String message) = ErrorServices;

  const factory ServicesState.changeServicePrice() = ChangeServicePrice;

  const factory ServicesState.selectedServiceItem() = SelectedServiceItem;

  // request services  to api
  const factory ServicesState.requestService() = RequestService;

  const factory ServicesState.requestServiceSuccess(
      ServicesRequestResponse data) = RequestServiceSuccess;

  const factory ServicesState.requestServiceError(String message) =
      RequestServiceError;

  // get services from api
  const factory ServicesState.getServices() = GetServices;

  const factory ServicesState.getServicesSuccess(
      MyServicesRequestsResponse data) = GetServicesSuccess;

  const factory ServicesState.getServicesError(String message) =
      GetServicesError;

  //serviceLawyersById
  const factory ServicesState.serviceLawyersByIdLoading() =
      ServiceLawyersByIdLoading;

  const factory ServicesState.serviceLawyersByIdSuccess(
      AvailableLawyersForServiceModel data) = ServiceLawyersByIdSuccess;

  const factory ServicesState.serviceLawyersByIdError(String message) =
      ServiceLawyersByIdError;

  // respond to offer

  const factory ServicesState.respondToOffer() = RespondToOffer;

  const factory ServicesState.respondToOfferSuccess(
      RespondClinetToOfferResponse data) = RespondToOfferSuccess;

  const factory ServicesState.respondToOfferError(String message) =
      RespondToOfferError;
}
