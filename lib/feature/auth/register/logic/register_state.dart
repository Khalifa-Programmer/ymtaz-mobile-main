part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final String message;
  final String accountType; // 'client' or 'lawyer'

  RegisterSuccess(this.message, this.accountType);
}

final class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);
}

final class PhoneLoading extends RegisterState {}

final class PhoneValidationSuccess extends RegisterState {}

final class PhoneValidationError extends RegisterState {
  final String error;

  PhoneValidationError(this.error);
}

// sned otp

final class OtpLoading extends RegisterState {}

final class OtpSendSuccess extends RegisterState {}

final class OtpSendError extends RegisterState {
  final String error;

  OtpSendError(this.error);
}
