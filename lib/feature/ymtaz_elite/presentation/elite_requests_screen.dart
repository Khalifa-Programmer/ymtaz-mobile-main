import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';

import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';

class EliteRequestsScreen extends StatelessWidget {
  const EliteRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<YmtazEliteCubit>()..getEliteRequests(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFBFB),
        appBar: buildBlurredAppBar(context, "طلبات النخبة"),
        body: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
          builder: (context, state) {
            if (state is YmtazEliteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is YmtazEliteError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: Colors.grey[400]),
                    verticalSpace(16.h),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[500],
                        fontFamily: 'Cairo',
                      ),
                    ),
                    verticalSpace(16.h),
                    TextButton.icon(
                      onPressed: () => context.read<YmtazEliteCubit>().getEliteRequests(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة', style: TextStyle(fontFamily: 'Cairo')),
                    ),
                  ],
                ),
              );
            }

            if (state is YmtazEliteRequestsLoaded) {
              if (state.requests.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.crown,
                        width: 60.w,
                        colorFilter: ColorFilter.mode(
                          Colors.grey[300]!,
                          BlendMode.srcIn,
                        ),
                      ),
                      verticalSpace(20.h),
                      Text(
                        "لا توجد طلبات حتى الآن",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2D37),
                          fontFamily: 'Cairo',
                        ),
                      ),
                      verticalSpace(8.h),
                      Text(
                        "يمكنك تقديم طلب جديد من الشاشة الرئيسية",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                );
              }
              final reversedRequests = state.requests.reversed.toList();
              
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                itemCount: reversedRequests.length,
                itemBuilder: (context, index) {
                  final request = reversedRequests[index];
                  return _buildRequestCard(context, request);
                },
              );
            }

            // Initial state: show loading
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildRequestCard(BuildContext context, Request request) {
    return InkWell(
      onTap: () {
        if (request.offers != null &&
            request.offers!.reservationType != null &&
            (request.offers!.reservationType!.typesImportance?.isNotEmpty ?? false)) {
           context.pushNamed(
            Routes.eliteConsultantOffers,
            arguments: request,
          );
        } else {
          context.pushNamed(
            Routes.eliteRequestDetails,
            arguments: request,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Crown Icon (Far Left)
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF6E9),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: const Color(0xFF0F2D37).withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(8.w),
                  child: SvgPicture.asset(
                    AppAssets.crown,
                    colorFilter: const ColorFilter.mode(
                        Color(0xFFD4AF37), BlendMode.srcIn),
                  ),
                ),
                horizontalSpace(12.w),
                // Title and Subject (Middle/Left side)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.eliteServiceCategory?.name ?? '',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2D37),
                          fontFamily: 'Cairo',
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (request.offers?.advisoryServiceSub?.name != null || request.offers?.serviceSub?.title != null)
                        Text(
                          request.offers?.advisoryServiceSub?.name ?? request.offers?.serviceSub?.title ?? '',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF8B7355),
                            fontFamily: 'Cairo',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                // Date and Time (Right side)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      getDate(request.createdAt),
                      style: TextStyle(
                        color: const Color(0xFF0F2D37).withOpacity(0.5),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      getTime(request.createdAt ?? ""),
                      style: TextStyle(
                        color: const Color(0xFF00BABA),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Description
            SizedBox(
              width: double.infinity,
              child: Text(
                request.description ?? '',
                maxLines: 4,
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 12.sp,
                  fontFamily: 'Cairo',
                  height: 1.6,
                ),
              ),
            ),

            // Lawyer Avatar if available
            if (request.offers != null &&
                request.offers!.reservationType != null &&
                (request.offers!.reservationType!.typesImportance?.isNotEmpty ?? false) &&
                request.offers!.reservationType!.typesImportance!.first.lawyer?.image != null)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: request.offers!.reservationType!.typesImportance!.first.lawyer!.image!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(Icons.person, color: Colors.grey[400], size: 20.sp),
                      ),
                    ),
                  ),
                ),
              ),

            verticalSpace(16.h),
            Divider(color: Colors.grey[50], thickness: 1.5),
            verticalSpace(12.h),
            // Status Tags
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildStatusTag(request.status ?? "قيد الدراسة"),
                horizontalSpace(12.w),
                _buildImportanceTag(
                  (request.status == "مكتملة" || request.status == "مكتمل")
                  ? "متوسط الأهمية" : "مهم جداً",
                  const Color(0xFFD4AF37)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color textColor;
    Color bgColor;
    String displayStatus = status;

    if (status == "pending-pricing") {
      displayStatus = "قيد التسعير";
      textColor = const Color(0xFF2DAFAF);
      bgColor = const Color(0xFFE6F7F7);
    } else if (status == "قيد الدراسة" || status == "قيد الإنتظار") {
      textColor = const Color(0xFF2DAFAF);
      bgColor = const Color(0xFFE6F7F7);
    } else if (status == "مكتملة" || status == "مكتمل") {
      textColor = const Color(0xFF4CAF50);
      bgColor = const Color(0xFFE8F5E9);
    } else {
      textColor = const Color(0xFF2DAFAF);
      bgColor = const Color(0xFFE6F7F7);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        displayStatus,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  Widget _buildImportanceTag(String importance, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        importance,
        style: TextStyle(
          color: color,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
