
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/config/themes/app_theme.dart';
import 'package:yamtaz/core/router/app_router.dart';



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
    final bool isTablet = MediaQuery.of(context).size.width >= 600;
    
    return GestureDetector(
      onTap: () {
        FocusManager focus = FocusManager.instance;
        if (focus.primaryFocus?.hasFocus ?? false) {
          focus.primaryFocus?.unfocus();
        }
      },
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: isTablet ? const Size(650, 1012) : const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          title: "Ymtaz",
          navigatorKey: navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          themeMode: ThemeMode.light,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            return appRouter.generateRoute(settings);
          },
        ),
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
