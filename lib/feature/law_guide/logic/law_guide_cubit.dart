import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_search_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_sub_main_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_response.dart';
import 'package:yamtaz/feature/law_guide/data/repo/law_guide_repo.dart';

import '../data/model/law_by_id_response.dart';
import '../data/model/law_guide_main_response.dart';

part 'law_guide_state.dart';

class LawGuideCubit extends Cubit<LawGuideState> {
  final LawGuideRepo _advisorRepo;

  LawGuideCubit(this._advisorRepo) : super(LawGuideInitial());
  LawGuideSubMainResponse? lawGuideSubMainResponse;
  LawGuideMainResponse? lawGuideMainResponse;
  LawResponse? lawResponse;
  LawGuideSearchResponse? lawGuideSearchResponse;

  void getLawGuide() async {
    lawGuideMainResponse = null;
    emit(LawGuideLoading());
    try {
      final response = await _advisorRepo.getLawGuide();
      response.when(
        success: (data) {
          lawGuideMainResponse = data;
          emit(LawGuideLoaded());
        },
        failure: (error) {
          emit(LawGuideError(error));
        },
      );
    } catch (e) {
      emit(LawGuideError("error while store data"));
    }
  }

  void getLawGuideSubFromMain(String id) async {
    lawGuideSubMainResponse = null;
    emit(LawGuideLoading());
    try {
      final response = await _advisorRepo.getLawGuideSubFromMain(id);
      response.when(
        success: (data) {
          lawGuideSubMainResponse = data;
          emit(LawGuideLoaded());
        },
        failure: (error) {
          emit(LawGuideError(error));
        },
      );
    } catch (e) {
      emit(LawGuideError("error while store data"));
    }
  }

  int currentPage = 1;
  bool isLastPage = false;
  bool isLoading = false; //
  bool isLoadingMore = false; // حالة تحميل المزيد

  Future<void> getLawsGuideSubFromSub(String subId,
      {bool loadMore = false}) async {
    if (!loadMore) {
      lawResponse = null;
      currentPage = 1;
      isLastPage = false;
    }
    if (isLastPage || isLoading) return; // تأكد من عدم وجود تحميلات متزامنة
    isLoading = !loadMore; // تعيين حالة التحميل
    isLoadingMore = loadMore; // تعيين حالة تحميل المزيد
    emit(loadMore ? LawGuideLoadingMore() : LawGuideLoading());

    try {
      final response =
          await _advisorRepo.getLawsGuideSubFromSub(subId, 40, currentPage);
      response.when(
        success: (data) {
          if (loadMore && lawResponse != null) {
            final newLaws =
                List<Datum>.from(lawResponse!.data!.lawGuide!.laws!.data!)
                  ..addAll(data.data!.lawGuide!.laws!.data!);

            lawResponse = lawResponse!.copyWith(
              data: lawResponse!.data!.copyWith(
                lawGuide: lawResponse!.data!.lawGuide!.copyWith(
                  laws: lawResponse!.data!.lawGuide!.laws!.copyWith(
                    data: newLaws,
                  ),
                ),
              ),
            );
          } else {
            lawResponse = data;
          }

          currentPage++;
          isLastPage = data.data!.lawGuide!.laws!.data!.isEmpty;
          emit(LawGuideLoaded());
        },
        failure: (error) {
          emit(LawGuideError(error));
        },
      );
    } catch (e) {
      emit(LawGuideError("error while storing data"));
    } finally {
      isLoading = false; // إعادة تعيين حالة التحميل
      isLoadingMore = false; // إعادة تعيين حالة تحميل المزيد
    }
  }

  LawByIdResponse? lawByIdResponse;

  void getLawById(String id) async {
    lawByIdResponse = null;
    emit(LawGuideLoading());
    try {
      final response = await _advisorRepo.getLawById(id);
      response.when(
        success: (data) {
          lawByIdResponse = data;
          emit(LawGuideLoaded());
        },
        failure: (error) {
          emit(LawGuideError(error));
        },
      );
    } catch (e) {
      emit(LawGuideError("error while store data"));
    }
  }

  void searchLawGuide(FormData data) async {
    lawGuideSearchResponse = null;
    emit(LawGuideLoading());
    try {
      final response = await _advisorRepo.searchLawGuide(data);
      response.when(
        success: (data) {
          lawGuideSearchResponse = data;
          emit(LawGuideLoaded());
        },
        failure: (error) {
          emit(LawGuideError(error));
        },
      );
    } catch (e) {
      emit(LawGuideError("error while store data"));
    }
  }

  void clearData() {
    lawGuideMainResponse = null;
    lawGuideSubMainResponse = null;
    lawResponse = null;
    lawGuideSearchResponse = null;
  }

  void clearsearch() {
    lawGuideSearchResponse = null;
  }

  void nextLaw() {
    emit(LawGuideNext());
  }
}
