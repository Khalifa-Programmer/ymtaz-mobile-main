import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/model/my_lawyers_response.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState<T> with _$MyPageState<T> {
  const factory MyPageState.initial() = _Initial;

  const factory MyPageState.loading() = _Loading;

  const factory MyPageState.error(dynamic error) = _Error;

  const factory MyPageState.success(T data) = _Success;

  const factory MyPageState.loadingMyClients() = LoadingMyClients;

  const factory MyPageState.loadedMyClients(MyLawyersResponse data) =
      LoadedMyClients;

  const factory MyPageState.errorMyClients(String message) = ErrorMyClients;
}
