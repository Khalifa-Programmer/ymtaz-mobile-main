import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_main_category_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_request_response.dart';

part 'advisor_state.freezed.dart';

@freezed
class AdvisorState<T> with _$AdvisorState<T> {
  const factory AdvisorState.initial() = _Initial;

  const factory AdvisorState.loadingTypes() = LoadingTypes;

  const factory AdvisorState.sucessLoadTypes(T data) = SucessLoadTypes;

  const factory AdvisorState.errorLoadTypes(String error) = ErrorLoadTypes;

  const factory AdvisorState.loadingSections() = LoadingSections;

  const factory AdvisorState.sucessLoadSections(T data) = SucessLoadSections;

  const factory AdvisorState.errorLoadSections(String error) =
      ErrorLoadSections;

  const factory AdvisorState.changeSections() = changeSections;

  const factory AdvisorState.loadingReservation() = LoadingReservation;

  const factory AdvisorState.sucessReservation(AdvisoryRequestResponse data) =
      SucessReservation;

  const factory AdvisorState.errorReservation(String error) = ErrorReservation;

  const factory AdvisorState.loadingMyReservation() = LoadingMyReservation;

  const factory AdvisorState.sucessMyReservation(T data) = SucessMyReservation;

  const factory AdvisorState.errorMyReservation(String error) =
      ErrorMyReservation;

  // main category
  const factory AdvisorState.loadingMainCategory() = LoadingMainCategory;

  const factory AdvisorState.sucessLoadMainCategory(AdvisoryMainCategory data) =
      SucessLoadMainCategory;

  const factory AdvisorState.errorLoadMainCategory(String error) =
      ErrorLoadMainCategory;

// const factory AdvisorState.loadingAlerts() = loadingAlerts;
//
// const factory AdvisorState.sucessLoadAlerts(T data) = SucessLoadAlerts;
//
// const factory AdvisorState.errorLoadAlerts(String error) = ErrorLoadAlerts;

  const factory AdvisorState.loading() = Loading;

  const factory AdvisorState.loaded(T data) = Loaded;

  const factory AdvisorState.error(String error) = Error;


}
