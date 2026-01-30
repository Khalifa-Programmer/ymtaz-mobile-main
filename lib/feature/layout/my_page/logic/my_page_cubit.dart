import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/last_added.dart';
import 'package:yamtaz/feature/layout/my_page/data/repos/my_page_repo.dart';
import 'package:yamtaz/feature/layout/my_page/logic/my_page_state.dart';

import '../data/model/my_page_response_model.dart';

class MyPageCubit extends Cubit<MyPageState> {
  final MyPageRepo _myPageRepo;

  MyPageCubit(this._myPageRepo) : super(const MyPageState.initial());

  MyPageResponseModel? myPageResponseModel;
  LastAdded? lastAddedModel;

  getMyPageData() {
    getMyPageClient();
    lastAdded();
  }

  void getMyPageClient() async {
    emit(const MyPageState.loading());
    final result = await _myPageRepo.getMyPageClient();
    result.whenOrNull(
      success: (data) {
        myPageResponseModel = data;
        emit(MyPageState.success(data));
      },
      failure: (error) {
        emit(MyPageState.error(error));
      },
    );
  }

  void lastAdded() async {
    emit(const MyPageState.loading());
    final result = await _myPageRepo.myLastAdded();
    result.whenOrNull(
      success: (data) {
        lastAddedModel = data;
        emit(MyPageState.success(data));
      },
      failure: (error) {
        emit(MyPageState.error(error));
      },
    );
  }

  Future<void> getMyLawyers() async {
    emit(const MyPageState.loadingMyClients());
    final result = await _myPageRepo.getMyLawyers();
    result.whenOrNull(
      success: (data) {
        emit(MyPageState.loadedMyClients(data));
      },
      failure: (message) {
        emit(MyPageState.errorMyClients(message));
      },
    );
  }
}
