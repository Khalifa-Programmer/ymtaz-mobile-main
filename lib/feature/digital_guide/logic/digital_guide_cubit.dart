import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_guide_response.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_search_response_model.dart';
import 'package:yamtaz/feature/digital_guide/data/model/fast_search_response_model.dart';
import 'package:yamtaz/feature/digital_guide/data/model/lawyer_model.dart';
import 'package:yamtaz/feature/digital_guide/data/repos/digital_guide_repo.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_state.dart';


class DigitalGuideCubit extends Cubit<DigitalGuideState> {
  final DigitalGuideRepo _digitalGuideRepo;

  DigitalGuideCubit(this._digitalGuideRepo)
      : super(const DigitalGuideState.initial());
  LawyerModel? lawyerModel;

  void getLawyerData(String id) async {
    lawyerModel = null;
    emit(const DigitalGuideState.loadingGetLawyerAdvisory());
    final result = await _digitalGuideRepo.getLawyerDataById(id);
    result.when(
      success: (data) {
        lawyerModel = data;
        emit(DigitalGuideState.loadedAddLawyerToFavorite());
      },
      failure: (error) {
        emit(DigitalGuideState.errorGetLawyerAdvisory(error.toString()));
      },
    );
  }

  FastSearchResponseModel? fastSearchResponseModel;

  void fastSearchDigitalGuideClient(String name) async {
    emit(const DigitalGuideState.loadingFastSearch());
    final result = await _digitalGuideRepo.fastSearchDigitalGuideClient(name);
    result.when(
      success: (data) {
        fastSearchResponseModel = data;
        emit(DigitalGuideState.loadedFastSearch(data));
      },
      failure: (error) {
        emit(DigitalGuideState.errorFastSearch(error));
      },
    );
  }

  DigitalGuideResponse? digitalGuideResponse;
  void getDigitalGuide() async {

    emit(const DigitalGuideState.loadingGetDigi());
    final result = await _digitalGuideRepo.getDigitalGuide();
    result.when(
      success: (data) {
        digitalGuideResponse = data;
        emit(DigitalGuideState.loadedGetDigi(data));
      },
      failure: (error) {
        emit(DigitalGuideState.errorGetDigi(error.toString()));
      },
    );
  }

  DigitalSearchResponseModel? digitalSearchResponseModel;
  void getSearchDigitalGuide(FormData body) async {
    emit(const DigitalGuideState.loadingSearchDigi());
    final result = await _digitalGuideRepo.searchDigitalGuideClient(body);
    result.when(
      success: (data) {
        digitalSearchResponseModel = data;
        emit(DigitalGuideState.loadedSearchDigi(data));
      },
      failure: (error) {
        emit(DigitalGuideState.errorSearchDigi(error.toString()));
      },
    );
  }
}

