import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/user_account_screen.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/my_account_main_screen.dart';

import 'guest_screen.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var userType = CacheHelper.getData(key: 'userType');
    return userType == 'provider'
        ? ProviderMyAccount()
        : userType == 'client'
            ? ClientMyAccount()
            : const GestScreen();
  }
}
