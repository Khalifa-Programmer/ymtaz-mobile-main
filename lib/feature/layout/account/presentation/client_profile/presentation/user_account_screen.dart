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
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/widgets/user_profile_row.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../../core/constants/assets.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/di/dependency_injection.dart';
import '../../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../../../core/widgets/spacing.dart';
import '../../../../../reminders/screens/reminders_screen.dart';
import '../../../../home/presentation/home_screen.dart';
import '../../gamification/gamification.dart';
import '../../profile_provider/my_account_main_screen.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/invite_and_share.dart';

const String appWelcomeMessage = "🌟 أهلاً بك في تطبيق يمتاز\n"
    "دليلك القانوني وموقفك النظامي\n\n"
    "🪩 يمكنك الارتقاء بمستوى احتياجاتك القانونية معنا، عبر منظومة المنتجات الرقمية الآتية :\n"
    "•نافذة الاستشارات\n"
    "•بوابة الخدمات\n"
    "•مفكرة المواعيد\n"
    "•دليل الأنظمة السعودية\n"
    "•المكتبة القضائية\n"
    "•دليل التواصل العدلي\n"
    "•دليل مقدمي الخدمة\n"
    "•هيئة المستشارين\n\n"
    "⚖️ لتحميل تطبيق يمتاز الآن :\n"
    "https://onelink.to/bb6n4x\n\n"
    "🌟 ستربح ٥٠ نقطة عند التسجيل في التطبيق باستخدام كود الدعوة الآتي :";

class ClientMyAccount extends StatelessWidget {
  ClientMyAccount({super.key});

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
              await context.read<MyAccountCubit>().getClientData();
            },
            child: Scaffold(
              body: SafeArea(
                child: ConditionalBuilder(
                    condition: state is! LoadingGetClient,
                    builder: (BuildContext context) => Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      context
                                                  .read<MyAccountCubit>()
                                                  .clientProfile ==
                                              null
                                          ? Container()
                                          : UserProfileColumn(
                                              imageUrl: getit<MyAccountCubit>()
                                                      .clientProfile!
                                                      .data!
                                                      .account!
                                                      .photo ??
                                                  "https://api.ymtaz.sa/uploads/person.png",
                                              name: getit<MyAccountCubit>()
                                                  .clientProfile!
                                                  .data!
                                                  .account!
                                                  .name!,
                                              color: getColor(
                                                  getit<MyAccountCubit>()
                                                      .clientProfile!
                                                      .data!
                                                      .account!
                                                      .currentRank!
                                                      .borderColor!),
                                              image: getit<MyAccountCubit>()
                                                  .clientProfile!
                                                  .data!
                                                  .account!
                                                  .currentRank!
                                                  .image!,
                                            ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 5.h),
                                          Text(
                                            context
                                                .read<MyAccountCubit>()
                                                .clientProfile!
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
                                              "طالب خدمة",
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
                                                .clientProfile!
                                                .data!
                                                .account!
                                                .daysStreak ??
                                            0,
                                        points: context
                                            .read<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .points!,
                                        xp: context
                                            .read<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .xp!,
                                        xpUntilNextLevel: context
                                            .read<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .xpUntilNextLevel!,
                                        currentLevel: context
                                            .read<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .currentLevel!,
                                        currentRank: context
                                            .read<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .currentRank!
                                            .name!,
                                      ),
                                      verticalSpace(10.h),
                                      showCompletedFile(
                                          context,
                                          context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .clientProfile!
                                                          .data!
                                                          .account!
                                                          .profileComplete ==
                                                      0 ||
                                                  context
                                                          .read<
                                                              MyAccountCubit>()
                                                          .clientProfile!
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
                                              getit<MyAccountCubit>()
                                                  .clientProfile!
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
                                            context.pushNamed(
                                                Routes.profileClient);
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
                                          title: "الفواتير",
                                          icon: Icons.payments_rounded,
                                          onTap: () {
                                            context.pushNamed(
                                                Routes.myPaymentsScreen);
                                          }),
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
                                              return CircularProgressIndicator();
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
                    showDialogComplete = true;

                    getit<MyAccountCubit>().userDataResponse = null;
                    getit<MyAccountCubit>().clientProfile = null;
                    context.pushNamedAndRemoveUntil(Routes.login,
                        predicate: (Route<dynamic> route) => false);
                  },
                ),
              ],
            ));
  }
}
