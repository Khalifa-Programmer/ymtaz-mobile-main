import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_cubit.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_state.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/widgets/features_widgets.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/moyasar_payment_screen.dart';
import '../../../core/widgets/new_payment_success.dart';
import '../data/model/packages_model.dart';
import '../data/model/packages_subscribe_model.dart';

class PackageDetails extends StatefulWidget {
  const PackageDetails({super.key, required this.package});

  final Package package;

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  PackagesSubscribeModel? subscriptionData;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PackagesAndSubscriptionsCubit,
        PackagesAndSbuscriptionsState>(
      listener: (context, state) {
        print('📱 PackageDetails State: $state');
        
        if (state is LoadingBuy) {
          print('⏳ Loading purchase...');
        } else if (state is LoadedBuy) {
          print('✅ Purchase loaded successfully');
          subscriptionData = state.data;
          
          if (subscriptionData?.data == null) {
            print('⚠️ Warning: data.data is null');
            AnimatedSnackBar.material(
              'حدث خطأ في معالجة الطلب',
              type: AnimatedSnackBarType.error,
            ).show(context);
            return;
          }
          
          // فتح شاشة ميسر الرسمية (Native) بدلاً من الـ WebView
          print('💳 Opening Native Moyasar Payment for Package: ${widget.package.name}');
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MoyasarPaymentScreen(
                        amount: widget.package.priceAfterDiscount?.toString() ?? "100",
                        description: "اشتراك باقة ${widget.package.name}",
                        packageId: widget.package.id!.toString(),
                        transactionId: subscriptionData!.data!.transactionId)));
            
            if (result == 'success') {
              print('🎉 Native Payment Success, confirming with backend...');
              if (mounted && (subscriptionData?.data?.subscription?.id != null)) {
                context.read<PackagesAndSubscriptionsCubit>().confirmPaymentPackage(subscriptionData!.data!.subscription!.id!.toString());
              } else if (mounted && (subscriptionData?.data?.transactionId != null)) {
                // Fallback to transaction ID if subscription ID is missing
                context.read<PackagesAndSubscriptionsCubit>().confirmPaymentPackage(subscriptionData!.data!.transactionId!);
              } else {
                print('❌ Error: ID is null');
              }
            }
          });

        } else if (state is ErrorBuy) {
          print('❌ Error buying package: ${state.message}');
          AnimatedSnackBar.material(
            state.message ?? 'حدث خطأ أثناء الاشتراك',
            type: AnimatedSnackBarType.error,
            duration: const Duration(seconds: 4),
          ).show(context);
        } else if (state is LoadedConfirm) {
          print('✅ Payment confirmed successfully');
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NewSuccessPayment()),
              (route) => false
            );
          }
        } else if (state is ErrorConfirm) {
          print('❌ Error confirming payment: ${state.message}');
          // في بيئة التطوير، نسهل الانتقال حتى لو واجه الباك اند مشكلة في المزامنة اللحظية
          if (state.message.contains('404') || state.message.contains('not found')) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => NewSuccessPayment()),
              (route) => false
            );
          } else {
            AnimatedSnackBar.material(
              state.message,
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
            appBar: AppBar(
              title: Text(widget.package.name ?? '',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.04),
                          // Shadow color
                          spreadRadius: 3,
                          // Spread radius
                          blurRadius: 10,
                          // Blur radius
                          offset:
                              const Offset(0, 3), // Offset in x and y direction
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.package.name ?? 'اسم الباقة',
                          style: TextStyles.cairo_16_bold,
                        ),
                        SizedBox(height: 8.h),
                        // rich text to add شهر in small size
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${widget.package.priceAfterDiscount ?? 100} ر.س ',
                                style: TextStyles.cairo_20_bold,
                              ),
                              TextSpan(
                                  text: '/ شهر',
                                  style: TextStyles.cairo_10_semiBold.copyWith(
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'المدة : ${widget.package.duration} يوم',
                              style: TextStyles.cairo_12_semiBold,
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              onPressed: () {
                                if (state is! LoadingBuy) {
                                  BlocProvider.of<
                                              PackagesAndSubscriptionsCubit>(
                                          context)
                                      .subscribePackage(widget.package.id?.toString() ?? "");
                                }
                              },
                              color: appColors.blue100,
                              minimumSize: Size(30.h, 30.h),
                              child: state is LoadingBuy
                                  ? CupertinoActivityIndicator(
                                      color: appColors.white,
                                    )
                                  : Text(
                                      'اشترك الان',
                                      style: TextStyles.cairo_12_bold.copyWith(
                                        color: appColors.white,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  ConditionalBuilder(
                    condition: widget.package.numberOfAdvisoryServices != 0 &&
                        widget.package.numberOfServices != 0 &&
                        widget.package.numberOfReservations != 0,
                    builder: (context) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 5.h),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.04),
                              // Shadow color
                              spreadRadius: 3,
                              // Spread radius
                              blurRadius: 10,
                              // Blur radius
                              offset: const Offset(
                                  0, 3), // Offset in x and y direction
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'منتجات الباقة',
                              style: TextStyles.cairo_16_bold,
                            ),
                            SizedBox(height: 8.h),
                            // rich text to add شهر in small size
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: appColors.primaryColorYellow,
                                    size: 20.w),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '${widget.package.numberOfAdvisoryServices} استشارة شهرية',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: appColors.primaryColorYellow,
                                    size: 20.w),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '${widget.package.numberOfServices} خدمة شهرية',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    color: appColors.primaryColorYellow,
                                    size: 20.w),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    '${widget.package.numberOfReservations} موعد شهري',
                                    style: TextStyle(fontSize: 16.sp),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      );
                    },
                    fallback: (context) {
                      return SizedBox();
                    },
                  ),
                  ConditionalBuilder(
                    condition: widget.package.permissions!.isNotEmpty,
                    builder: (context) {
                      return Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.04),
                              // Shadow color
                              spreadRadius: 3,
                              // Spread radius
                              blurRadius: 10,
                              // Blur radius
                              offset:
                              const Offset(0, 3), // Offset in x and y direction
                            ),
                          ],
                          shape: RoundedRectangleBorder(
                            // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'مميزات الباقة',
                                style: TextStyles.cairo_12_bold.copyWith(
                                  color: appColors.grey15,
                                )
                            ),
                            SizedBox(height: 15.h),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return getFeatureRowById(
                                    widget.package.permissions?[index].id ?? 0,
                                    widget.package.permissions?[index].name ?? '');
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 10.h);
                              },
                              itemCount: widget.package.permissions!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            SizedBox(height: 15.h),

                          ],
                        ),
                      );
                    },
                    fallback: (context) {
                      return SizedBox();
                    },
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shadows: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.04),
                          // Shadow color
                          spreadRadius: 3,
                          // Spread radius
                          blurRadius: 10,
                          // Blur radius
                          offset:
                              const Offset(0, 3), // Offset in x and y direction
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تعليمات الباقة',
                          style: TextStyles.cairo_16_bold,
                        ),
                        SizedBox(height: 8.h),
                        // rich text to add شهر in small size
                        Text(
                          widget.package.instructions ?? 'تعليمات الباقة',
                          style: TextStyles.cairo_12_semiBold
                              .copyWith(color: appColors.grey15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            if (state is LoadingConfirm)
              Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: appColors.primaryColorYellow),
                      SizedBox(height: 20.h),
                      Text(
                        "جاري تأكيد الاشتراك...",
                        style: TextStyles.cairo_16_bold.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "يرجى الانتظار، لا تشغل الشاشة...",
                        style: TextStyles.cairo_12_semiBold.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
