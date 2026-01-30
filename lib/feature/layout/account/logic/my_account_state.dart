import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/layout/account/data/models/iban_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/invites_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/my_payments_response.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/data/models/remove_response.dart';

import '../../../auth/login/data/models/login_provider_response.dart';
import '../../../auth/register/data/model/response_model.dart';
import '../data/models/experience_model.dart';
import '../data/models/points_rules.dart';

part 'my_account_state.freezed.dart';

@freezed
class MyAccountState<T> with _$MyAccountState<T> {
  const factory MyAccountState.initial() = _Initial;

  //get provider
  const factory MyAccountState.loadingGetProvider() = LoadingGetProvider;

  const factory MyAccountState.successGetProvider(LoginProviderResponse data) =
      SuccessGetProvider<T>;

  const factory MyAccountState.errorGetProvider({required String error}) =
      ErrorGetProvider;

  //get client
  const factory MyAccountState.loadingGetClient() = LoadingGetClient;

  const factory MyAccountState.successGetClient(LoginProviderResponse data) =
      SuccessGetClient<T>;

  const factory MyAccountState.errorGetClient({required String error}) =
      ErrorGetClient;

  const factory MyAccountState.loadingSignUpProviderOtp() =
      LoadingSignUpProviderOtp;

  const factory MyAccountState.successSignUpProviderOtp(ResponseModel data) =
      SuccessSignUpProviderOtp<T>;

  const factory MyAccountState.errorSignUpProviderOtp({required String error}) =
      ErrorSignUpProviderOtp;

  const factory MyAccountState.loadingSignUpProviderOtpEdit() =
      LoadingSignUpProviderOtpEdit;

  const factory MyAccountState.successSignUpProviderOtpEdit(
      ResponseModel verify) = SuccessSignUpProviderOtpEdit<T>;

  const factory MyAccountState.errorSignUpProviderOtpEdit(
      {required String error}) = ErrorSignUpProviderOtpEdit;

  // get AccountExperience
  const factory MyAccountState.loadingGetAccountExperience() =
      LoadingGetAccountExperience;

  const factory MyAccountState.successGetAccountExperience(
      ExperienceModel data) = SuccessGetAccountExperience<T>;

  const factory MyAccountState.errorGetAccountExperience(
      {required String error}) = ErrorGetAccountExperience;

  // get payout iban
  const factory MyAccountState.loadingGetPayoutIban() = LoadingGetPayoutIban;

  const factory MyAccountState.successGetPayoutIban(IbanModel data) =
      SuccessGetPayoutIban<T>;

  const factory MyAccountState.errorGetPayoutIban({required String error}) =
      ErrorGetPayoutIban;

  // edit client
  const factory MyAccountState.loadingEditClient() = LoadingEditClient;

  const factory MyAccountState.successEditClient(LoginProviderResponse data) =
      SuccessEditClient<T>;

  const factory MyAccountState.errorEditClient({required String error}) =
      ErrorEditClient;

  const factory MyAccountState.loadDataSuccess() = LoadDataSuccess;

  // remove account
  const factory MyAccountState.loadingRemoveAccount() = LoadingRemoveAccount;

  const factory MyAccountState.successRemoveAccount(RemoveResponse data) =
      SuccessRemoveAccount;

  const factory MyAccountState.errorRemoveAccount({required String error}) =
      ErrorRemoveAccount;

  // send fcm token
  const factory MyAccountState.loadingSendFcmToken() = LoadingSendFcmToken;

  const factory MyAccountState.successSendFcmToken() = SuccessSendFcmToken;

  const factory MyAccountState.errorSendFcmToken({required String error}) =
      ErrorSendFcmToken;

  // get points rules

  const factory MyAccountState.loadingPointsRules() = LoadingPointsRules;

  const factory MyAccountState.successPointsRules(PointsRules data) =
      SuccessPointsRules<T>;

  const factory MyAccountState.errorPointsRules({required String error}) =
      ErrorPointsRules;

  // get invitations
  const factory MyAccountState.loadingInvitations() = LoadingInvitations;

  const factory MyAccountState.successInvitations(InvitesModel data) =
      SuccessInvitations<T>;

  const factory MyAccountState.errorInvitations({required String error}) =
      ErrorInvitations;

  // send invite

  const factory MyAccountState.loadingSendInvite() = LoadingSendInvite;

  const factory MyAccountState.successSendInvite(ResponseModel data) =
      SuccessSendInvite<T>;

  const factory MyAccountState.errorSendInvite({required String error}) =
      ErrorSendInvite;

  // get payments Done
  const factory MyAccountState.loadingPaymentsDone() = LoadingPaymentsDone;

  const factory MyAccountState.successPaymentsDone(MyPaymentsResponse data) =
      SuccessPaymentsDone<T>;

  const factory MyAccountState.errorPaymentsDone({required String error}) =
      ErrorPaymentsDone;
}
