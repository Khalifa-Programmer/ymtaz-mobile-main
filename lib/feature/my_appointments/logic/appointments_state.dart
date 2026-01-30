import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/my_appointments/data/model/appointment_request_response.dart';

import '../data/model/avaliable_appointment_lawyer_model.dart';
import '../data/model/reply_to_offer_appointment_response.dart';

part 'appointments_state.freezed.dart';

@freezed
class AppointmentsState<T> with _$AppointmentsState<T> {
  const factory AppointmentsState.initial() = _Initial;

  const factory AppointmentsState.loading() = _Loading;

  const factory AppointmentsState.loaded(T data) = _Loaded;

  const factory AppointmentsState.error(String message) = _Error;

  const factory AppointmentsState.loadingRequest() = _LoadingRequest;

  const factory AppointmentsState.loadedRequest(AppontmentRequestResponse data) = _LoadedRequest;

  const factory AppointmentsState.errorRequest(String message) = _ErrorRequest;

   const factory AppointmentsState.appointmentLawyersByIdLoading() = AppointmentLawyersByIdLoading;

  const factory AppointmentsState.appointmentLawyersByIdSuccess(
      AvaliableAppointmentLawyerModel data) = AppointmentLawyersByIdSuccess;

  const factory AppointmentsState.appointmentLawyersByIdError(String message) = AppointmentLawyersByIdError;

  const factory AppointmentsState.respondToOffer() = RespondToOffer;

  const factory AppointmentsState.respondToOfferSuccess() = RespondToOfferSuccess;

  const factory AppointmentsState.respondToOfferError(String message) = RespondToOfferError;
  const factory AppointmentsState.requestServiceError(String message) =
  RequestServiceError;

  const factory AppointmentsState.respondToAppointmentOfferSuccess(ReplyToOfferAppointmentResponse data) = RespondToAppointmentOfferSuccess;







}
