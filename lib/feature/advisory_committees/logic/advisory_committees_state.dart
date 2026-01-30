import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_response.dart';

import '../../advisory_services/data/model/lawyer_advisory_services.dart';

part 'advisory_committees_state.freezed.dart';

@freezed
class AdvisoryCommitteesState<T> with _$AdvisoryCommitteesState<T> {
  const factory AdvisoryCommitteesState.initial() = _Initial;

  const factory AdvisoryCommitteesState.loadingCommittees() = LoadingCommittees;

  const factory AdvisoryCommitteesState.loadedCommittees(
      AdvisoryCommitteesResponse data) = LoadedCommittees;

  const factory AdvisoryCommitteesState.errorCommittees(String error) =
      ErrorCommittees;

  const factory AdvisoryCommitteesState.loadingLawyers() = LoadingLawyers;

  const factory AdvisoryCommitteesState.loadedLawyers(
      AdvisoryCommitteesLawyersResponse data) = LoadedLawyers;

  const factory AdvisoryCommitteesState.errorLawyers(String error) =
      ErrorLawyers;

  const factory AdvisoryCommitteesState.loadingGetLawyerAdvisory() =
      LoadingGetLawyerAdvisory;

  const factory AdvisoryCommitteesState.loadedGetLawyerAdvisory(
      LawyerAdvisoryServicesResponseModel data) = LoadedGetLawyerAdvisory;

  const factory AdvisoryCommitteesState.errorGetLawyerAdvisory(String error) =
      ErrorGetLawyerAdvisory;
}
