import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/feature/auth/register/data/repo/register_repo.dart';
import 'package:yamtaz/feature/auth/register/logic/register_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/repos/contact_ymtaz.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/digital_guide/data/repos/digital_guide_repo.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_office/data/repo/office_provider_repo.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/forensic_guide/logic/forensic_guide_cubit.dart';
import 'package:yamtaz/feature/layout/home/data/repo/home_repo.dart';
import 'package:yamtaz/feature/layout/home/logic/home_cubit.dart';
import 'package:yamtaz/feature/layout/services/data/repos/services_repo.dart';
import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
import 'package:yamtaz/feature/library_guide/data/repo/library_guide_repo.dart';
import 'package:yamtaz/feature/library_guide/logic/library_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/feature/advisory_committees/data/repos/advisory_committees_repo.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_cubit.dart';


import '../../config/enviroment.dart';
import '../../feature/advisory_window/data/repo/advisory_repo.dart';
import '../../feature/advisory_window/logic/advisory_cubit.dart';
import '../../feature/auth/forget_password/data/repos/forget_password_repo.dart';
import '../../feature/auth/forget_password/logic/forget_cubit.dart';
import '../../feature/auth/login/data/repos/login_repo.dart';
import '../../feature/auth/login/logic/login_cubit.dart';
import '../../feature/auth/sign_up/data/repos/sign_up_repo.dart';
import '../../feature/auth/sign_up/logic/sign_up_cubit.dart';
import '../../feature/forensic_guide/data/repo/forensic_repo.dart';
import '../../feature/law_guide/data/repo/law_guide_repo.dart';
import '../../feature/law_guide/logic/law_guide_cubit.dart';
import '../../feature/layout/account/data/repos/my_account_repo.dart';
import '../../feature/layout/account/logic/my_account_cubit.dart';
import '../../feature/layout/my_page/data/repos/my_page_repo.dart';
import '../../feature/layout/my_page/logic/my_page_cubit.dart';
import '../../feature/my_appointments/data/repo/appointment_repo.dart';
import '../../feature/my_appointments/logic/appointments_cubit.dart';
import '../../feature/notifications/data/repo/notification_repo.dart';
import '../../feature/notifications/logic/notification_cubit.dart';
import '../../feature/package_and_subscriptions/data/repo/packages_and_subscription_repo.dart';
import '../../feature/package_and_subscriptions/logic/packages_and_sbuscriptions_cubit.dart';
import '../network/remote/dio_factory.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/book_details_cubit.dart';

final getit = GetIt.instance;

Future<void> setGetIt() async {
  Dio dio = await DioFactory.getDio();

  final env = await Environment.current();

  getit.registerLazySingleton<ApiService>(
      () => ApiService(dio, baseUrl: env.apiBaseUrl));

  // getit.registerLazySingleton<ApiService>(() => ApiService(dio));
  getit.registerLazySingleton<LoginRepo>(() => LoginRepo(getit()));
  getit.registerFactory<LoginCubit>(() => LoginCubit(getit()));

  getit.registerLazySingleton<SignUpRepo>(() => SignUpRepo(getit()));
  getit.registerFactory<SignUpCubit>(() => SignUpCubit(getit()));

  getit.registerLazySingleton<RegisterRepo>(() => RegisterRepo(getit()));
  getit.registerFactory<RegisterCubit>(() => RegisterCubit(getit()));

  getit.registerLazySingleton<ForgetPasswordRepo>(
      () => ForgetPasswordRepo(getit()));
  getit.registerFactory<ForgetCubit>(() => ForgetCubit(getit()));

  getit.registerLazySingleton<MyAccountRepo>(() => MyAccountRepo(getit()));
  getit.registerLazySingleton<MyAccountCubit>(() => MyAccountCubit(getit()));

  getit
      .registerLazySingleton<ContactYmtazRepo>(() => ContactYmtazRepo(getit()));
  getit.registerFactory<ContactYmtazCubit>(() => ContactYmtazCubit(getit()));

  getit
      .registerLazySingleton<DigitalGuideRepo>(() => DigitalGuideRepo(getit()));
  getit.registerLazySingleton<DigitalGuideCubit>(
      () => DigitalGuideCubit(getit()));

  getit.registerLazySingleton<AdvisoryCommitteesRepo>(
      () => AdvisoryCommitteesRepo(getit()));
  getit.registerLazySingleton<AdvisoryCommitteesCubit>(
      () => AdvisoryCommitteesCubit(getit()));


  // services
  getit.registerLazySingleton<ServicesRepo>(() => ServicesRepo(getit()));
  getit.registerLazySingleton<ServicesCubit>(() => ServicesCubit(getit()));

  // packages
  // getit.registerLazySingleton<PacageRepo>(() => PacageRepo(getit()));
  // getit.registerLazySingleton<PackagesCubit>(() => PackagesCubit(getit()));

  getit.registerLazySingleton<PacakagesAndSubscriptionRepo>(
      () => PacakagesAndSubscriptionRepo(getit()));
  getit.registerLazySingleton<PackagesAndSubscriptionsCubit>(
      () => PackagesAndSubscriptionsCubit(getit()));

  // office services
  getit.registerLazySingleton<OfficeProviderRepo>(
      () => OfficeProviderRepo(getit()));
  getit.registerLazySingleton<OfficeProviderCubit>(
      () => OfficeProviderCubit(getit()));

  // appointments
  getit.registerLazySingleton<AppointmentRepo>(() => AppointmentRepo(getit()));
  getit.registerLazySingleton<AppointmentsCubit>(
      () => AppointmentsCubit(getit()));

  // my page
  getit.registerLazySingleton<MyPageRepo>(() => MyPageRepo(getit()));
  getit.registerLazySingleton<MyPageCubit>(() => MyPageCubit(getit()));

  // home
  getit.registerLazySingleton<HomeRepo>(() => HomeRepo(getit()));
  getit.registerLazySingleton<HomeCubit>(() => HomeCubit(getit()));

  // notifications

  getit
      .registerLazySingleton<NotificationRepo>(() => NotificationRepo(getit()));
  getit.registerLazySingleton<NotificationCubit>(
      () => NotificationCubit(getit()));

  getit.registerLazySingleton<ForensicRepo>(() => ForensicRepo(getit()));
  getit.registerLazySingleton<ForensicGuideCubit>(
      () => ForensicGuideCubit(getit()));

  getit.registerLazySingleton<LawGuideRepo>(() => LawGuideRepo(getit()));
  getit.registerLazySingleton<LawGuideCubit>(() => LawGuideCubit(getit()));

  getit
      .registerLazySingleton<LibraryGuideRepo>(() => LibraryGuideRepo(getit()));
  getit.registerLazySingleton<LibraryCubit>(() => LibraryCubit(getit()));

  /// advisory  NEW
  getit.registerLazySingleton<AdvisoryRepo>(() => AdvisoryRepo(getit()));
  getit.registerLazySingleton<AdvisoryCubit>(() => AdvisoryCubit(getit()));

  // YMTAZ ELITE
  getit.registerLazySingleton<YmtazEliteRepo>(() => YmtazEliteRepo(getit()));
  getit.registerLazySingleton<YmtazEliteCubit>(() => YmtazEliteCubit(getit()));

  // Learning Path
  getit.registerLazySingleton<LearningPathRepo>(() => LearningPathRepo(
    getit<ApiService>(),
  ));
  getit.registerLazySingleton<LearningPathCubit>(() => LearningPathCubit(getit()));
  // getit.registerLazySingleton<LawDetailsCubit>(() => LawDetailsCubit(getit()));
  getit.registerLazySingleton<BookDetailsCubit>(() => BookDetailsCubit(getit()));
}
