import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/digital_guide/data/model/fast_search_response_model.dart';

part 'digital_guide_state.freezed.dart';

@freezed
class DigitalGuideState<T> with _$DigitalGuideState<T> {
  const factory DigitalGuideState.initial() = _Initial;

  // GET LAWYER ADVISORY BY ID

  const factory DigitalGuideState.loadingGetLawyerAdvisory() =
      LoadingGetLawyerAdvisory;

  const factory DigitalGuideState.errorGetLawyerAdvisory(String message) =
      ErrorGetLawyerAdvisory;

  // add lawyer to favorite

  const factory DigitalGuideState.loadingAddLawyerToFavorite() =
      LoadingAddLawyerToFavorite;

  const factory DigitalGuideState.loadedAddLawyerToFavorite() =
      LoadedAddLawyerToFavorite;

  const factory DigitalGuideState.errorAddLawyerToFavorite(String message) =
      ErrorAddLawyerToFavorite;

  // fast search data

  const factory DigitalGuideState.loadingFastSearch() = LoadingFastSearch;

  const factory DigitalGuideState.loadedFastSearch(
      FastSearchResponseModel data) = LoadedFastSearch;

  const factory DigitalGuideState.errorFastSearch(String message) =
      ErrorFastSearch;
}
