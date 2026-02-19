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

  String extractErrors(Map<String, dynamic>? errorData) {
    if (errorData == null || !errorData.containsKey('data')) {
      return 'حدث خطأ ما يرجى مراجعة البيانات';
    }

    final data = errorData['data'] as Map<String, dynamic>?;

    if (data == null || !data.containsKey('errors')) {
      return 'حدث خطأ ما يرجى مراجعة البيانات';
    }

    final errorsMap = data['errors'] as Map<String, dynamic>?;

    if (errorsMap == null || errorsMap.isEmpty) {
      return 'حدث خطأ ما يرجى مراجعة البيانات';
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
}
