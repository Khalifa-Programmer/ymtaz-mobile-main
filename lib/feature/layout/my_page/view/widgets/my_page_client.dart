import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/my_orders_card.dart';
import 'package:yamtaz/feature/digital_office/view/widgets/main_screen/tabs_analysis_for_products.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../../core/router/routes.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../../auth/login/data/models/login_provider_response.dart';
import '../../../../package_and_subscriptions/presentation/widgets/lawyer_package_card.dart';
import '../../../../package_and_subscriptions/presentation/widgets/time_remainig_progress.dart';
import '../../../services/presentation/widgets/item_widget.dart';
import '../../logic/my_page_cubit.dart';
import '../../logic/my_page_state.dart';

class MyPageClient extends StatefulWidget {
  const MyPageClient({super.key});

  @override
  State<MyPageClient> createState() => _MyPageClientState();
}

class _MyPageClientState extends State<MyPageClient> {
  bool _showMoreMostRequested = false;
  bool _showMoreLatestCreated = false;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: appColors.primaryColorYellow,
      onRefresh: () {
        context.read<MyPageCubit>().getMyPageData();
        return Future.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<MyPageCubit, MyPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = getit<MyPageCubit>();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.w),
              child: ConditionalBuilder(
                condition: cubit.myPageResponseModel != null &&
                    cubit.lastAddedModel != null,
                builder: (context) => Animate(
                    effects: [FadeEffect(delay: 200.ms)],
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(20.h),
                            LawyerPackageCard(
                                package: getit<MyAccountCubit>()
                                    .clientProfile!
                                    .data!
                                    .account!
                                    .package),
                            verticalSpace(20.h),
                            TabsAnalysis(
                                data: cubit.myPageResponseModel!.data!.analytics!),
                            verticalSpace(20.h),
                            const MyOrdersItemsClientCard(),
                            verticalSpace(30.h),

                            // Most Requested Section
                            _buildSectionHeader('الأكثر طلباً', () {
                              setState(() {
                                _showMoreMostRequested = !_showMoreMostRequested;
                              });
                            }, _showMoreMostRequested),
                            _buildItemsList(
                              advisories: cubit.lastAddedModel?.data?.mostBought?.advisoryServices ?? [],
                              services: cubit.lastAddedModel?.data?.mostBought?.services ?? [],
                              appointments: cubit.lastAddedModel?.data?.mostBought?.appointments ?? [],
                              showMore: _showMoreMostRequested,
                            ),

                            verticalSpace(30.h),

                            // Recently Added Section
                            _buildSectionHeader('المضاف حديثاً', () {
                              setState(() {
                                _showMoreLatestCreated = !_showMoreLatestCreated;
                              });
                            }, _showMoreLatestCreated),
                            _buildItemsList(
                              advisories: cubit.lastAddedModel?.data?.latestCreated?.advisoryServices ?? [],
                              services: cubit.lastAddedModel?.data?.latestCreated?.services ?? [],
                              appointments: cubit.lastAddedModel?.data?.latestCreated?.appointments ?? [],
                              showMore: _showMoreLatestCreated,
                            ),

                            verticalSpace(40.h),
                          ],
                        ))),
                fallback: (context) => SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(child: CupertinoActivityIndicator()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeMore, bool isExpanded) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
        ),
        TextButton(
          onPressed: onSeeMore,
          child: Text(
            isExpanded ? 'عرض أقل' : 'عرض المزيد',
            style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.primaryColorYellow),
          ),
        ),
      ],
    );
  }

  Widget _buildItemsList({
    required List advisories,
    required List services,
    required List appointments,
    required bool showMore,
  }) {
    List<Widget> items = [];

    // Add Advisories
    for (var service in advisories) {
      items.add(
        ItemCardWidget(
          index: service.id ?? 0,
          name: service.name ?? '',
          description: null,
          total: '${service.minPrice} - ${service.maxPrice} ريال',
          id: service.id ?? 0,
          iconPath: AppAssets.advisories,
          onPressed: () => context.pushNamed(Routes.advisoryScreen),
        ),
      );
    }

    // Add Services
    for (var service in services) {
      items.add(
        ItemCardWidget(
          index: service.id ?? 0,
          name: service.title ?? '',
          description: null,
          total: '${service.minPrice} - ${service.maxPrice} ريال',
          id: service.id ?? 0,
          iconPath: AppAssets.services,
          onPressed: () => context.pushNamed(Routes.services),
        ),
      );
    }

    // Add Appointments
    for (var appt in appointments) {
      items.add(
        ItemCardWidget(
          index: appt.id ?? 0,
          name: appt.name ?? '',
          total: '${appt.minPrice} - ${appt.maxPrice} ريال',
          id: appt.id ?? 0,
          iconPath: AppAssets.appointments,
          onPressed: () => context.pushNamed(Routes.appointmentYmatz),
        ),
      );
    }

    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text('لا توجد بيانات', style: TextStyles.cairo_12_medium.copyWith(color: appColors.grey)),
      );
    }

    final displayedItems = showMore ? items : items.take(3).toList();

    return Column(
      children: displayedItems.map((w) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: w,
      )).toList(),
    );
  }
}
