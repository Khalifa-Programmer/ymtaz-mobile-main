import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/visitor_login.dart';

import '../../../../core/models/base_response.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState<T> with _$LoginState<T> {
  const factory LoginState.initial() = _Initial;

  const factory LoginState.changeValues() = ChangeValues;

  const factory LoginState.loading() = Loading;

  const factory LoginState.success(LoginProviderResponse data) = Success<T>;

  const factory LoginState.successProvider(LoginProviderResponse data) =
      SuccessProvider<T>;

  const factory LoginState.error({required String error}) = Error;

  // visitor login
  const factory LoginState.visitorLoading() = VisitorLoading;

  const factory LoginState.visitorSuccess(VisitorLogin data) =
      VisitorSuccess<T>;

  const factory LoginState.appleSuccess(VisitorLogin data) =
  AppleSuccess<T>;

  const factory LoginState.visitorError({required String error}) = VisitorError;
}
