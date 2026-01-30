import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/about_ymtaz.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/privacy_policy.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/social_media.dart';

import '../data/models/faq.dart';

part 'contact_ymtaz_state.freezed.dart';

@freezed
class ContactYmtazState<T> with _$ContactYmtazState<T> {
  const factory ContactYmtazState.initial() = _Initial;

  const factory ContactYmtazState.loading() = LoadingContactYmtazState;

  const factory ContactYmtazState.loaded(T data) = LoadedContactYmtazState;

  const factory ContactYmtazState.error(String message) =
      ErrorContactYmtazState;

  const factory ContactYmtazState.loadingSendMessage() = LoadingSendMessage;

  const factory ContactYmtazState.successSendMessage(T data) =
      SuccessSendMessage;

  const factory ContactYmtazState.errorSendMessage(String message) =
      ErrorSendMessage;

  const factory ContactYmtazState.loadingContactUsTypes() =
      LoadingContactUsTypes;

  const factory ContactYmtazState.loadedContactUsTypes() = LoadedContactUsTypes;

  const factory ContactYmtazState.errorContactUsTypes(String message) =
      ErrorContactUsTypes;

  const factory ContactYmtazState.loadedAboutUs(AboutYmtaz data) =
      LoadedAboutUs;

  const factory ContactYmtazState.loadedFaq(Faq data) = LoadedFaq<T>;

  const factory ContactYmtazState.loadedPrivacyPolicy(PrivacyPolicy data) =
      LoadedPrivacyPolicy;

  const factory ContactYmtazState.loadedSocialMedia(SocialMedia data) =
      LoadedSocialMedia;
}
