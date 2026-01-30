import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/widgets/edit_profile.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../l10n/locale_keys.g.dart';
import '../../../../auth/sign_up/presentation/view/sign_up.dart';

String? phone;

class EditProviderData extends StatelessWidget {
  EditProviderData({
    super.key,
  });

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) =>
            current is LoadingEditProvider ||
            current is SuccessEditProvider ||
            current is ErrorEditProvider ||
            current is SuccessAllData,
        listener: (context, state) {
          state.whenOrNull(
            loadingEditProvider: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successEditProvider: (successLoginMessage) async {
              context.pop();
              if (successLoginMessage.data!.account!.status != 2) {
                token = await CacheHelper.getData(key: "token");
                getit<MyAccountCubit>().deleteFcmToken(token);
                CacheHelper.removeData(key: 'token');
                CacheHelper.removeData(key: 'rememberMe');
                CacheHelper.removeData(key: 'userType');
                context.pushNamed(Routes.login);
                AppAlerts.showAlert(
                    context: context,
                    message: successLoginMessage.message!,
                    buttonText: LocaleKeys.continueNext.tr(),
                    type: AlertType.success);
              } else {
                AppAlerts.showAlert(
                    context: context,
                    message: successLoginMessage.message!,
                    isForceRouting: true,
                    buttonText: LocaleKeys.continueNext.tr(),
                    route: Routes.homeLayout,
                    type: AlertType.success);
              }
            },
            errorEditProvider: (error) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: error,
                  buttonText: LocaleKeys.retry.tr(),
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
          appBar: AppBar(
            title: Text(LocaleKeys.editServiceProviderData.tr()),
            centerTitle: true,
            actions: [
              if (kDebugMode)
                IconButton(
                  icon: const Icon(
                    Icons.update,
                    color: appColors.primaryColorYellow,
                  ),
                  onPressed: () {
                    getit<SignUpCubit>().loadUserData(getit<MyAccountCubit>()
                        .userDataResponse as LoginProviderResponse);
                  },
                ),
            ],
          ),
          body: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return const SafeArea(
                child: EditProileStepsProvider(data: {}),
              );
            },
          ),
        ));
  }
}
