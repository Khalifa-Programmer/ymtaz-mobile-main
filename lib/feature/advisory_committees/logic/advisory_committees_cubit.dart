import 'package:bloc/bloc.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';
import 'package:yamtaz/feature/advisory_committees/data/repos/advisory_committees_repo.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_state.dart';
import 'package:yamtaz/feature/digital_guide/data/model/lawyer_services_response_model.dart';

import '../../advisory_services/data/model/lawyer_advisory_services.dart';
import '../data/model/advisory_committees_response.dart';

class AdvisoryCommitteesCubit extends Cubit<AdvisoryCommitteesState> {
  final AdvisoryCommitteesRepo _advisoryCommitteesRepo;

  AdvisoryCommitteesCubit(this._advisoryCommitteesRepo)
      : super(const AdvisoryCommitteesState.initial());

  AdvisoryCommitteesResponse? advisoryCommitteesResponse;

  void loadAdvisoryCommitteesData() {
      loadAdvisoryCommittees();

  }

  void loadAdvisoryCommittees() async {
    emit(const AdvisoryCommitteesState.loadingCommittees());
    final result = await _advisoryCommitteesRepo.getAdvisoryCommittees();
    result.when(
      success: (data) {
        advisoryCommitteesResponse = data;
        emit(AdvisoryCommitteesState.loadedCommittees(data));
      },
      failure: (error) {
        emit(AdvisoryCommitteesState.errorCommittees(error));
      },
    );
  }

  AdvisoryCommitteesLawyersResponse? advisoryCommitteesLawyersResponse;

  void loadLawyers(String committeeId) async {
    emit(const AdvisoryCommitteesState.loadingLawyers());
    final result = await _advisoryCommitteesRepo
        .getAdvisoryCommitteeLawyersById(committeeId);
    result.when(
      success: (data) {
        advisoryCommitteesLawyersResponse = data;
        emit(AdvisoryCommitteesState.loadedLawyers(data));
      },
      failure: (error) {
        emit(AdvisoryCommitteesState.errorLawyers(error));
      },
    );
  }

  LawyerAdvisoryServicesResponseModel? lawyerAdvisoryServicesResponseModel;
  LawyerServicesResponseModel? lawyerServicesResponseModel;
  void getLawyerdatabtid(String id) async {
    emit(const AdvisoryCommitteesState.loadingGetLawyerAdvisory());

    try {
      final result = await _advisoryCommitteesRepo.getLawyerData(id);

      for (var apiResult in result) {
        apiResult.when(
          success: (data) {
            if (data is LawyerAdvisoryServicesResponseModel) {
              lawyerAdvisoryServicesResponseModel = data;
            } else if (data is LawyerServicesResponseModel) {
              lawyerServicesResponseModel = data;
            }
          },
          failure: (error) {
            emit(AdvisoryCommitteesState.errorGetLawyerAdvisory(error));
          },
        );
      }

      emit(AdvisoryCommitteesState.loadedGetLawyerAdvisory(lawyerAdvisoryServicesResponseModel!));
    } catch (error) {
      emit(AdvisoryCommitteesState.errorGetLawyerAdvisory(error.toString()));
    }
  }

}
