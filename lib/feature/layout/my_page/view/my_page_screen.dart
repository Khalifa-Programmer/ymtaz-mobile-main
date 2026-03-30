import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/layout/my_page/logic/my_page_cubit.dart';
import 'package:yamtaz/feature/layout/my_page/logic/my_page_state.dart';
import 'package:yamtaz/feature/layout/my_page/view/widgets/my_page_client.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/my_orders_card.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/item_widget.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/lawyer_package_card.dart';

import 'package:yamtaz/feature/layout/my_page/data/model/last_added.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/constants/colors.dart';
import '../../account/presentation/guest_screen.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late String userType;

  @override
  void initState() {
    super.initState();
    userType = CacheHelper.getData(key: 'userType') ?? "guest";
    if (userType != "guest") {
      getit<MyPageCubit>().getMyPageData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<MyPageCubit>(),
      child: BlocConsumer<MyPageCubit, MyPageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: buildBlurredAppBar(context, "طلباتي"),
            body: userType == "client" || userType == "provider"
                ? const MyPageClientImproved()
                : const GestScreen(),
          );
        },
      ),
    );
  }
}

// تحسين صفحة العميل مع معالجة التمرير المتداخل
class MyPageClientImproved extends StatefulWidget {
  const MyPageClientImproved({super.key});

  @override
  State<MyPageClientImproved> createState() => _MyPageClientImprovedState();
}

class _MyPageClientImprovedState extends State<MyPageClientImproved> {
  bool _showAllMostBought = false;
  bool _showAllLatest = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyPageCubit, MyPageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        // التحقق من حالة التحميل
        final bool isLoading = getit<MyPageCubit>().lastAddedModel == null;
        
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      // بطاقة الباقة
                      if (getit<MyPageCubit>().myPageResponseModel != null)
                        LawyerPackageCard(
                          package: getit<MyAccountCubit>()
                              .clientProfile!
                              .data!
                              .account!
                              .package,
                        ),
                      SizedBox(height: 20.h),
                      // تحليلات التبويبات
                      if (getit<MyPageCubit>().myPageResponseModel != null)
                        TabsAnalysis(
                          data: getit<MyPageCubit>()
                              .myPageResponseModel!
                              .data!
                              .analytics!,
                        ),
                      SizedBox(height: 20.h),
                      // بطاقة طلبات العميل
                      const MyOrdersItemsClientCard(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ];
          },
          // تحسين التبويبات مع معالجة التمرير المتداخل
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  decoration: BoxDecoration(
                    color: appColors.grey1.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: appColors.primaryColorYellow,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: appColors.primaryColorYellow.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    labelColor: appColors.white,
                    unselectedLabelColor: appColors.grey10,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      fontFamily: 'Cairo',
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                      fontFamily: 'Cairo',
                    ),
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.symmetric(vertical: 4.h),
                    tabs: [
                      SizedBox(
                        height: 32.h,
                        child: const Center(
                          child: Text('الأكثر طلباً'),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                        child: const Center(
                          child: Text('المضاف حديثاً'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: isLoading 
                    ? _buildLoadingState()
                    : TabBarView(
                      children: [
                        // تحسين تمرير التبويب الأول - الأكثر طلباً
                        RefreshIndicator(
                          color: appColors.primaryColorYellow,
                          onRefresh: () {
                            context.read<MyPageCubit>().getMyPageData();
                            return Future.delayed(const Duration(seconds: 1));
                          },
                          child: _buildEmptyContent(context) ? 
                            _buildEmptyState('لا توجد عناصر في الأكثر طلباً') :
                            ListView(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              physics: const BouncingScrollPhysics(),
                              children: _buildMostBoughtItems(context),
                            ),
                        ),
                        // تحسين تمرير التبويب الثاني - المضاف حديثاً
                        RefreshIndicator(
                          color: appColors.primaryColorYellow,
                          onRefresh: () {
                            context.read<MyPageCubit>().getMyPageData();
                            return Future.delayed(const Duration(seconds: 1));
                          },
                          child: _buildEmptyLatestContent(context) ? 
                            _buildEmptyState('لا توجد عناصر مضافة حديثاً') :
                            ListView(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              physics: const BouncingScrollPhysics(),
                              children: _buildLatestCreatedItems(context),
                            ),
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // بناء عناصر الأكثر طلباً
  List<Widget> _buildMostBoughtItems(BuildContext context) {
    final model = getit<MyPageCubit>().lastAddedModel?.data?.mostBought;
    
    if (model == null) return [];

    final List<dynamic> allData = [
      ...(model.advisoryServices ?? []),
      ...(model.services ?? []),
      ...(model.appointments ?? []),
    ];

    final List<Widget> items = allData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      if (item is LatestCreatedAdvisoryService || item is MostBoughtAdvisoryService) {
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).name ?? '',
          description: (item as dynamic).description ?? 'لا يوجد وصف متاح',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.advisories,
          onPressed: () => context.pushNamed(Routes.advisoryScreen),
        );
      } else if (item is LatestCreatedService || item is MostBoughtService) {
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).title ?? '',
          description: (item as dynamic).intro ?? 'لا يوجد وصف متاح',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.services,
          onPressed: () => context.pushNamed(Routes.services),
        );
      } else { // Appointment
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).name ?? '',
          description: 'موعد مع ${(item as dynamic).name ?? "محامي"}',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.appointments,
          onPressed: () => context.pushNamed(Routes.appointmentYmatz),
        );
      }
    }).toList();

    return _limitItems(items, _showAllMostBought, () {
      setState(() {
        _showAllMostBought = true;
      });
    });
  }

  // بناء العناصر المضافة حديثاً
  List<Widget> _buildLatestCreatedItems(BuildContext context) {
    final model = getit<MyPageCubit>().lastAddedModel?.data?.latestCreated;
    
    if (model == null) return [];

    final List<dynamic> allData = [
      ...(model.advisoryServices ?? []),
      ...(model.services ?? []),
      ...(model.appointments ?? []),
    ];

    final List<Widget> items = allData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      if (item is LatestCreatedAdvisoryService || item is MostBoughtAdvisoryService) {
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).name ?? '',
          description: (item as dynamic).description ?? 'لا يوجد وصف متاح',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.advisories,
          onPressed: () => context.pushNamed(Routes.advisoryScreen),
        );
      } else if (item is LatestCreatedService || item is MostBoughtService) {
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).title ?? '',
          description: (item as dynamic).intro ?? 'لا يوجد وصف متاح',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.services,
          onPressed: () => context.pushNamed(Routes.services),
        );
      } else { // Appointment
        return ItemCardWidget(
          index: index,
          name: (item as dynamic).name ?? '',
          description: 'موعد مع ${(item as dynamic).name ?? "محامي"}',
          total: '${(item as dynamic).minPrice} - ${(item as dynamic).maxPrice} ريال',
          id: (item as dynamic).id ?? 0,
          iconPath: AppAssets.appointments,
          onPressed: () => context.pushNamed(Routes.appointmentYmatz),
        );
      }
    }).toList();

    return _limitItems(items, _showAllLatest, () {
      setState(() {
        _showAllLatest = true;
      });
    });
  }

  // دالة لتحديد العناصر وعرض زر المزيد
  List<Widget> _limitItems(List<Widget> items, bool showAll, VoidCallback onShowMore) {
    if (items.isEmpty) return [];
    
    final List<Widget> displayedItems = [];
    displayedItems.add(SizedBox(height: 10.h));
    
    if (showAll || items.length <= 5) {
      displayedItems.addAll(items);
    } else {
      displayedItems.addAll(items.take(5));
      displayedItems.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: TextButton(
              onPressed: onShowMore,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'عرض المزيد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: appColors.primaryColorYellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    
    displayedItems.add(SizedBox(height: 20.h));
    return displayedItems;
  }

  // دالة للتحقق من وجود محتوى في الأكثر طلباً
  bool _buildEmptyContent(BuildContext context) {
    final hasAdvisoryServices = getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.advisoryServices?.isNotEmpty ?? false;
    final hasServices = getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.services?.isNotEmpty ?? false;
    final hasAppointments = getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.appointments?.isNotEmpty ?? false;
    
    return !hasAdvisoryServices && !hasServices && !hasAppointments;
  }

  // دالة للتحقق من وجود محتوى في المضاف حديثاً
  bool _buildEmptyLatestContent(BuildContext context) {
    final hasAdvisoryServices = getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.advisoryServices?.isNotEmpty ?? false;
    final hasServices = getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.services?.isNotEmpty ?? false;
    final hasAppointments = getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.appointments?.isNotEmpty ?? false;
    
    return !hasAdvisoryServices && !hasServices && !hasAppointments;
  }

  // دالة لبناء حالة فارغة
  Widget _buildEmptyState(String message) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 60.sp,
              color: appColors.grey3,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: appColors.grey10,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // دالة لبناء حالة التحميل
  Widget _buildLoadingState() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              height: 50.w,
              child: CircularProgressIndicator(
                color: appColors.primaryColorYellow,
                strokeWidth: 3.w,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'جاري التحميل...',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: appColors.grey10,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
