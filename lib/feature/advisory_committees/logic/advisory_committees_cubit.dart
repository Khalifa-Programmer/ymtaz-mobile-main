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
    // Reset old data
    lawyerAdvisoryServicesResponseModel = null;
    lawyerServicesResponseModel = null;
    
    emit(const AdvisoryCommitteesState.loadingGetLawyerAdvisory());

    try {
      final result = await _advisoryCommitteesRepo.getLawyerData(id);

      bool hasData = false;
      for (var apiResult in result) {
        apiResult.when(
          success: (data) {
            if (data is LawyerAdvisoryServicesResponseModel) {
              lawyerAdvisoryServicesResponseModel = data;
              hasData = true;
            } else if (data is LawyerServicesResponseModel) {
              lawyerServicesResponseModel = data;
              hasData = true;
            }
          },
          failure: (error) {
            // Log or handle individual failure if needed
          },
        );
      }

      // Even if one failed, if we have some data, we consider it loaded
      if (hasData) {
        // We emit the loaded state. Since the state only takes one model, 
        // we pass the advisory one if available, otherwise we use a dummy or handle in UI.
        // The UI in AdvisorScreen accesses the models directly from the cubit via getit,
        // so the specific object passed to the state doesn't matter as much as triggering the rebuild.
        emit(AdvisoryCommitteesState.loadedGetLawyerAdvisory(
            lawyerAdvisoryServicesResponseModel ?? lawyerAdvisoryServicesResponseModel ?? LawyerAdvisoryServicesResponseModel()
        ));
      } else {
        emit(const AdvisoryCommitteesState.errorGetLawyerAdvisory("Failed to load lawyer data"));
      }
    } catch (error) {
      emit(AdvisoryCommitteesState.errorGetLawyerAdvisory(error.toString()));
    }
  }

}
