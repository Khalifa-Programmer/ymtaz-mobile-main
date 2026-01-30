import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/custom_list_tile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/invite_and_share.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/user_profile_row.dart';
import 'package:yamtaz/feature/layout/home/presentation/home_screen.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../reminders/screens/reminders_screen.dart';
import '../client_profile/presentation/user_account_screen.dart';
import '../gamification/gamification.dart';

class ProviderMyAccount extends StatelessWidget {
  ProviderMyAccount({super.key});

  final InAppReview _inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<MyAccountCubit>()..loading(),
      child: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return RefreshIndicator(
            color: appColors.primaryColorYellow,
            onRefresh: () async {
              await context.read<MyAccountCubit>().getProviderData();
            },
            child: Scaffold(
              body: SafeArea(
                child: ConditionalBuilder(
                    condition: state is! LoadingGetProvider,
                    builder: (BuildContext context) => Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      UserProfileColumn(
                                          imageUrl: context
                                              .read<MyAccountCubit>()
                                              .userDataResponse!
                                              .data!
                                              .account!
                                              .photo!,
                                          name: context
                                              .read<MyAccountCubit>()
                                              .userDataResponse!
                                              .data!
                                              .account!
                                              .name!,
                                          isVerified: context
                                              .read<MyAccountCubit>()
                                              .userDataResponse!
                                              .data!
                                              .account!
                                              .hasBadge,
                                          image: context
                                              .read<MyAccountCubit>()
                                              .userDataResponse!
                                              .data!
                                              .account!
                                              .currentRank!
                                              .image!,
                                          color: getColor(context
                                              .read<MyAccountCubit>()
                                              .userDataResponse!
                                              .data!
                                              .account!
                                              .currentRank!
                                              .borderColor!)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 5.h),
                                          Text(
                                            context
                                                .read<MyAccountCubit>()
                                                .userDataResponse!
                                                .data!
                                                .account!
                                                .email!,
                                            style: TextStyles.cairo_14_semiBold
                                                .copyWith(
                                                    color: appColors.grey5),
                                          ),
                                          SizedBox(height: 10.h),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.greenAccent
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Text(
                                              "مقدم خدمة",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),

                                      Gamification(
                                        daysStreak: context
                                                .read<MyAccountCubit>()
                                                .userDataResponse!
                                                .data!
                                                .account!
                                                .daysStreak ??
                                            0,
                                        points: context
                                            .read<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .points!,
                                        xp: context
                                            .read<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .xp!,
                                        xpUntilNextLevel: context
                                            .read<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .xpUntilNextLevel!,
                                        currentLevel: context
                                            .read<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .currentLevel!,
                                        currentRank: context
                                            .read<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .currentRank!
                                            .name!,
                                      ),

                                      showCompletedFile(
                                          context,
                                          context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .userDataResponse!
                                                          .data!
                                                          .account!
                                                          .profileComplete ==
                                                      0 ||
                                                  context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .userDataResponse!
                                                          .data!
                                                          .account!
                                                          .profileComplete ==
                                                      null
                                              ? false
                                              : true),

                                      verticalSpace(10.h),
                                      InviteShareButtons(
                                        onInviteTap: () {
                                          inviteUser(
                                            context,
                                          );
                                        },
                                        onShareTap: () {
                                          shareText(
                                              context,
                                              appWelcomeMessage,
                                              context
                                                  .read<MyAccountCubit>()
                                                  .userDataResponse!
                                                  .data!
                                                  .account!
                                                  .referralCode!);
                                        },
                                      ),
                                      verticalSpace(10.h),

                                      CustomListTile(
                                          title: LocaleKeys.profile.tr(),
                                          icon: Icons.person,
                                          onTap: () {
                                            // UserDataResponse userDataResponse = context
                                            //     .read<MyAccountCubit>()
                                            //     .userDataResponse!;
                                            // context.pushNamed(Routes.editProvider,
                                            //     arguments: userDataResponse);

                                            context.pushNamed(
                                                Routes.profileProvider);
                                          }),
                                      // CustomListTile(
                                      //     title: LocaleKeys.myOrders.tr(),
                                      //     icon: Icons.list_alt_rounded,
                                      //     onTap: () {
                                      //       context.pushNamed(Routes.orders);
                                      //     }),
                                      CustomListTile(
                                          title: "الفواتير",
                                          icon: Icons.payments_rounded,
                                          onTap: () {
                                            context.pushNamed(
                                                Routes.myPaymentsScreen);
                                          }),
                                      CustomListTile(
                                          title: "المذكرة الشخصية",
                                          icon: Icons.note_rounded,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RemindersScreen()));
                                          }),
                                      CustomListTile(
                                          title: "الباقات والاشتراكات",
                                          icon: Icons.analytics_rounded,
                                          onTap: () {
                                            context.pushNamed(Routes.packages);
                                          }),
                                      // CustomListTile(
                                      //     title: "المفضلة",
                                      //     icon: Icons.favorite_rounded,
                                      //     onTap: () {
                                      //       context.pushNamed(Routes.favorite);
                                      //     }),
                                      CustomListTile(
                                          title: "مركز الدعم والمساعدة",
                                          icon: Icons.support_agent_rounded,
                                          onTap: () {
                                            context.pushNamed(Routes.support);
                                          }),

                                      CustomListTile(
                                        title: "تقييم التطبيق",
                                        icon: Icons.rate_review,
                                        onTap: () async {
                                          // محاولة عرض نافذة التقييم المنبثقة داخل التطبيق
                                          if (await _inAppReview.isAvailable()) {
                                            // استخدام requestReview لعرض نافذة التقييم المنبثقة
                                            await _inAppReview.requestReview();
                                          } else {
                                            // إذا لم تكن النافذة المنبثقة متاحة، ننتقل إلى المتجر
                                            if (Platform.isAndroid) {
                                              final Uri url = Uri.parse(
                                                  'https://play.google.com/store/apps/details?id=com.ymtaz.ymtaz');
                                              if (await canLaunchUrl(url)) {
                                                await launchUrl(url);
                                              }
                                            } else if (Platform.isIOS) {
                                              await _inAppReview.openStoreListing(
                                                appStoreId: '6602893553',
                                              );
                                            }
                                          }
                                        },
                                      ),

                                      CustomListTile(
                                          title: LocaleKeys.logout.tr(),
                                          icon: Icons.logout_rounded,
                                          onTap: () {
                                            _signOut(context);
                                          }),

                                      verticalSpace(15.h),
                                      Center(
                                        child: FutureBuilder<PackageInfo>(
                                          future: PackageInfo.fromPlatform(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.done) {
                                              if (snapshot.hasData) {
                                                final packageInfo =
                                                    snapshot.data!;
                                                final version = packageInfo
                                                    .version; // Version name
                                                final buildNumber = packageInfo
                                                    .buildNumber; // Version code

                                                return Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppAssets.mainLogo,
                                                      width: 50.w,
                                                      height: 50.h,
                                                    ),
                                                    verticalSpace(10.h),
                                                    Text(
                                                      'الإصدار التجريبي',
                                                      style: TextStyles
                                                          .cairo_12_semiBold
                                                          .copyWith(
                                                              color: appColors
                                                                  .grey20),
                                                    ),
                                                    Text(
                                                      'رقم $version',
                                                      style: TextStyles
                                                          .cairo_12_semiBold
                                                          .copyWith(
                                                              color: appColors
                                                                  .grey20),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Text(
                                                  'اصدار رقم 1.0.0 تجريبي',
                                                  style:
                                                      TextStyles.cairo_12_bold,
                                                );
                                              }
                                            } else {
                                              return const CircularProgressIndicator();
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    fallback: (BuildContext context) => const Center(
                          child: CupertinoActivityIndicator(),
                        )),
              ),
            ),
          );
        },
      ),
    );
  }

  _signOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Column(
                children: <Widget>[
                  Text(
                    LocaleKeys.logout.tr(),
                    style: TextStyles.cairo_18_bold
                        .copyWith(color: appColors.blue100),
                  ),
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    LocaleKeys.no.tr(),
                    style: TextStyles.cairo_18_bold,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text(
                    LocaleKeys.yes.tr(),
                    style: TextStyles.cairo_15_bold.copyWith(color: Colors.red),
                  ),
                  onPressed: () async {
                    String token = CacheHelper.getData(key: 'token');
                    getit<MyAccountCubit>().deleteFcmToken(token);
                    CacheHelper.removeData(key: 'token');
                    CacheHelper.removeData(key: 'rememberMe');
                    CacheHelper.removeData(key: 'userType');
                    CacheHelper.removeData(key: 'FCM');
                    showDialogComplete = true;
                    getit<MyAccountCubit>().userDataResponse = null;
                    context.pushNamedAndRemoveUntil(Routes.login,
                        predicate: (Route<dynamic> route) => false);
                  },
                ),
              ],
            ));
  }
}

Widget showCompletedFile(context, bool isCompletedFile) {
  return ConditionalBuilder(
    condition: isCompletedFile == false,
    builder: (context) => CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var userType = CacheHelper.getData(key: 'userType');
        if (userType == 'client') {
          context.pushNamed(Routes.editClient);
        } else {
          context.pushNamed(Routes.editProviderInstruction);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: appColors.primaryColorYellow.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 65.h,
              width: 65.w,
              child: SfRadialGauge(axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  labelsPosition: ElementsPosition.inside,
                  labelFormat: '{value}%',
                  axisLineStyle: const AxisLineStyle(
                    thickness: 1,
                    color: Colors.transparent,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: const <GaugePointer>[
                    RangePointer(
                      value: 100,
                      // Full range (100%)
                      width: 0.10,
                      color: appColors.grey,
                      // Grey color for the remaining portion
                      pointerOffset: 0.1,
                      cornerStyle: CornerStyle.bothCurve,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                    RangePointer(
                      value: 30,
                      width: 0.10,
                      color: appColors.primaryColorYellow,
                      pointerOffset: 0.1,
                      cornerStyle: CornerStyle.bothCurve,
                      sizeUnit: GaugeSizeUnit.factor,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        '30%', // ضع النسبة المطلوبة هنا
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: appColors.primaryColorYellow,
                        ),
                      ),
                      positionFactor: 0.0, // هذا يحدد مكان النص
                      angle: 90, // زاوية العرض
                    ),
                  ],
                ),
              ]),
            ),
            horizontalSpace(10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ملفكم ينتظر الاستكمال',
                        style: TextStyles.cairo_14_bold,
                      ),
                      const Icon(
                        CupertinoIcons.chevron_left,
                        color: appColors.primaryColorYellow,
                      )
                    ],
                  ),
                  verticalSpace(4.h),
                  Text(
                    'ستكتسب ١٠٠ نقطة عند استكمال بيانات ملفكم الشخصي.',
                    maxLines: 3,
                    style: TextStyles.cairo_12_semiBold,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
    fallback: (context) => Container(),
  );
}
