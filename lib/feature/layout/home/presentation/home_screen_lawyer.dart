import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/presentation/guest_screen.dart';
import 'package:yamtaz/feature/layout/home/logic/home_cubit.dart';
import 'package:yamtaz/feature/layout/home/logic/home_state.dart';
import 'package:yamtaz/feature/layout/home/presentation/recent_joined_lawyers.dart';

import '../../../digital_office/logic/office_provider_cubit.dart';
import '../../../digital_office/view/adjust_office_main.dart';
import '../../../notifications/logic/notification_cubit.dart';
import '../../account/logic/my_account_cubit.dart';
import '../../account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../account/presentation/widgets/user_profile_row.dart';
import 'ads_banner/ads_banner.dart';

bool showDialogComplete = true;

class HomeScreenLawyer extends StatefulWidget {
  const HomeScreenLawyer({super.key});

  @override
  State<HomeScreenLawyer> createState() => _HomeScreenLawyerState();
}

class _HomeScreenLawyerState extends State<HomeScreenLawyer> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getit<NotificationCubit>().getNotifications();
      final userType = CacheHelper.getData(key: 'userType');

      if (showDialogComplete) {
        if (userType == 'client') {
          _checkClientProfileCompletion();
        } else if (userType == 'provider') {
          _checkProviderProfileCompletion();
        }
      }
    });
  }

  // Check client profile completion and show dialog if necessary
  void _checkClientProfileCompletion() {
    final clientProfile = getit<MyAccountCubit>().clientProfile;

    if (clientProfile != null &&
        (clientProfile.data!.account!.profileComplete == 0 ||
            clientProfile.data!.account!.profileComplete == null)) {
      showCustomDialog(context);
    }
  }

  // Check provider profile completion and show dialog if necessary
  void _checkProviderProfileCompletion() {
    final userDataResponse = getit<MyAccountCubit>().userDataResponse;

    if (userDataResponse != null &&
        (userDataResponse.data!.account!.profileComplete == 0 ||
            userDataResponse.data!.account!.profileComplete == null)) {
      showCustomDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userType = CacheHelper.getData(key: 'userType');
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // Add state listener if needed
      },
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<HomeCubit>().getHomeData();
              if (userType != 'guest') {
                getit<NotificationCubit>().getNotifications();
                await getit<MyAccountCubit>().refresh();
              }
            },
            color: appColors.primaryColorYellow,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildPinnedHeader(context),

              // Add pinned header
              //SliverToBoxAdapter(child: _buildSearchField()),
              // Search bar
              SliverToBoxAdapter(child: RecentJoinedLawyers()),
              // Recent Lawyers
              SliverToBoxAdapter(child: verticalSpace(20.h)),

              SliverToBoxAdapter(
                  child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                            value: getit<OfficeProviderCubit>(),
                            child: const AdjustOfficeMain()),
                      ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF2280FF).withOpacity(0.1),
                        Color(0xFFCE7182).withOpacity(0.2),
                        Colors.orangeAccent.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add_task_sharp,
                          color: appColors.blue100, size: 15.sp),
                      horizontalSpace(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التخصيص',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: appColors.blue100,
                            ),
                          ),
                          Text(
                            'قم بتخصيص المنتجات في ملفك',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: appColors.blue100,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                          color: appColors.blue100, size: 15.sp),
                    ],
                  ),
                ),
              )),
              SliverToBoxAdapter(child: verticalSpace(20.h)),

              _buildGridSection(context),
              SliverToBoxAdapter(child: verticalSpace(20.h)),

              // Slider
              // SliverToBoxAdapter(child: AdsBanner()),
              // SliverToBoxAdapter(child: verticalSpace(20.h)),

              // Grid Section
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildPinnedHeader(BuildContext context) {
    final userType = CacheHelper.getData(key: 'userType');

    return SliverAppBar(
      automaticallyImplyLeading: userType == 'guest',
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      // Make AppBar background transparent
      collapsedHeight: 65.h,
      flexibleSpace: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15.r),
          bottomRight: Radius.circular(15.r),
        ),
        child: Stack(
          children: [
            // Add the blur effect
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color:
                    Colors.white.withOpacity(0.8), // Add semi-transparent white
              ),
            ),
            // Add a gradient overlay at the bottom
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: GestureDetector(
          onTap: () {
            if (userType == 'client') {
              context.pushNamed(Routes.profileClient);
            } else if (userType == 'provider') {
              context.pushNamed(Routes.profileProvider);
            } else {
              Navigator.pushNamed(context, '/guestScreen');
            }
          },
          child: _buildUserProfileRow(context),
        ),
      ),
      actions: [
        _buildNotificationIcon(userType),
      ],
    );
  }

  Widget _buildGridSection(BuildContext context) {
    final homeData = context.read<HomeCubit>().homeDataLawyer;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0.w,
          mainAxisSpacing: 8.0.h,
          childAspectRatio: 1.8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final item = homeData[index];
            return CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (item.route != null) {
                  context.pushNamed(item.route!);
                }
              },
              child: _buildGridItem(context, item, index),
            );
          },
          childCount: homeData.length,
        ),
      ),
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context) {
    final userType = CacheHelper.getData(key: 'userType');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (CacheHelper.getData(key: 'userType') == 'client') {
                context.pushNamed(Routes.profileClient);
              } else if (CacheHelper.getData(key: 'userType') == 'provider') {
                context.pushNamed(Routes.profileProvider);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GestScreen()));
              }
            },
            child: _buildUserProfileRow(context),
          ),
          _buildNotificationIcon(userType),
        ],
      ),
    );
  }

  // User Profile Row

  Column _buildUserProfileRow(BuildContext context) {
    var userType = CacheHelper.getData(key: 'userType');
    return Column(
      children: [
        ConditionalBuilder(
          condition: getit<MyAccountCubit>().clientProfile != null &&
              userType == 'client',
          builder: (BuildContext context) => UserProfileRow(
            imageUrl:
                getit<MyAccountCubit>().clientProfile!.data!.account!.photo ??
                    "https://api.ymtaz.sa/uploads/person.png",
            name: getit<MyAccountCubit>().clientProfile!.data!.account!.name!,
            color: getColor(getit<MyAccountCubit>()
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
          fallback: (BuildContext context) => const SizedBox(),
        ),
        ConditionalBuilder(
          condition: getit<MyAccountCubit>().userDataResponse != null &&
              userType == 'provider',
          builder: (BuildContext context) => UserProfileRow(
            isVerified: getit<MyAccountCubit>()
                .userDataResponse!
                .data!
                .account!
                .hasBadge,
            imageUrl: getit<MyAccountCubit>()
                    .userDataResponse!
                    .data!
                    .account!
                    .photo ??
                "https://api.ymtaz.sa/uploads/person.png",
            name:
                '${getit<MyAccountCubit>().userDataResponse!.data!.account!.name}',
            color: getColor(getit<MyAccountCubit>()
                .userDataResponse!
                .data!
                .account!
                .currentRank!
                .borderColor!),
            image: getit<MyAccountCubit>()
                .userDataResponse!
                .data!
                .account!
                .currentRank!
                .image!,
          ),
          fallback: (BuildContext context) => const SizedBox(),
        ),
        ConditionalBuilder(
          condition: userType == 'guest',
          builder: (BuildContext context) => const UserProfileRow(
            imageUrl:
                "https://e7.pngegg.com/pngimages/141/425/png-clipart-user-profile-computer-icons-avatar-profile-s-free-angle-rectangle-thumbnail.png",
            name: "ضيفنا الكريم",
            color: appColors.primaryColorYellow,
            image: "https://api.ymtaz.sa/uploads/ranks/BrownShield.svg",
          ),
          fallback: (BuildContext context) => const SizedBox(),
        ),
      ],
    );
  }

  // Notification Icon with Badge
  Widget _buildNotificationIcon(String userType) {
    if (userType != 'client' && userType != 'provider') {
      return const SizedBox.shrink();
    }

    final unreadCountNotifier =
        getit<NotificationCubit>().unreadCount; // Notification counter

    return Stack(
      children: [
        IconButton(
          onPressed: () => context.pushNamed(Routes.notifications),
          icon: Icon(
            CupertinoIcons.bell_circle,
            size: 30.sp,
            color: appColors.blue100,
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable: unreadCountNotifier,
          builder: (context, count, child) {
            if (count > 0) {
              return Positioned(
                top: 5,
                right: 5,
                child: Badge(
                  label: Text(count.toString()),
                  backgroundColor: appColors.red,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // Search Field
  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: CupertinoTextField(
        placeholder: 'قم بالبحث',
        placeholderStyle:
            TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey15),
        prefix: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.search,
            color: appColors.grey15,
          ),
        ),
        focusNode: focusNode,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: appColors.grey15.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        clearButtonMode: OverlayVisibilityMode.editing,
        clearButtonSemanticLabel: 'مسح',
        onTap: () {
          context.pushNamed(Routes.fastSearch);
          focusNode.unfocus();
        },
      ),
    );
  }

  // Grid Section
  Widget _buildHomeGrid(BuildContext context) {
    final homeData = context.read<HomeCubit>().homeData;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.8,
          crossAxisCount: 2,
          crossAxisSpacing: 8.0.w,
          mainAxisSpacing: 8.0.h,
        ),
        itemCount: homeData.length,
        itemBuilder: (context, index) {
          final item = homeData[index];
          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (item.route != null) {
                context.pushNamed(item.route!);
              }
            },
            child: _buildGridItem(context, item, index),
          );
        },
      ),
    );
  }

  // Grid Item
  Widget _buildGridItem(BuildContext context, dynamic item, int index) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: index % 4 < 2
                  ? appColors.primaryColorYellow
                  : appColors.blue90,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item.icon,
                Text(
                  item.title,
                  style: TextStyle(
                    color: appColors.blue100,
                    fontSize: 12.sp,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Dialog
void showCustomDialog(BuildContext context) {
  final userType = CacheHelper.getData(key: 'userType');

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                    showDialogComplete = false;
                  },
                  child: Icon(
                    CupertinoIcons.xmark_circle_fill,
                    color: appColors.grey.withOpacity(0.5),
                    size: 30.sp,
                  ),
                ),
              ),
              Image.asset(
                AppAssets.compeleteDataPNG,
                height: 150.h,
              ),
              SizedBox(height: 16.h),
              Text(
                'ملفك الشخصي مكتمل بنسبة ٣٠٪',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                userType == 'client'
                    ? 'باستكمال ملفكم الشخصي ستفوز بـ ١٠٠ نقطة جديدة، وسيتسنى لكم التمتع بكافة مزايا التطبيق الأخرى.'
                    : 'باستكمال ملفكم الشخصي ستفوز بـ ١٠٠ نقطة جديدة، وسيظهر ملفكم كمقدم خدمة في الدليل الرقمي، وسيتسنى لكم التمتع بكافة مزايا التطبيق الأخرى.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 25.h),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: appColors.primaryColorYellow,
                  onPressed: () {
                    Navigator.pop(context);
                    if (userType == 'client') {
                      context.pushNamed(Routes.editClient);
                    } else {
                      context.pushNamed(Routes.editProviderInstruction);
                    }
                  },
                  child: Text(
                    'استكمال الملف الشخصي',
                    style:
                        TextStyles.cairo_12_bold.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
            ],
          ),
        ),
      );
    },
  );
}
