import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
    debugPrint("register request: $loginRequestBody"); 
    final response = await _registerRepo.register(loginRequestBody);
    debugPrint("register response: $response");
    response.when(success: (loginResponse) {
      // Extract account_type from response data
      String typeFromResponse = 'client'; // default
      if (loginResponse.data != null && loginResponse.data is Map) {
        debugPrint("register response data: ${loginResponse.data}"); 
        final dataMap = loginResponse.data as Map<String, dynamic>;
        debugPrint("register response data map: $dataMap");  
        if (dataMap.containsKey('account') && dataMap['account'] is Map) {  
          final accountMap = dataMap['account'] as Map<String, dynamic>;
          debugPrint("register response account map: $accountMap");  
          typeFromResponse = accountMap['account_type'] ?? 'client';
          debugPrint("register response type from response: $typeFromResponse");   
        }
      }
      emit(RegisterSuccess(loginResponse.message!, typeFromResponse));
    }, failure: (fail) {
      debugPrint("register failure: $fail"); 
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

String extractErrors(dynamic errorData) {
  if (errorData == null) return 'حدث خطأ ما مراجعة البيانات';

  if (errorData is! Map<String, dynamic>) {
    return errorData.toString();
  }

  // 1. Check if 'errors' exists and is a map (typical Laravel structure)
  final errorsMap = errorData['errors'] as Map<String, dynamic>?;
  if (errorsMap != null && errorsMap.isNotEmpty) {
    final errorMessages = <String>[];

    // Iterate through each field and collect its error messages
    errorsMap.forEach((field, messages) {
      if (messages is List && messages.isNotEmpty) {
        final formattedMessages =
            messages.map((msg) => msg.toString()).join('\n');
        errorMessages.add(formattedMessages);
      } else if (messages is String) {
        errorMessages.add(messages);
      }
    });

    if (errorMessages.isNotEmpty) {
      return errorMessages.join('\n');
    }
  }

  // 2. Check for nested 'data' field (some of our older APIs use this)
  if (errorData['data'] != null && errorData['data'] is Map<String, dynamic>) {
    return extractErrors(errorData['data']);
  }

  // 3. Check for top-level 'message' field
  if (errorData['message'] != null &&
      errorData['message'].toString().isNotEmpty) {
    return errorData['message'].toString();
  }

  // 4. Fallback to a generic error message
  return 'حدث خطأ ما مراجعة البيانات';
}
