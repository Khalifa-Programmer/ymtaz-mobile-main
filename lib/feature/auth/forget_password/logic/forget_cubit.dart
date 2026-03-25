import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/forget_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/reset_password_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/logic/forget_state.dart';

import '../data/repos/forget_password_repo.dart';

class ForgetCubit extends Cubit<ForgetState> {
  ForgetCubit(this._forgetPasswordRepo) : super(const ForgetState.initial());
  final ForgetPasswordRepo _forgetPasswordRepo;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isTimerFinished = false;

  final globalFormKey = GlobalKey<FormState>();

  Future<void> emitForgetPass(ForgetRequestBody forgetRequestBody) async {
    emit(const ForgetState.loadingEmailCheck());
    final response =
        await _forgetPasswordRepo.forgetPasswordClient(forgetRequestBody);

    response.when(success: (countriesResponse) {
      emit(ForgetState.successEmailCheck(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorEmailCheck(
          error: extractErrors(fail?.response?.data)));
    });
  }

  Future<void> emitVerifyCode(CheckCodeRequestBody checkCodeRequestBody) async {
    emit(const ForgetState.loadingCodeCheck());
    final response =
        await _forgetPasswordRepo.verifyForgetClient(checkCodeRequestBody);

    response.when(success: (countriesResponse) {
      emit(ForgetState.successCodeCheck(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorCodeCheck(
          error: extractErrors(fail?.response?.data)));
    });
  }

  Future<void> emitResetPass(
      ResetPasswordRequestBody resetPasswordRequestBody) async {
    emit(const ForgetState.loadingReset());
    final response =
        await _forgetPasswordRepo.resetPasswordClient(resetPasswordRequestBody);
    response.when(success: (countriesResponse) {
      emit(ForgetState.successReset(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorReset(error: extractErrors(fail?.response?.data)));
    });
  }

  // forget pass lawyer
  Future<void> emitForgetPassLawyer(String email) async {
    emit(const ForgetState.loadingEmailCheck());
    final response = await _forgetPasswordRepo.forgetPasswordLawyer(email);

    response.when(success: (countriesResponse) {
      emit(ForgetState.successEmailCheck(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorEmailCheck(
          error: extractErrors(fail?.response?.data)));
    });
  }

  // verify lawyer

  Future<void> emitVerifyCodeLawyer(
      CheckCodeRequestBody checkCodeRequestBody) async {
    emit(const ForgetState.loadingCodeCheck());
    final response =
        await _forgetPasswordRepo.verifyForgetLawyer(checkCodeRequestBody);

    response.when(success: (countriesResponse) {
      emit(ForgetState.successCodeCheck(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorCodeCheck(
          error: extractErrors(fail?.response?.data)));
    });
  }

  // reset pass lawyer

  Future<void> emitResetPassLawyer(
      ResetPasswordRequestBody resetPasswordRequestBody) async {
    emit(const ForgetState.loadingReset());
    final response =
        await _forgetPasswordRepo.resetPasswordLawyer(resetPasswordRequestBody);
    response.when(success: (countriesResponse) {
      emit(ForgetState.successReset(countriesResponse));
    }, failure: (fail) {
      emit(ForgetState.errorReset(error: extractErrors(fail?.response?.data)));
    });
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

    // 2. Check for nested 'data' field
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
}
