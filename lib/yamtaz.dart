
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/config/themes/app_theme.dart';
import 'package:yamtaz/core/router/app_router.dart';
import 'package:yamtaz/feature/intro/splash/presentation/splash_screen.dart';

class Yamtaz extends StatelessWidget {
  final AppRouter appRouter;
  final String initialRoute;
  final GlobalKey<NavigatorState> navigatorKey;

  const Yamtaz({
    super.key,
    required this.appRouter,
    required this.initialRoute,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager focus = FocusManager.instance;
        if (focus.primaryFocus?.hasFocus ?? false) {
          focus.primaryFocus?.unfocus();
        }
      },
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: "Ymtaz",
            navigatorKey: navigatorKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            themeMode: ThemeMode.light,
            initialRoute: initialRoute,
            onGenerateRoute: appRouter.generateRoute,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
