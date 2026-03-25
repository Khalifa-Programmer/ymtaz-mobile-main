import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/spacing.dart';
import '../../data/model/elite_pricing_requests_model.dart';
import '../../logic/ymtaz_elite_cubit.dart';
import 'elite_client_order_screen.dart';

class EliteClientsRequests extends StatefulWidget {
  const EliteClientsRequests({super.key});

  @override
  State<EliteClientsRequests> createState() => _EliteClientsRequestsState();
}

class _EliteClientsRequestsState extends State<EliteClientsRequests> {
  late final YmtazEliteCubit _cubit;
  
  @override
  void initState() {
    super.initState();
    _cubit = context.read<YmtazEliteCubit>();
    _loadData();
  }

  Future<void> _loadData() async {
    await _cubit.getPricingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: buildBlurredAppBar(context, 'طلبات النخبة'),
        body: RefreshIndicator(
          onRefresh: _loadData,
          child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
            builder: (context, state) {
              if (state is YmtazEliteLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is YmtazElitePricingRequestsLoaded) {
                if (state.requests.isEmpty) {
                  return const Center(child: Text('لا توجد طلبات نخبة حالياً'));
                }
                final sortedRequests = state.requests.toList()
                  ..sort((a, b) => DateTime.parse(b.createdAt!).compareTo(DateTime.parse(a.createdAt!)));

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  itemCount: sortedRequests.length,
                  itemBuilder: (context, index) {
                    final request = sortedRequests[index];
                    return _buildEliteRequestCard(context, request);
                  },
                );
              }
              if (state is YmtazEliteError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('حدث خطأ ما'),
                      TextButton(
                        onPressed: _loadData,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('لا توجد طلبات نخبة حالياً'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEliteRequestCard(BuildContext context, PendingPricing request) {
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
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            right: BorderSide(
              color: Color(0xFF0F2D37), // Navy Blue
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
              children: [
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
                horizontalSpace(10.w),
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
                const Spacer(),
                Text(
                  "طلب تسعير",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2D37),
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
