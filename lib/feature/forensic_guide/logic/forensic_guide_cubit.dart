import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';
import 'package:yamtaz/feature/forensic_guide/data/repo/forensic_repo.dart';
import 'package:yamtaz/feature/forensic_guide/logic/forensic_guide_state.dart';

class ForensicGuideCubit extends Cubit<ForensicGuideState> {
  final ForensicRepo _forensicRepo;

  ForensicGuideCubit(this._forensicRepo)
      : super(const ForensicGuideState.initial());

  JudicialGuideResponseModel? judicialGuideResponseModel;

  void getJudicialGuide() async {
    emit(const ForensicGuideState.loading());
    final result = await _forensicRepo.getDigitalGuide();
    result.when(
      success: (data) {
        judicialGuideResponseModel = data;
        emit(ForensicGuideState.loaded(data));
      },
      failure: (error) {
        emit(ForensicGuideState.error(error));
      },
    );
  }
}
