import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/layout/layout/logic/layout_cubit.dart';

import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../l10n/locale_keys.g.dart';
import '../../../../account/logic/my_account_cubit.dart';

Widget CustomBottomAppBar(BuildContext context) {
  var userType = CacheHelper.getData(key: 'userType');

  return NavigationBar(
    indicatorColor: Colors.transparent,
    surfaceTintColor: const Color(0x00d6d6d6),
    selectedIndex: LayoutCubit.get(context).currentIndex,
    animationDuration: const Duration(milliseconds: 1000),
    onDestinationSelected: (value) =>
        LayoutCubit.get(context).changeCurrentPage(value),
    elevation: 1,
    shadowColor: Colors.black,
    backgroundColor: Colors.white,
    destinations: [
      _buildShadowWithRippleDestination(
        context,
        icon: FontAwesomeIcons.house,
        label: LocaleKeys.home.tr(),
        isSelected: LayoutCubit.get(context).currentIndex == 0,
      ),
      if (userType != "provider")
        _buildShadowWithRippleDestination(
          context,
          icon: CupertinoIcons.cube_box_fill,
          label: "طلباتي",
          isSelected: LayoutCubit.get(context).currentIndex == 1,
        ),
      if (userType == "provider")
        _buildShadowWithRippleDestination(
          context,
          icon: CupertinoIcons.device_laptop,
          label: "المكتب",
          isSelected: LayoutCubit.get(context).currentIndex == 1,
        ),
      _buildShadowWithRippleDestination(
        context,
        icon: CupertinoIcons.search,
        label: "البحث",
        isSelected: LayoutCubit.get(context).currentIndex == 2,
      ),
      _buildShadowWithRippleDestination(
        context,
        icon: null,
        label: LocaleKeys.myAccount.tr(),
        isSelected: LayoutCubit.get(context).currentIndex == 3,
        customIcon: CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(getProfileImage()),
        ),
      ),
    ],
  );
}

Widget _buildShadowWithRippleDestination(
  BuildContext context, {
  required IconData? icon,
  required String label,
  required bool isSelected,
  Widget? customIcon,
}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return InkWell(
        onTap: () {
          int index = _getDestinationIndex(label);
          LayoutCubit.get(context).changeCurrentPage(index);
        },
        child: NavigationDestination(
          selectedIcon: customIcon ??
              FaIcon(
                icon,
                color: appColors.blue100,
              ),
          icon: customIcon ??
              FaIcon(
                icon,
                color: isSelected ? appColors.blue100 : appColors.grey5,
              ),
          label: label,
        ),
      );
    },
  );
}

int _getDestinationIndex(String label) {
  switch (label) {
    case "Home":
    case "الرئيسية":
      return 0;
    case "طلباتي":
      return 1;
    case "المكتب":
      return 1;
    case "البحث":
      return 2;
    case "حسابي":
    case "My Account":
      return 3;
    default:
      return 0;
  }
}

String getProfileImage() {
  var userType = CacheHelper.getData(key: 'userType');
  if (userType == "client") {
    return getit<MyAccountCubit>().clientProfile?.data?.account?.photo ??
        "https://api.ymtaz.sa/uploads/person.png";
  } else if (userType == "provider") {
    return getit<MyAccountCubit>().userDataResponse?.data?.account?.photo ??
        "https://api.ymtaz.sa/uploads/person.png";
  } else {
    return "https://api.ymtaz.sa/uploads/person.png";
  }
}
