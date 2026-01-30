import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/home/data/models/home_model.dart';
import 'package:yamtaz/feature/layout/home/data/repo/home_repo.dart';
import 'package:yamtaz/feature/layout/home/logic/home_state.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../core/network/error/api_result.dart';
import '../data/models/banners_model.dart';
import '../data/models/recent_joined_lawyers_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeStateInitial());

  List<HomeModel> homeData = [
    HomeModel(
        title: LocaleKeys.consultationWindow.tr(),
        description: LocaleKeys.consultationWindow.tr(),
        route: Routes.advisoryScreen,
        icon: SvgPicture.asset(
          AppAssets.advisories,
          width: 30.sp,
          height: 30.sp,
        )),

    HomeModel(
        title: LocaleKeys.servicesPortal.tr(),
        description: LocaleKeys.servicesPortal.tr(),
        route: Routes.services,
        icon: SvgPicture.asset(
          AppAssets.services,
          width: 30.sp,
          height: 30.sp,
        )),

    HomeModel(
        title: LocaleKeys.appointments.tr(),
        description: LocaleKeys.appointments.tr(),
        route: Routes.appointmentYmatz,
        icon: SvgPicture.asset(
          AppAssets.appointments,
          width: 30.sp,
          height: 30.sp,
        )),

    // HomeModel(
    //     title: LocaleKeys.consultantsBoard.tr(),
    //     description: LocaleKeys.consultantsBoard.tr(),
    //     route: Routes.advisoryCommitteesScreen,
    //     icon: SvgPicture.asset(
    //       AppAssets.users,
    //       width: 30.sp,
    //       height: 30.sp,
    //     )),

    HomeModel(
        title: LocaleKeys.legalGuide.tr(),
        description: LocaleKeys.legalGuide.tr(),
        route: Routes.forensicGuide,
        icon: SvgPicture.asset(
          AppAssets.guide,
          width: 30.sp,
          height: 30.sp,
        )),

    HomeModel(
        title: "دليل الأنظمة",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.lawGuide,
        icon: SvgPicture.asset(
          AppAssets.forensicGuide,
          width: 30.sp,
          height: 30.sp,
        )),

    HomeModel(
        title: "مكتبة يمتاز",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.libraryGuide,
        icon: SvgPicture.asset(
          AppAssets.digital,
          width: 30.sp,
          height: 30.sp,
        )),
   //todo learning card
    // HomeModel(
    //     title: "مسارات القراءة",
    //     description: "",
    //     route: Routes.learningPathHome,
    //     icon: SvgPicture.asset(
    //       AppAssets.booksNew,
    //       width: 30.sp,
    //       height: 30.sp,
    //     )),
    HomeModel(
        title: "المساعد الذكي",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.aiAssistant,
        icon: SvgPicture.asset(
          AppAssets.logo,
          width: 30.sp,
          height: 30.sp,
        )),
  ];
  List<HomeModel> homeDataLawyer = [
    HomeModel(
        title: "دليل الأنظمة",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.lawGuide,
        icon: SvgPicture.asset(
          AppAssets.forensicGuide,
          width: 30.sp,
          height: 30.sp,
        )),
    HomeModel(
        title: LocaleKeys.legalGuide.tr(),
        description: LocaleKeys.legalGuide.tr(),
        route: Routes.forensicGuide,
        icon: SvgPicture.asset(
          AppAssets.guide,
          width: 30.sp,
          height: 30.sp,
        )),
    HomeModel(
        title: "مكتبة يمتاز",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.libraryGuide,
        icon: SvgPicture.asset(
          AppAssets.digital,
          width: 30.sp,
          height: 30.sp,
        )),
    HomeModel(
        title: "المساعد الذكي",
        description: LocaleKeys.libraryAndSystems.tr(),
        route: Routes.aiAssistant,
        icon: SvgPicture.asset(
          AppAssets.logo,
          width: 30.sp,
          height: 30.sp,
        )),
    //todo learning card

    // HomeModel(
    //     title: "مسارات القراءة",
    //     description: "",
    //     route: Routes.learningPaths,
    //     icon: SvgPicture.asset(
    //       AppAssets.booksNew,
    //       width: 30.sp,
    //       height: 30.sp,
    //     )),
  ];
  List<NewAdvisory>? advisoriesNew;

  Future<void> getHomeData() async {
    emit(HomeStateLoading());

    try {
      final responses = await Future.wait([
        _homeRepo.getRecentLawyers(), // Fetch recent lawyers
        _homeRepo.getBanners(), // Fetch banners
      ]);

      final recentLawyersResponse =
          responses[0] as ApiResult<RecentJoinedLawyersModel>;
      final bannersResponse = responses[1] as ApiResult<BannersModel>;

      // Handle recent lawyers response
      recentLawyersResponse.when(
        success: (lawyerTypesResponse) {
          advisoriesNew = lawyerTypesResponse.data!.newAdvisories!;
          emit(HomeStateRecentJoinedLawyersLoaded(
              lawyerTypesResponse.data!.newAdvisories!));
        },
        failure: (fail) {
          emit(HomeStateRecentJoinedLawyersError(
              "حدث خطأ اثناء تحميل البيانات"));
        },
      );

      // Handle banners response
      bannersResponse.when(
        success: (bannerTypesResponse) {
          emit(HomeStateBannersLoaded(bannerTypesResponse.data!.banners!));
        },
        failure: (fail) {
          emit(HomeStateBannersError("حدث خطأ اثناء تحميل البيانات"));
        },
      );
    } catch (e) {
      // Handle any errors that may occur during the requests
      emit(HomeStateError("حدث خطأ اثناء تحميل البيانات"));
    }
  }
}
