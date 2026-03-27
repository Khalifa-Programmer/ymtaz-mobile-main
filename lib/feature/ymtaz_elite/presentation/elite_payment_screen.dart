import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

class ElitePaymentScreen extends StatelessWidget {
  final Request request;
  final TypesImportance offer;

  const ElitePaymentScreen({super.key, required this.request, required this.offer});

  @override
  Widget build(BuildContext context) {
    final double price = (offer.price ?? 2500).toDouble();
    final double taxPercent = 0.15;
    final double taxAmount = price * taxPercent;
    final double total = price + taxAmount;

    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          launchUrl(Uri.parse(state.paymentUrl),
              mode: LaunchMode.externalApplication);
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: appColors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildBlurredAppBar(context, "الدفع"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Payment Method Selection
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EDEF), // Light greyish blue
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFF0F2D37).withOpacity(0.5), width: 1),
                      ),
                      child: Row(
                        children: [
                          // Card Logos
                          Row(
                            children: [
                              _buildVisaLogo(),
                              horizontalSpace(4.w),
                              _buildMasterCardLogo(),
                              horizontalSpace(4.w),
                              _buildAmexLogo(),
                              horizontalSpace(4.w),
                              _buildDiscoverLogo(),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "بطاقة الائتمان",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0F2D37),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          horizontalSpace(12.w),
                          // Radio button equivalent
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF0F2D37), width: 2),
                            ),
                            padding: EdgeInsets.all(3.w),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF0F2D37),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    verticalSpace(40.h),
                    
                    // Fees Label
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الرسوم",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFFC4C4C4),
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    verticalSpace(16.h),
                    
                    // Fees Box
                    Container(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Column(
                        children: [
                          _buildPriceRow("السعر", "${price.toInt()} ريال"),
                          verticalSpace(16.h),
                          _buildPriceRow(
                            "الضرائب", 
                            "${(taxPercent * 100).toInt()}%",
                            subtitle: "*السعر شامل ضريبة القيمة المضافة"
                          ),
                          verticalSpace(24.h),
                          Divider(color: Colors.grey[100], thickness: 1),
                          verticalSpace(24.h),
                          _buildPriceRow(
                            "المجموع الكلي", 
                            "${total.toInt()} ريال", 
                            isTotal: true
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Button
            Padding(
              padding: EdgeInsets.all(20.w),
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                  builder: (context, state) {
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: state is YmtazEliteOfferApprovalLoading
                          ? null
                          : () {
                              context.read<YmtazEliteCubit>().approveOffer(
                                    offer.id.toString(),
                                    "elite",
                                  );
                            },
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37), // Golden color
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: state is YmtazEliteOfferApprovalLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : Text("اتمام الطلب",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Cairo',
                                    color: Colors.white,
                                  )),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisaLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Center(
        child: Text(
          "VISA",
          style: TextStyle(
            color: const Color(0xFF1A1F71),
            fontWeight: FontWeight.w900,
            fontSize: 9.sp,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildMasterCardLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Center(
        child: SizedBox(
          width: 14.w,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEB001B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 9.w,
                  height: 9.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF79E1B).withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmexLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: const Color(0xFF016FD0),
        borderRadius: BorderRadius.circular(3.r),
      ),
      child: Center(
        child: Text(
          "AMEX",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 7.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscoverLogo() {
    return Container(
      width: 32.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3.r),
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "DISC",
              style: TextStyle(
                color: const Color(0xFF444444),
                fontWeight: FontWeight.bold,
                fontSize: 6.sp,
              ),
            ),
            Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFF6000),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isTotal = false, String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: isTotal ? 18.sp : 14.sp,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? const Color(0xFFD4AF37) : const Color(0xFF0F2D37),
                fontFamily: 'Cairo',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF0F2D37),
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          verticalSpace(4.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ],
    );
  }
}
