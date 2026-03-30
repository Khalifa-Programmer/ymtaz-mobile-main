import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';

class EliteConsultantOffersScreen extends StatelessWidget {
  final Request request;

  const EliteConsultantOffersScreen({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    final offers = request.offers?.reservationType?.typesImportance ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: buildBlurredAppBar(context, "عروض فريقك الاستشاري"),
      body: offers.isEmpty
          ? const Center(
              child: Text(
                "لا توجد عروض حالياً",
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return _buildOfferCard(context, offer);
              },
            ),
    );
  }

  Widget _buildOfferCard(BuildContext context, TypesImportance offer) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Service" label
          Text(
            "خدمة",
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[400],
              fontFamily: 'Cairo',
            ),
          ),
          
          // Service Name
          Text(
            request.eliteServiceCategory?.name ?? "توكيل محامي",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(12.h),

          // Badges
          Row(
            children: [
              Flexible(
                child: _buildBadge(
                  "2-3 أيام", 
                  backgroundColor: const Color(0xFFF2F2F2),
                  textColor: const Color(0xFF5A5A5A),
                ),
              ),
              horizontalSpace(8.w),
              Flexible(
                child: _buildBadge(
                  "مهم - ${offer.price ?? 0} رس",
                  backgroundColor: const Color(0xFFFAF6E9),
                  textColor: const Color(0xFFD4AF37),
                ),
              ),
            ],
          ),
          
          verticalSpace(16.h),
          Divider(color: Colors.grey[100], thickness: 1),
          verticalSpace(16.h),

          // Description
          Text(
            request.description ?? "لا يوجد وصف متوفر لهذا الطلب.",
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF8E8E8E),
              fontFamily: 'Cairo',
              height: 1.8,
            ),
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
          ),
          
          verticalSpace(30.h),

          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              color: const Color(0xFFD4AF37),
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  Routes.elitePriceOffer, 
                  arguments: {
                    'request': request,
                    'offer': offer,
                  }
                );
              },
              child: Text(
                "قبول السعر",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          verticalSpace(12.h),
          SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              color: const Color(0xFFF5F5F5),
              onPressed: () {
                Navigator.pushNamed(
                  context, 
                  Routes.eliteRepricingRequest, 
                  arguments: {
                    'request': request,
                    'offer': offer,
                  }
                );
              },
              child: Text(
                "طلب إعادة تسعير",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
          verticalSpace(12.h),
          Center(
            child: TextButton(
              onPressed: () => Navigator.maybePop(context),
              child: Text(
                "تجاهل",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, {required Color backgroundColor, required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }
}
