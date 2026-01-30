import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_request_body.dart';
import 'package:yamtaz/feature/auth/login/data/repos/login_repo.dart';
import 'package:yamtaz/feature/auth/login/logic/login_state.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../layout/account/logic/my_account_cubit.dart';
import '../../../notifications/logic/notification_cubit.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final globalFormKey = GlobalKey<FormState>();
  bool rememberMe = false;
  
  // Loading state flags for social login buttons
  bool isGoogleLoading = false;
  bool isAppleLoading = false;

  // bool isClient = true;
  //
  // Future<void> emitLoginClientState(LoginRequestBody loginRequestBody) async {
  //   emit(const LoginState.loading());
  //   final response = await _loginRepo.loginClient(loginRequestBody);
  //   response.when(success: (loginResponse) {
  //     getit<MyAccountCubit>().sendFcmToken();
  //     emit(LoginState.success(loginResponse));
  //   }, failure: (fail) {
  //     emit(LoginState.error(error: fail['message']));
  //   });
  // }

  Future<void> emitLoginProviderState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());
    final response = await _loginRepo.loginProvider(loginRequestBody);
    response.when(success: (loginResponse) {
      if (loginResponse.status == false) {
        emit(LoginState.error(error: loginResponse.message ?? "Unknown Error"));
        return;
      }
      // Use optional chaining (?) instead of bang (!)
  final account = loginResponse.data?.account;
  
  if (account == null) {
    emit(const LoginState.error(error: "User data is missing from server response"));
    return;
  }
      debugPrint('loginResponse: ${account}');
      // Persist token (if present) before triggering dependent flows
      final token = loginResponse.data?.account?.token;
      if (token != null && token.isNotEmpty) {
        CacheHelper.saveData(key: 'token', value: token);
      }

      // Persist basic user info and userType for splash/profile checks
      final userId = loginResponse.data?.account?.id;
      final userName = loginResponse.data?.account?.name;
      final userEmail = loginResponse.data?.account?.email;
      if (userId != null) CacheHelper.saveData(key: 'userId', value: userId);
      if (userName != null) {
        CacheHelper.saveData(key: 'userName', value: userName);
      }
      if (userEmail != null) {
        CacheHelper.saveData(key: 'userEmail', value: userEmail);
      }
      CacheHelper.saveData(key: 'userType', value: 'provider');

      getit<MyAccountCubit>().sendFcmToken();
      getit<NotificationCubit>().getNotifications();
      emit(LoginState.successProvider(loginResponse));
    }, failure: (fail) {
      String errorMsg = 'Unknown error';
      if (fail is Map) {
        errorMsg = fail['message'] ?? 'Unknown error';
      } else if (fail is String) {
        errorMsg = fail;
      }
      emit(LoginState.error(error: errorMsg));
    });
  }

  // visitor login (Google Sign In)
  Future<void> emitVisitorLoginState(context, token) async {
    // String? token = await AppServices().signInWithGoogle(context);
    emit(const LoginState.visitorLoading());
    final response = await _loginRepo.visitorLogin(token ?? "");
    response.when(success: (visitorLogin) {
      emit(LoginState.visitorSuccess(visitorLogin));
    }, failure: (fail) {
      emit(LoginState.visitorError(error: fail['message']));
    });
  }

  // Apple Sign In
  Future<void> emitAppleLoginState(context, String token) async {
    emit(const LoginState.visitorLoading());
    
    debugPrint('Sending Apple identity token to backend: $token');
    
    final response = await _loginRepo.appleLogin(token);
    response.when(
      success: (appleLoginResponse) {
        debugPrint('Apple sign in successful');
        // Save user data and set up notification services if needed
        getit<MyAccountCubit>().sendFcmToken();
        getit<NotificationCubit>().getNotifications();
        emit(LoginState.appleSuccess(appleLoginResponse));
      }, 
      failure: (error) {
        debugPrint('Apple sign in failed: ${error['message']}');
        emit(LoginState.visitorError(error: error['message'] ?? 'Failed to login with Apple'));
      }
    );
  }

  void changeRemember() {
    rememberMe = !rememberMe;
    emit(const LoginState.changeValues());
  }

// void changeUserType(bool bool) {
//   isClient = bool;
//   emit(const LoginState.changeValues());
// }
}
