import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/new_payment_success.dart';
import 'package:yamtaz/core/widgets/webpay_new.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

class ServiceOfferWidget extends StatelessWidget {
  final ServiceSub serviceSub;
  final int? price;
  final VoidCallback onReject;
  final String offerId;

  const ServiceOfferWidget({
    Key? key,
    required this.serviceSub,
    this.price,
    required this.onReject,
    required this.offerId,
  }) : super(key: key);

  void _handleApproval(BuildContext context) {
    final cubit = context.read<YmtazEliteCubit>();
    cubit.approveOffer(offerId, 'service');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPaymentScreen(
                link: state.paymentUrl,
              ),
            ),
          );
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عرض خدمة: ${serviceSub.title ?? ""}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.blue100
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                serviceSub.intro ?? "",
                style: TextStyle(fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green, size: 24.r),
                    8.horizontalSpace,
                    Text(
                      'السعر: ${price ?? serviceSub.minPrice ?? 0} ريال',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                builder: (context, state) {
                  if (state is YmtazEliteOfferApprovalLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                      child: CustomButton(
                      onPress: () => _handleApproval(context),
                      title: 'قبول العرض',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsultationOfferWidget extends StatelessWidget {
  final AdvisoryServiceSub advisoryServiceSub;
  final int? price;
  final VoidCallback onReject;
  final String offerId;

  const ConsultationOfferWidget({
    Key? key,
    required this.advisoryServiceSub,
    this.price,
    required this.onReject,
    required this.offerId,
  }) : super(key: key);

  void _handleApproval(BuildContext context) {
    final cubit = context.read<YmtazEliteCubit>();
    cubit.approveOffer(offerId, 'advisory-service');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPaymentScreen(
                link: state.paymentUrl,
              ),
            ),
          );
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'عرض استشارة: ${advisoryServiceSub.name ?? ""}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.blue100
                ),
              ),
              if (advisoryServiceSub.description != null) ...[
                SizedBox(height: 12.h),
                Text(
                  advisoryServiceSub.description!,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green, size: 24.r),
                    SizedBox(width: 8.w),
                    Text(
                      'السعر: ${price ?? advisoryServiceSub.minPrice ?? 0} ريال',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                builder: (context, state) {
                  if (state is YmtazEliteOfferApprovalLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPress: () => _handleApproval(context),
                      title: 'قبول العرض',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentOfferWidget extends StatelessWidget {
  final ReservationType reservationType;
  final DateTime? date;
  final String? fromTime;
  final String? toTime;
  final int? price;
  final VoidCallback onReject;
  final String offerId;

  const AppointmentOfferWidget({
    Key? key,
    required this.reservationType,
    this.date,
    this.fromTime,
    this.toTime,
    this.price,
    required this.onReject,
    required this.offerId,
  }) : super(key: key);

  void _handleApproval(BuildContext context) {
    final cubit = context.read<YmtazEliteCubit>();
    cubit.approveOffer(offerId, 'reservation');
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
      listener: (context, state) {
        if (state is YmtazEliteOfferApprovalSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPaymentScreen(
                link: state.paymentUrl,
              ),
            ),
          );
        } else if (state is YmtazEliteOfferApprovalError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'موعد: ${reservationType.name ?? ""}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: appColors.blue100
                ),
              ),
              SizedBox(height: 16.h),
              if (date != null) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.blue, size: 24.r),
                      SizedBox(width: 8.w),
                      Text(
                        'التاريخ: ${date.toString().split(' ')[0]}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
              ],
              if (fromTime != null && toTime != null) ...[
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Colors.orange, size: 24.r),
                      SizedBox(width: 8.w),
                      Text(
                        'الوقت: $fromTime - $toTime',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green, size: 24.r),
                    SizedBox(width: 8.w),
                    Text(
                      'السعر: ${price ?? reservationType.minPrice ?? 0} ريال',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                builder: (context, state) {
                  if (state is YmtazEliteOfferApprovalLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPress: () => _handleApproval(context),
                      title: 'قبول العرض',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
