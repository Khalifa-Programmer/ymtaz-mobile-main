import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';

import '../../../../../config/themes/styles.dart';
import '../../logic/my_account_cubit.dart';
import '../../logic/my_account_state.dart';

class PayoutSettingScreen extends StatefulWidget {
  const PayoutSettingScreen({super.key});

  @override
  State<PayoutSettingScreen> createState() => _PayoutSettingScreenState();
}

class _PayoutSettingScreenState extends State<PayoutSettingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _ibanController = TextEditingController();

  @override
  void dispose() {
    _bankNameController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, 'إعدادات الدفع'),
      body: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          state.maybeWhen(
            successGetPayoutIban: (data) {
              // Fill form with existing data
              if (data.data?.accountBankInfo != null) {
                _bankNameController.text =
                    data.data!.accountBankInfo!.bankName ?? '';
                _ibanController.text =
                    data.data!.accountBankInfo!.accountNumber ?? '';
              }
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'يتم التحويل تلقائيا بشكل شهري للمدفوعات',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFieldPrimary(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال اسم البنك';
                      }
                      return null;
                    },
                    hintText: 'اسم البنك',
                    externalController: _bankNameController,
                    title: 'اسم البنك',
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFieldPrimary(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء إدخال رقم الآيبان';
                      }
                      return null;
                    },
                    hintText: 'مثال : SA1234567890123456789012',
                    externalController: _ibanController,
                    title: 'رقم الآيبان',
                  ),
                  SizedBox(height: 24.h),
                  state.maybeWhen(
                    loadingGetPayoutIban: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    orElse: () => Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: appColors.primaryColorYellow,
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _saveIban,
                        child: Text(
                          "حفظ",
                          style: TextStyles.cairo_12_bold.copyWith(
                            color: appColors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveIban() {
    if (_formKey.currentState!.validate()) {
      final formData = FormData.fromMap({
        'bank_name': _bankNameController.text,
        'account_number': _ibanController.text,
      });

      context.read<MyAccountCubit>().addIban(formData);
    }
  }
}
