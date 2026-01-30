import 'package:yamtaz/feature/layout/account/data/models/success_fcm_response.dart';

import '../data/model/my_package_model.dart';
import '../data/model/packages_model.dart';
import '../data/model/packages_subscribe_model.dart';


sealed class PackagesAndSbuscriptionsState {}

final class PackagesAndSbuscriptionsInitial extends PackagesAndSbuscriptionsState {}


class Initial extends PackagesAndSbuscriptionsState {}

class Loading extends PackagesAndSbuscriptionsState {}

class Loaded extends PackagesAndSbuscriptionsState {
  final PackagesModel data;
  Loaded(this.data);
}
class LoadedMyPackage extends PackagesAndSbuscriptionsState {
  final MyPackageModel data;
  LoadedMyPackage(this.data);
}

class Error extends PackagesAndSbuscriptionsState {
  final String message;
  Error(this.message);
}

class LoadingBuy extends PackagesAndSbuscriptionsState {}

class LoadedBuy extends PackagesAndSbuscriptionsState {
  final PackagesSubscribeModel data;
  LoadedBuy(this.data);
}

class ErrorBuy extends PackagesAndSbuscriptionsState {
  final String message;
  ErrorBuy(this.message);
}

class LoadingConfirm extends PackagesAndSbuscriptionsState {}

class LoadedConfirm extends PackagesAndSbuscriptionsState {
  final SuccessFcmResponse data;
  LoadedConfirm(this.data);
}

class ErrorConfirm extends PackagesAndSbuscriptionsState {
  final String message;
  ErrorConfirm(this.message);
}
