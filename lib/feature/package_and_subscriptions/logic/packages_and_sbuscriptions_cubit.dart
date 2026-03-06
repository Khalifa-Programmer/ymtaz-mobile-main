import 'package:bloc/bloc.dart';
import 'package:yamtaz/feature/package_and_subscriptions/data/model/packages_model.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_state.dart';

import '../data/model/my_package_model.dart';
import '../data/repo/packages_and_subscription_repo.dart';
import 'package:yamtaz/feature/layout/account/data/models/success_fcm_response.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

class PackagesAndSubscriptionsCubit
    extends Cubit<PackagesAndSbuscriptionsState> {
  PackagesAndSubscriptionsCubit(this._packageRepo) : super(Initial());

  final PacakagesAndSubscriptionRepo _packageRepo;

  PackagesModel? packagesModel;

  MyPackageModel? myPackageModel;

  bool isSubscribed = false;

  Future<void> getdata() async {
    isSubscribed = false;
    packagesModel = null;
    myPackageModel = null;
    emit(Loading());
    await myPackage();
    await getPackages();
  }


  Future<void> getPackages() async {
    emit(Loading());
    final response = await _packageRepo.getPackages();
    response.when(
      success: (res) {
        packagesModel = res;
        print('done');

        emit(Loaded(res));
      },
      failure: (fail) {
        emit(Error(fail['message']));
      },
    );
  }

  Future<void> myPackage() async {
    emit(Loading());
    final response = await _packageRepo.myPackage();
    response.when(
      success: (res) {
        myPackageModel = res;
        isSubscribed = res.data!=null;
        print('isSubscribed $isSubscribed');
        emit(LoadedMyPackage(res));
      },
      failure: (fail) {
        emit(Error(fail['message']));
      },
    );
  }

  // Subscribe package

  Future<void> subscribePackage(String id) async {
    emit(LoadingBuy());
    final response = await _packageRepo.subscribePackage(id);
    response.when(
      success: (res) {
        emit(LoadedBuy(res));
      },
      failure: (fail) {
        emit(ErrorBuy(fail['message']));
      },
    );
  }

// Buy package
// Future<void> buyPackages(FormData data) async {
//   emit(LoadingBuy());
//   final response = await _packageRepo.buyPackage(data);
//   response.when(
//     success: (res) {
//       emit(LoadedBuy(res));
//     },
//     failure: (fail) {
//       emit(ErrorBuy(fail['message']));
//     },
//   );
// }
//
  // Confirm payment
  Future<void> confirmPaymentPackage(String id) async {
    emit(LoadingConfirm());
    final response = await _packageRepo.confirmPaymentPackage(id);
    response.when(
      success: (res) {
        emit(LoadedConfirm(res));
        getdata(); // Refresh package info
        getit<MyAccountCubit>().getPayments(); // Refresh invoices
        getit<MyAccountCubit>().refresh(); // Refresh profile/account info
      },
      failure: (fail) {
        String message = 'فشل تأكيد الدفع';
        if (fail is Map && fail.containsKey('message')) {
          message = fail['message'];
        } else if (fail is String) {
          message = fail;
        }
        emit(ErrorConfirm(message));
        getdata(); // Refresh anyway to see if webhook worked
      },
    );
  }
}
