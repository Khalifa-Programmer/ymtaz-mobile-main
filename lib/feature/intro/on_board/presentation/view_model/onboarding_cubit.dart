import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/data/onboard_model.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../core/router/routes.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context) => BlocProvider.of(context);
  late PageController pageController;

  int currentIndex = 0;
  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
        asset: AppAssets.onBoard1,
        content: LocaleKeys.uniqueServicesPackage.tr(),
        contentDescription: LocaleKeys.legalAdvice.tr()),
    OnboardingModel(
        asset: AppAssets.onBoard2,
        content: LocaleKeys.expertTeam.tr(),
        contentDescription: LocaleKeys.hourConsultation.tr()),
    OnboardingModel(
        asset: AppAssets.onBoard3,
        content: LocaleKeys.easySecureUsage.tr(),
        contentDescription: LocaleKeys.appFeatures.tr()),
  ];

  void initScreen() {
    pageController = PageController(initialPage: 0);
    emit(OnboardingInitial());
  }

  void pageChanged(int index) {
    currentIndex = index;
    emit(OnBoardingPageChanged());
  }

  void previousPage() {
    if (pageController.page! < onboardingData.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    emit(OnBoardingPageChanged());
  }

  void nextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    emit(OnBoardingPageChanged());
  }

  void changeLanguage(BuildContext context) {
    // Get the current locale
    Locale currentLocale = EasyLocalization.of(context)!.locale;
    // Extract the language code
    String languageCode = currentLocale.languageCode;
    if (languageCode == 'en') {
      languageCode = 'ar';
    } else if (languageCode == 'ar') {
      languageCode = 'en';
    }
    EasyLocalization.of(context)!.setLocale(Locale(languageCode));
    context.pushNamedAndRemoveUntil(Routes.splash,
        predicate: (Route<dynamic> route) => false);
    emit(OnboardingLanguageChanged());
  }
}
