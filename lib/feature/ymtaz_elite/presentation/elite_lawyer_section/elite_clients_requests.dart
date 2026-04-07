import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/spacing.dart';
import '../../data/model/elite_pricing_requests_model.dart';
import '../../data/model/elite_my_requests_model.dart';
import '../../logic/ymtaz_elite_cubit.dart';
import '../../../../core/router/routes.dart';
import '../elite_request_details_screen.dart';
import 'elite_client_order_screen.dart';

class EliteClientsRequests extends StatefulWidget {
  const EliteClientsRequests({super.key});

  @override
  State<EliteClientsRequests> createState() => _EliteClientsRequestsState();
}

class _EliteClientsRequestsState extends State<EliteClientsRequests> with SingleTickerProviderStateMixin {
  late YmtazEliteCubit _cubit;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<YmtazEliteCubit>();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _cubit.getPricingRequests(forceRefresh: true),
      _cubit.getEliteRequests(forceRefresh: true),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(
        context, 
        'طلبات النخبة',
        onBackPressed: () {
          Navigator.pushNamedAndRemoveUntil(
            context, 
            Routes.homeLayout, 
            (route) => false,
            arguments: 1, // Index 1 is Office tab for providers
          );
        },
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFD4AF37),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFD4AF37),
          labelStyle: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold, fontSize: 13.sp),
          tabs: const [
            Tab(text: 'طلباتي الخاصة'),
            Tab(text: 'طلبات التسعير'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyRequestsTab(),
          _buildPricingRequestsTab(),
        ],
      ),
    );
  }

  Widget _buildPricingRequestsTab() {
    final currentUserId = CacheHelper.getData(key: 'userId')?.toString();
    return RefreshIndicator(
      onRefresh: () => _cubit.getPricingRequests(forceRefresh: true),
      child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
        builder: (context, state) {
          final requests = _cubit.pricingRequests;
          
          if ((state is YmtazEliteLoading && requests == null)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (requests != null) {
            // Filter out my own requests from the pricing tab
            final filtered = requests.where((r) => r.accountId?.toString() != currentUserId).toList();
            
            if (filtered.isEmpty) {
              return _buildEmptyState('لا توجد طلبات تسعير من عملاء حالياً');
            }
            final sorted = filtered..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: sorted.length,
              itemBuilder: (context, index) => _buildEliteRequestCard(context, sorted[index], index),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildMyRequestsTab() {
    return RefreshIndicator(
      onRefresh: () => _cubit.getEliteRequests(forceRefresh: true),
      child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
        builder: (context, state) {
          final requests = _cubit.eliteRequests;
          
          if ((state is YmtazEliteLoading && requests == null)) {
            return const Center(child: CircularProgressIndicator());
          }

          if (requests != null) {
            if (requests.isEmpty) {
              return _buildEmptyState('لم تقم بإضافة أي طلبات نخبة بعد');
            }
            final sorted = requests.toList()..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: sorted.length,
              itemBuilder: (context, index) {
                final request = sorted[index];
                return _buildMyRequestCard(context, request, index);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Center(child: Text(message, style: const TextStyle(fontFamily: 'Cairo'))),
      ),
    );
  }

  Widget _buildMyRequestCard(BuildContext context, Request request, int index) {
    final borderColor = index % 2 == 0 ? const Color(0xFF0F2D37) : const Color(0xFFD4AF37);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EliteRequestDetailsScreen(request: request),
          ),
        ).then((_) => _loadData());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: borderColor, width: 4.0)),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 9, offset: const Offset(3, 3))],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: appColors.grey.withOpacity(0.2),
                  child: Icon(Icons.person, size: 20.r, color: appColors.grey),
                ),
                horizontalSpace(10.w),
                Expanded(
                  child: Text(
                    "طلبي الشخصي #${request.id}",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF0F2D37), fontFamily: 'Cairo'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: appColors.grey15, size: 12.r)
              ],
            ),
            verticalSpace(12.h),
            _buildCardRow("عنوان الطلب", request.serviceTitle ?? ''),
            verticalSpace(5.h),
            _buildCardRow("نوع الطلب", request.eliteServiceCategory?.name ?? ''),
            verticalSpace(5.h),
            _buildCardRow("وقت الطلب", '${getDate(request.createdAt!)} , ${getTime(request.createdAt!)}'),
            verticalSpace(12.h),
            const Divider(color: appColors.grey, thickness: 0.5),
            verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatusBadge('طلبي', const Color(0xFFFFF8E1), appColors.primaryColorYellow),
                _buildStatusBadge(request.status == 'pending-pricing' ? 'بانتظار التسعير' : request.status ?? '', const Color(0xFFE3F2FD), Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 80.w, child: Text(label, style: TextStyle(fontSize: 11.sp, color: appColors.grey15, fontFamily: 'Cairo'))),
        horizontalSpace(10.w),
        Expanded(child: Text(value, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: const Color(0xFF0F2D37), fontFamily: 'Cairo'), maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildStatusBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(5.r)),
      child: Text(text, style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: textColor, fontFamily: 'Cairo')),
    );
  }

  Widget _buildEliteRequestCard(BuildContext context, PendingPricing request, int index) {
    // Alternate border color between Navy (0xFF0F2D37) and Gold (0xFFD4AF37)
    final borderColor = index % 2 == 0 ? const Color(0xFF0F2D37) : const Color(0xFFD4AF37);
    
    return GestureDetector(
      onTap: () {
        _cubit.selectRequest(request);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _cubit,
              child: EliteClientOrderScreen(cubit: _cubit),
            ),
          ),
        ).then((_) => _loadData());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: borderColor,
              width: 4.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(3, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: appColors.grey.withOpacity(0.2),
                  child: Icon(Icons.person, size: 20.r, color: appColors.grey),
                ),
                horizontalSpace(10.w),
                Expanded(
                  child: Text(
                    request.effectiveAccount?.fullName != null && request.effectiveAccount!.fullName.isNotEmpty 
                      ? "طلب من: ${request.effectiveAccount!.fullName}" 
                      : "طلب من عميل",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D37),
                      fontFamily: 'Cairo',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: appColors.grey15,
                  size: 15.r,
                )
              ],
            ),
            verticalSpace(12.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "عنوان الطلب",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.grey15,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    verticalSpace(5.h),
                    Text(
                      "نوع الطلب",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.grey15,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    verticalSpace(5.h),
                    Text(
                      "وقت الطلب",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: appColors.grey15,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                horizontalSpace(20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.serviceTitle ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D37),
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(5.h),
                      Text(
                        request.eliteServiceCategory?.name ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D37),
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace(5.h),
                      Text(
                        '${getDate(request.createdAt!)} , ${getTime(request.createdAt!)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F2D37),
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
            verticalSpace(12.h),
            const Divider(color: appColors.grey, thickness: 0.5),
            verticalSpace(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 // Importance (Level)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    "مهم جداً",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: appColors.primaryColorYellow,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
                // Status
                 Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    request.status == 'pending-pricing' ? 'قيد التسعير' : request.status ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
