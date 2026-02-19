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

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/constants/colors.dart';
import '../../account/presentation/guest_screen.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({super.key});

  String userType = CacheHelper.getData(key: 'userType');

  @override
  Widget build(BuildContext context) {
    final cubit = getit<MyPageCubit>();
    if (userType != "guest") {
      cubit.getMyPageData();
    }
    return BlocProvider.value(
      value: cubit,
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
class MyPageClientImproved extends StatelessWidget {
  const MyPageClientImproved({super.key});

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

  // استخراج دالة لبناء عناصر الأكثر طلباً
  List<Widget> _buildMostBoughtItems(BuildContext context) {
    final List<Widget> widgets = [];
    
    widgets.add(SizedBox(height: 10.h));
    
    // الخدمات الاستشارية
    if (getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.advisoryServices?.isNotEmpty ?? false) {
      widgets.add(_buildSectionTitle('الخدمات الاستشارية'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.mostBought!.advisoryServices!.map(
          (service) => ItemCardWidget(
            index: service.id ?? 0,
            name: service.name ?? '',
            description: service.description ?? 'لا يوجد وصف متاح',
            total: '${service.minPrice} - ${service.maxPrice} ريال',
            id: service.id ?? 0,
            iconPath: AppAssets.advisories,
            onPressed: () => context.pushNamed(Routes.advisoryScreen),
          ),
        ),
      );
    }
    
    // الخدمات
    if (getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.services?.isNotEmpty ?? false) {
      widgets.add(SizedBox(height: 15.h));
      widgets.add(_buildSectionTitle('الخدمات'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.mostBought!.services!.map(
          (service) => ItemCardWidget(
            index: service.id ?? 0,
            name: service.title ?? '',
            description: service.intro ?? 'لا يوجد وصف متاح',
            total: '${service.minPrice} - ${service.maxPrice} ريال',
            id: service.id ?? 0,
            iconPath: AppAssets.services,
            onPressed: () => context.pushNamed(Routes.services),
          ),
        ),
      );
    }
    
    // المواعيد
    if (getit<MyPageCubit>().lastAddedModel?.data?.mostBought?.appointments?.isNotEmpty ?? false) {
      widgets.add(SizedBox(height: 15.h));
      widgets.add(_buildSectionTitle('المواعيد'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.mostBought!.appointments!.map(
          (appointment) => ItemCardWidget(
            index: appointment.id ?? 0,
            name: appointment.name ?? '',
            description: 'موعد مع ${appointment.name ?? "محامي"}',
            total: '${appointment.minPrice} - ${appointment.maxPrice} ريال',
            id: appointment.id ?? 0,
            iconPath: AppAssets.appointments,
            onPressed: () => context.pushNamed(Routes.appointmentYmatz),
          ),
        ),
      );
    }
    
    // إضافة مساحة في النهاية
    widgets.add(SizedBox(height: 20.h));
    
    return widgets;
  }

  // استخراج دالة لبناء العناصر المضافة حديثاً
  List<Widget> _buildLatestCreatedItems(BuildContext context) {
    final List<Widget> widgets = [];
    
    widgets.add(SizedBox(height: 10.h));
    
    // الخدمات الاستشارية
    if (getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.advisoryServices?.isNotEmpty ?? false) {
      widgets.add(_buildSectionTitle('الخدمات الاستشارية'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.latestCreated!.advisoryServices!.map(
          (service) => ItemCardWidget(
            index: service.id ?? 0,
            name: service.name ?? '',
            description: service.description ?? 'لا يوجد وصف متاح',
            total: '${service.minPrice} - ${service.maxPrice} ريال',
            id: service.id ?? 0,
            iconPath: AppAssets.advisories,
            onPressed: () => context.pushNamed(Routes.advisoryScreen),
          ),
        ),
      );
    }
    
    // الخدمات
    if (getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.services?.isNotEmpty ?? false) {
      widgets.add(SizedBox(height: 15.h));
      widgets.add(_buildSectionTitle('الخدمات'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.latestCreated!.services!.map(
          (service) => ItemCardWidget(
            index: service.id ?? 0,
            name: service.title ?? '',
            description: service.intro ?? 'لا يوجد وصف متاح',
            total: '${service.minPrice} - ${service.maxPrice} ريال',
            id: service.id ?? 0,
            iconPath: AppAssets.services,
            onPressed: () => context.pushNamed(Routes.services),
          ),
        ),
      );
    }
    
    // المواعيد
    if (getit<MyPageCubit>().lastAddedModel?.data?.latestCreated?.appointments?.isNotEmpty ?? false) {
      widgets.add(SizedBox(height: 15.h));
      widgets.add(_buildSectionTitle('المواعيد'));
      widgets.add(SizedBox(height: 10.h));
      widgets.addAll(
        getit<MyPageCubit>().lastAddedModel!.data!.latestCreated!.appointments!.map(
          (appointment) => ItemCardWidget(
            index: appointment.id ?? 0,
            name: appointment.name ?? '',
            description: 'موعد مع ${appointment.name ?? "محامي"}',
            total: '${appointment.minPrice} - ${appointment.maxPrice} ريال',
            id: appointment.id ?? 0,
            iconPath: AppAssets.appointments,
            onPressed: () => context.pushNamed(Routes.appointmentYmatz),
          ),
        ),
      );
    }
    
    // إضافة مساحة في النهاية
    widgets.add(SizedBox(height: 20.h));
    
    return widgets;
  }

  // دالة لبناء عنوان القسم
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: appColors.primaryColorYellow,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: appColors.blue100,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
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
    );
  }

  // دالة لبناء حالة التحميل
  Widget _buildLoadingState() {
    return Center(
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
    );
  }
}
