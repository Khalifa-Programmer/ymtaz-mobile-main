import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/widgets/alerts.dart';
import '../../../../../core/widgets/primary/text_form_primary.dart';

class RemoveAccountProvider extends StatelessWidget {
  RemoveAccountProvider({super.key});

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('حذف الحساب',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          if (state is ErrorRemoveAccount) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: state.error,
                buttonText: "أعد المحاولة",
                type: AlertType.error);
          }

          if (state is LoadingRemoveAccount) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          }

          if (state is SuccessRemoveAccount) {
            context.pop();
            CacheHelper.removeData(key: 'token');
            CacheHelper.removeData(key: 'userType');
            context.pushNamedAndRemoveUntil(
              Routes.login,
              predicate: (route) => false,
            );

            AppAlerts.showAlertWithoutError(
                context: context,
                message: state.data.message!,
                buttonText: "استمرار",
                type: AlertType.success);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16.0.sp),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextFieldPrimary(
                      hintText: 'سبب الحذف.....',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء إدخال سبب الحذف';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      typeInputAction: TextInputAction.done,
                      externalController: context
                          .read<MyAccountCubit>()
                          .removeAccountController,
                      multiLine: true,
                      title: 'سبب الحذف',
                    ),
                    CustomTextFieldPrimary(
                      hintText: 'مقترح للتطوير......',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء إدخال مقترح للتطوير';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                      typeInputAction: TextInputAction.done,
                      externalController: context
                          .read<MyAccountCubit>()
                          .removeAccountDevController,
                      multiLine: true,
                      title: 'مقترح للتطوير',
                    ),
                    CustomButton(
                        title: "حذف الحساب",
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            context
                                .read<MyAccountCubit>()
                                .removeAccountProvider();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
