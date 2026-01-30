import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_guide/presentation/fast_search_screen.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/home/presentation/home_screen.dart';
import 'package:yamtaz/feature/layout/home/presentation/home_screen_lawyer.dart';
import 'package:yamtaz/feature/layout/my_page/logic/my_page_cubit.dart';
import 'package:yamtaz/feature/layout/my_page/view/my_page_screen.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../digital_office/logic/office_provider_cubit.dart';
import '../../../digital_office/view/new_office_home.dart';
import '../../account/presentation/my_account_screen.dart';
import '../../home/logic/home_cubit.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int type = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List pages = [
    CacheHelper.getData(key: 'userType') == "provider"
        ? BlocProvider.value(
            value: getit<HomeCubit>()..getHomeData(),
            child: const HomeScreenLawyer())
        : BlocProvider.value(
            value: getit<HomeCubit>()..getHomeData(),
            child: const HomeScreen()),
    CacheHelper.getData(key: 'userType') != "provider"
        ? BlocProvider.value(value: getit<MyPageCubit>(), child: MyPageScreen())
        : BlocProvider.value(
            value: getit<OfficeProviderCubit>()..getAnalytics(),
            child: NewOfficeHome(),
          ),
    BlocProvider.value(
        value: getit<DigitalGuideCubit>(), child: FastSearchScreen()),
    BlocProvider.value(
        value: getit<MyAccountCubit>(), child: const MyAccountScreen())
  ];

  void changeType(int newType) {
    type = newType;
    emit(NavigationScreenChanged());
  }

  void changeCurrentPage(int newCurrentIndex) {
    currentIndex = newCurrentIndex;
    emit(NavigationScreenChanged());
  }
}
