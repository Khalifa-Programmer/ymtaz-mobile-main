part of 'advisory_cubit.dart';

@immutable
sealed class AdvisoryState {}

final class AdvisoryInitial extends AdvisoryState {}

final class AdvisoryStepChanged extends AdvisoryState {
  final int step;

  AdvisoryStepChanged(this.step);
}

final class AdvisoryTypesLoading extends AdvisoryState {}

final class AdvisoryStateUpdated extends AdvisoryState {}

final class AdvisoryTypesLoaded extends AdvisoryState {
  final AdvisoriesCategoriesTypes data;

  AdvisoryTypesLoaded(this.data);
}

final class AdvisoryTypesError extends AdvisoryState {
  final dynamic error;

  AdvisoryTypesError(this.error);
}

final class AdvisoryGeneralTypesLoading extends AdvisoryState {}

final class AdvisoryGeneralTypesLoaded extends AdvisoryState {
  final AdvisoriesGeneralSpecialization data;

  AdvisoryGeneralTypesLoaded(this.data);
}

final class AdvisoryGeneralTypesError extends AdvisoryState {
  final dynamic error;

  AdvisoryGeneralTypesError(this.error);
}

final class AdvisoryAccurateTypesLoading extends AdvisoryState {}

final class AdvisoryAccurateTypesLoaded extends AdvisoryState {
  final AdvisoriesAccurateSpecialization data;

  AdvisoryAccurateTypesLoaded(this.data);
}

final class AdvisoryAccurateTypesError extends AdvisoryState {
  final dynamic error;

  AdvisoryAccurateTypesError(this.error);
}

final class AdvisoryTypeLawyersLoading extends AdvisoryState {}

final class AdvisoryTypeLawyersLoaded extends AdvisoryState {
  final lawyer.AvailableLawyersForAdvisoryTypeModel data;

  AdvisoryTypeLawyersLoaded(this.data);
}

final class AdvisoryTypeLawyersError extends AdvisoryState {
  final dynamic error;

  AdvisoryTypeLawyersError(this.error);
}

final class AdvisorDatesLoading extends AdvisoryState {}

final class AdvisorDatesLoaded extends AdvisoryState {}

final class AdvisorDatesError extends AdvisoryState {
  final dynamic error;

  AdvisorDatesError(this.error);
}

final class AdvisorReservationLoading extends AdvisoryState {}

final class AdvisorReservationLoaded extends AdvisoryState {
  final AdvisoryRequestResponse data;

  AdvisorReservationLoaded(this.data);
}

final class AdvisorReservationError extends AdvisoryState {
  final dynamic error;

  AdvisorReservationError(this.error);
}

final class LoadingMyReservation extends AdvisoryState {}

final class LoadedMyReservation extends AdvisoryState {}

final class ErrorMyReservation extends AdvisoryState {
  final dynamic error;

  ErrorMyReservation(this.error);
}
