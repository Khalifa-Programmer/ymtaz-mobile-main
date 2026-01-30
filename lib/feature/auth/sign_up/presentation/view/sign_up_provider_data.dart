import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/widgets/stepper.dart';

class SignUpProviderData extends StatelessWidget {
  SignUpProviderData({super.key, required this.data});

  Map data = {};
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is LoadingSignUpProvider ||
            current is SuccessSignUpProvider ||
            current is ErrorSignUpProvider,
        listener: (context, state) {
          state.whenOrNull(
            loadingSignUpProvider: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successSignUpProvider: (successLoginMessage) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: successLoginMessage.message ?? "",
                  route: Routes.login,
                  buttonText: "استمرار",
                  type: AlertType.success);
            },
            errorSignUpProvider: (error) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: "أعد المحاولة",
                  type: AlertType.error);
            },
            loadingCountries: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successCountries: (countries) {},
            errorCountries: (error) {},
          );
        },
        child: Scaffold(
          body: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return SafeArea(
                child: StepsSignUp(data: data),
              );
            },
          ),
        ));
  }
}
