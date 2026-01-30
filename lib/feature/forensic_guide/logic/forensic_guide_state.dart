import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';

part 'forensic_guide_state.freezed.dart';

@freezed
class ForensicGuideState<T> with _$ForensicGuideState {
  const factory ForensicGuideState.initial() = _Initial;

  const factory ForensicGuideState.loading() = Loading;

  const factory ForensicGuideState.loaded(JudicialGuideResponseModel data) =
      Loaded;

  const factory ForensicGuideState.error(String message) = Error;
}
