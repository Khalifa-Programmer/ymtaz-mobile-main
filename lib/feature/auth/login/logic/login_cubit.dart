import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_request_body.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
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





  // Google Sign In
  Future<void> emitGoogleLoginState(context, Map<String, dynamic> socialInfo) async {
    // emit(const LoginState.visitorLoading()); // Removed to prevent blocking dialog

    // تخزين البيانات من جوجل مباشرة دون الذهاب للباك اند
    _saveToCache(
      // token: socialInfo['token'], // لا نخزن التوكن هنا لأنه ليس توكن صالح للباك اند
      userId: "google_${socialInfo['email']}", 
      userType: 'visitor',
      userName: socialInfo['name'],
      userEmail: socialInfo['email'],
      userImage: socialInfo['image'],
    );
    
    // تهيئة الكيوبيتس الأخرى
    // getit<MyAccountCubit>().sendFcmToken(); 
    // getit<NotificationCubit>().getNotifications();

    // الانتقال للشاشة الرئيسية
    Navigator.pushNamedAndRemoveUntil(
        context, Routes.homeLayout, (route) => false);
        
    // إرسال حالة النجاح
    emit(const LoginState.initial()); 
  }

  // Apple Sign In
  Future<void> emitAppleLoginState(context, Map<String, dynamic> socialInfo) async {
    emit(const LoginState.visitorLoading());
    
    final String? token = socialInfo['token'];
    final String? email = socialInfo['email'];
    final String? name = socialInfo['name'];

    debugPrint('Sending Apple identity token to backend: $token');
    
    final response = await _loginRepo.appleLogin(token ?? "");
    response.when(
      success: (appleLoginResponse) {
        debugPrint('Apple sign in successful');
        
        final visitor = appleLoginResponse.data?.visitor;

        // Save user data to cache
        _saveToCache(
          token: visitor?.token != null ? "Bearer ${visitor!.token}" : null,
          userId: visitor?.id?.toString(),
          userName: visitor?.name ?? name,
          userEmail: visitor?.email ?? email,
          userImage: visitor?.image,
          userType: 'visitor',
        );

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

  Future<void> emitLoginState(LoginRequestBody loginRequestBody) async {
    emit(const LoginState.loading());

    final response = await _loginRepo.login(loginRequestBody);

    response.when(
      success: (loginResponse) {
        // According to the JSON provided, the data contains 'user' and 'token'
        // In our model, 'account' handles 'user' key as well.
        final userData = loginResponse.data?.account; 
        
        if (loginResponse.status == true && userData != null) {
          final serverType = userData.accountType ?? ""; // 'lawyer' or 'client'
          final String userType = serverType == 'lawyer' ? 'provider' : 'client';

          // Save tokens and user info from the response
          _saveToCache(
            token: "Bearer ${userData.token ?? loginResponse.data?.token}",
            userId: userData.id,
            userName: userData.name,
            userEmail: userData.email,
            userType: userType,
          );
          
          if (serverType == 'lawyer') {
            getit<MyAccountCubit>().getProviderData();
            emit(LoginState.successProvider(loginResponse));
          } else {
            getit<MyAccountCubit>().getClientData();
            // Both lawyer and client now use LoginProviderResponse structure
            emit(LoginState.success(loginResponse));
          }
          
          getit<MyAccountCubit>().sendFcmToken();
          getit<NotificationCubit>().getNotifications();
        } else {
          emit(LoginState.error(error: loginResponse.message ?? "فشل تسجيل الدخول"));
        }
      },
      failure: (fail) {
        String errorMsg = 'فشل تسجيل الدخول';
        if (fail is Map) {
          errorMsg = fail['message'] ?? errorMsg;
        } else if (fail is String) {
          errorMsg = fail;
        }
        emit(LoginState.error(error: errorMsg));
      },
    );
  }

  void _saveToCache({
    String? token,
    String? userId,
    String? userName,
    String? userEmail,
    String? userImage,
    required String userType,
  }) {
    if (token != null) CacheHelper.saveData(key: 'token', value: token);
    if (userId != null) CacheHelper.saveData(key: 'userId', value: userId);
    if (userName != null) CacheHelper.saveData(key: 'userName', value: userName);
    if (userEmail != null) CacheHelper.saveData(key: 'userEmail', value: userEmail);
    if (userImage != null) CacheHelper.saveData(key: 'userImage', value: userImage);
    CacheHelper.saveData(key: 'userType', value: userType);
  }

  void changeRemember() {
    rememberMe = !rememberMe;
    emit(const LoginState.changeValues());
  }


}
