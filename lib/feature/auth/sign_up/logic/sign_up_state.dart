import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/core/shared/models/accurate_speecialties.dart';
import 'package:yamtaz/core/shared/models/degrees.dart';
import 'package:yamtaz/core/shared/models/functional_cases.dart';
import 'package:yamtaz/core/shared/models/general_specialty.dart';
import 'package:yamtaz/core/shared/models/lawyer_type.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/nationalities_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_provider_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_response_body.dart';
import 'package:yamtaz/feature/layout/account/data/models/user_data_model.dart';

import '../../login/data/models/login_provider_response.dart';
import '../../register/data/model/response_model.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState<T> with _$SignUpState<T> {
  const factory SignUpState.initial() = _Initial;

  const factory SignUpState.changeScreenValues() = ChangeScreenValues;

  const factory SignUpState.loading() = Loading;

  const factory SignUpState.success(SignUpResponse data) = Success<T>;

  const factory SignUpState.error({required String error}) = Error;

  const factory SignUpState.loadingSignUpProvider() = LoadingSignUpProvider;

  const factory SignUpState.successSignUpProvider(SignUpProviderResponse data) =
      SuccessSignUpProvider<T>;

  const factory SignUpState.errorSignUpProvider({required String error}) =
      ErrorSignUpProvider;

  const factory SignUpState.loadingSignUpProviderOtp() =
      LoadingSignUpProviderOtp;

  const factory SignUpState.successSignUpProviderOtp(ResponseModel data) =
      SuccessSignUpProviderOtp<T>;

  const factory SignUpState.errorSignUpProviderOtp({required String error}) =
      ErrorSignUpProviderOtp;

  const factory SignUpState.loadingSignUpProviderOtpEdit() =
      LoadingSignUpProviderOtpEdit;

  const factory SignUpState.successSignUpProviderOtpEdit(ResponseModel verify) =
      SuccessSignUpProviderOtpEdit<T>;

  const factory SignUpState.errorSignUpProviderOtpEdit(
      {required String error}) = ErrorSignUpProviderOtpEdit;

  //
  //
  // const factory SignUpState.successProvider(SignUpProviderResponse data) = SuccessProvider<T>;
  //
  // const factory SignUpState.errorProvider({required String error}) = ErrorProvider;

  const factory SignUpState.loadingVerify() = LoadingVerify;

  const factory SignUpState.successVerify(VerifypResponse data) =
      SuccessVerify<T>;

  const factory SignUpState.errorVerify({required String error}) = ErrorVerify;

  const factory SignUpState.loadingVerifyOtpEdit() = LoadingVerifyOtpEdit;

  const factory SignUpState.successVerifyOtpEdit(LoginResponse verify) =
      SuccessVerifyOtpEdit<T>;

  const factory SignUpState.errorVerifyOtpEdit({required String error}) =
      ErrorVerifyOtpEdit;

  const factory SignUpState.loadingCountries() = LoadingCountries;

  const factory SignUpState.successCountries(CountriesResponse data) =
      SuccessCountries<T>;

  const factory SignUpState.errorCountries({required String error}) =
      ErrorCountries;

  const factory SignUpState.loadingNationalities() = LoadingNationalities;

  const factory SignUpState.successNationalities(NationalitiesResponse data) =
      SuccessNationalities<T>;

  const factory SignUpState.errorNationalities({required String error}) =
      ErrorNationalities;

  const factory SignUpState.loadingGeneralSpecialty() = LoadingGeneralSpecialty;

  const factory SignUpState.successGeneralSpecialty(GeneralSpecialty data) =
      SuccessGeneralSpecialty<T>;

  const factory SignUpState.errorGeneralSpecialty({required String error}) =
      ErrorGeneralSpecialty;

  const factory SignUpState.loadingAccurateSpecialty() =
      LoadingAccurateSpecialty;

  const factory SignUpState.successAccurateSpecialty(AccurateSpecialties data) =
      SuccessAccurateSpecialty<T>;

  const factory SignUpState.errorAccurateSpecialty({required String error}) =
      ErrorAccurateSpecialty;

  const factory SignUpState.loadingDegrees() = LoadingDegrees;

  const factory SignUpState.successDegrees(Degrees data) = SuccessDegrees<T>;

  const factory SignUpState.errorDegrees({required String error}) =
      ErrorDegrees;

  const factory SignUpState.loadingSections() = LoadingSections;

  const factory SignUpState.successSections(SectionsType data) =
      SuccessSections<T>;

  const factory SignUpState.errorSections({required String error}) =
      ErrorSections;

  const factory SignUpState.loadingFunctionalCases() = LoadingFunctionalCases;

  const factory SignUpState.successFunctionalCases(FunctionalCases data) =
      SuccessFunctionalCases<T>;

  const factory SignUpState.errorFunctionalCases({required String error}) =
      ErrorFunctionalCases;

  const factory SignUpState.successImage() = SuccessImage;

  // lawyer types
  const factory SignUpState.loadingLawyerTypes() = LoadingLawyerTypes;

  const factory SignUpState.successLawyerTypes(LawyerTypes data) =
      SuccessLawyerTypes<T>;

  const factory SignUpState.errorLawyerTypes({required String error}) =
      ErrorLawyerTypes;

  // verify provider

  const factory SignUpState.loadingVerifyProvider() = LoadingVerifyProvider;

  const factory SignUpState.successVerifyProvider(VerifypResponse data) =
      SuccessVerifyProvider<T>;

  const factory SignUpState.errorVerifyProvider({required String error}) =
      ErrorVerifyProvider;

  const factory SignUpState.loadingVerifyProviderOtp() =
      LoadingVerifyProviderOtp;

  const factory SignUpState.successVerifyProviderOtp(VerifypResponse data) =
      SuccessVerifyProviderOtp<T>;

  const factory SignUpState.errorVerifyProviderOtp({required String error}) =
      ErrorVerifyProviderOtp;

  // image error
  const factory SignUpState.errorImage({required String error}) = ErrorImage;

  //edit provider
  const factory SignUpState.loadingEditProvider() = LoadingEditProvider;

  const factory SignUpState.successEditProvider(LoginProviderResponse data) =
      SuccessEditProvider<T>;

  const factory SignUpState.errorEditProvider({required String error}) =
      ErrorEditProvider;

  //get provider
  const factory SignUpState.loadingGetProvider() = LoadingGetProvider;

  const factory SignUpState.successGetProvider(UserDataResponse data) =
      SuccessGetProvider<T>;

  const factory SignUpState.errorGetProvider({required String error}) =
      ErrorGetProvider;

  // loading all data
  const factory SignUpState.loadingAllData() = LoadingAllData;

  const factory SignUpState.successAllData() = SuccessAllData<T>;

  const factory SignUpState.errorAllData({required String error}) =
      ErrorAllData;

  //load image from network
  const factory SignUpState.loadingImage() = LoadingImage;

  const factory SignUpState.successImageFromNetwork() = SuccessImageFromNetwork;

  const factory SignUpState.errorImageFromNetwork({required String error}) =
      ErrorImageFromNetwork;

  // resending otp
  const factory SignUpState.loadingResendOtp() = LoadingResendOtp;

  const factory SignUpState.successResendOtp(String error) =
      SuccessResendOtp<T>;

  const factory SignUpState.errorResendOtp({required String error}) =
      ErrorResendOtp<T>;
}
