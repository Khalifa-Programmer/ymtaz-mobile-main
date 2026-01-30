import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../data/repo/register_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;

  RegisterCubit(this._registerRepo) : super(RegisterInitial());

  Map<String, String> gender = {
    'ذكر': "Male",
    'أنثى': "Female",
  };

  Future<void> register(FormData loginRequestBody) async {
    emit(RegisterLoading());
    final response = await _registerRepo.register(loginRequestBody);
    response.when(success: (loginResponse) {
      emit(RegisterSuccess(loginResponse.message!));
    }, failure: (fail) {
      emit(RegisterFailure(extractErrors(fail)));
    });
  }

  Future<void> validatePhone(String phone, String ccode) async {
    emit(OtpLoading());
    final response = await _registerRepo.validatePhone(phone, ccode);
    response.when(success: (responseModel) {
      emit(OtpSendSuccess());
    }, failure: (fail) {
      emit(OtpSendError(extractErrors(fail)));
    });
  }

  Future<void> verifyPhoneOtp(String phone, String ccode, String code) async {
    emit(PhoneLoading());
    final response = await _registerRepo.verifyPhoneOtp(phone, ccode, code);
    response.when(success: (responseModel) {
      emit(PhoneValidationSuccess());
    }, failure: (fail) {
      emit(PhoneValidationError(fail['message'].toString()));
    });
  }
}

String extractErrors(Map<String, dynamic>? errorData) {
  if (errorData == null || !errorData.containsKey('data')) {
    return 'حدث خطأ ما يرجى راجع البيانات';
  }

  final data = errorData['data'] as Map<String, dynamic>?;

  if (data == null || !data.containsKey('errors')) {
    return 'حدث خطأ ما يرجى راجع البيانات';
  }

  final errorsMap = data['errors'] as Map<String, dynamic>?;

  if (errorsMap == null || errorsMap.isEmpty) {
    return 'حدث خطأ ما يرجى راجع البيانات';
  }

  final errorMessages = <String>[];
  errorsMap.forEach((field, messages) {
    if (messages is List && messages.isNotEmpty) {
      final formattedMessages = messages.map((msg) => ' $msg').join('\n');
      errorMessages.add(formattedMessages);
    }
  });

  return errorMessages.join('\n');
}
