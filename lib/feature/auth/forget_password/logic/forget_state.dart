import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_response_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/forget_response_body.dart';

import '../../login/data/models/login_response.dart';

part 'forget_state.freezed.dart';

@freezed
class ForgetState<T> with _$ForgetState<T> {
  const factory ForgetState.initial() = _Initial;

  const factory ForgetState.loadingEmailCheck() = LoadingEmailCheck;

  const factory ForgetState.successEmailCheck(ForgetResponse data) =
      SuccessEmailCheck<T>;

  const factory ForgetState.errorEmailCheck({required String error}) =
      ErrorEmailCheck;

  const factory ForgetState.loadingCodeCheck() = LoadingCodeCheck;

  const factory ForgetState.successCodeCheck(CheckCodeResponse data) =
      SuccessCodeCheck<T>;

  const factory ForgetState.errorCodeCheck({required String error}) =
      ErrorCodeCheck;

  const factory ForgetState.loadingReset() = LoadingReset;

  const factory ForgetState.successReset(LoginResponse data) = SuccessReset<T>;

  const factory ForgetState.errorReset({required String error}) = ErrorReset;
}
