import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/my_payments/payment_details_screen.dart';

import '../../logic/my_account_cubit.dart';

class MyPaymentsScreen extends StatelessWidget {
  const MyPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, "فواتيري"),
      body: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return state.maybeWhen(
            loadingPaymentsDone: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
            successPaymentsDone: (dataModel) {
              final payments = dataModel.data?.payments ?? [];
              return ConditionalBuilder(
                condition: payments.isNotEmpty,
                builder: (context) => ListView.separated(
                  padding: EdgeInsets.all(16.w),
                  itemCount: payments.length,
                  separatorBuilder: (context, index) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final payment = payments[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentDetailsScreen(
                                      payment: payment,
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: appColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: appColors.grey2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: appColors.grey.withOpacity(0.2),
                              blurRadius: 4.r,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  payment.name!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: payment.transactionComplete == 1
                                        ? appColors.green.withOpacity(0.2)
                                        : appColors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    payment.transactionComplete == 1
                                        ? 'مدفوع'
                                        : 'غير مدفوع',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: payment.transactionComplete == 1
                                          ? appColors.green
                                          : appColors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              "#${payment.transactionId}",
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: appColors.grey15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              children: [
                                Text(
                                  '${getDate(payment.createdAt.toString())} - ${getTime(payment.createdAt.toString())}',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: appColors.grey15,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '${payment.price} ر.س',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: appColors.blue100,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                fallback: (context) => Center(
                  child: Text(
                    'لا توجد مدفوعات',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: appColors.grey,
                    ),
                  ),
                ),
              );
            },
            errorPaymentsDone: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حدث خطأ ما',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  SizedBox(height: 8.h),
                  TextButton(
                    onPressed: () =>
                        context.read<MyAccountCubit>().getPayments(),
                    child: Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
            orElse: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        },
      ),
    );
  }
}
