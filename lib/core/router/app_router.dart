import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_provider_response.dart';
import 'package:yamtaz/feature/auth/login/presentation/view/login.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/sign_up_provider.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/sign_up_provider_data.dart';
import 'package:yamtaz/feature/auth/sign_up/presentation/view/verify_provider.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/contact_ymtaz_screen.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/more_info/privacy_policy.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/more_info/social_media_screen.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_guide/presentation/fast_search_screen.dart';
import 'package:yamtaz/feature/digital_office/view/sevices_adjust/adjust_screen.dart';
import 'package:yamtaz/feature/forensic_guide/presentation/forensic_guide_category_screen.dart';
import 'package:yamtaz/feature/forensic_guide/presentation/forensic_guide_screen.dart';
import 'package:yamtaz/feature/intro/on_board/presentation/view/on_board_screen.dart';
import 'package:yamtaz/feature/intro/splash/presentation/splash_screen.dart';
import 'package:yamtaz/feature/law_guide/logic/law_guide_cubit.dart';
import 'package:yamtaz/feature/layout/account/data/models/user_data_model.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/edit_client_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/remove_account.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/presentation/user_profile.dart';
import 'package:yamtaz/feature/layout/account/presentation/profile_provider/work_experience_screen.dart';
import 'package:yamtaz/feature/layout/layout/view/layout_screen.dart';
import 'package:yamtaz/feature/layout/my_page/view/my_page_screen.dart';
import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
import 'package:yamtaz/feature/layout/services/presentation/my_requestes_screen.dart';
import 'package:yamtaz/feature/layout/services/presentation/sevices_screen.dart';
import 'package:yamtaz/feature/library_guide/logic/library_cubit.dart';
import 'package:yamtaz/feature/my_appointments/presentation/appointment_with_lawyer_screen.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';
import 'package:yamtaz/feature/notifications/logic/notification_cubit.dart';
import 'package:yamtaz/feature/notifications/presentation/notification_screen.dart';
import 'package:yamtaz/feature/package_and_subscriptions/logic/packages_and_sbuscriptions_cubit.dart';
import 'package:yamtaz/feature/package_and_subscriptions/presentation/package_details.dart';
import 'package:yamtaz/feature/training/presentation/training_video.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_request_details_screen.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_requests_screen.dart';

import '../../feature/advisory_window/data/model/all_advirsory_response.dart';
import '../../feature/advisory_window/logic/advisory_cubit.dart';
import '../../feature/advisory_window/presentation/main_advisory_screen.dart';
import '../../feature/advisory_window/presentation/orders/advisory_orders.dart';
import '../../feature/advisory_window/presentation/orders/view_order_details.dart';
import '../../feature/auth/forget_password/logic/forget_cubit.dart';
import '../../feature/auth/forget_password/views/check_lawyer.dart';
import '../../feature/auth/forget_password/views/forget_lawyer.dart';
import '../../feature/auth/forget_password/views/reset_lawyer.dart';
import '../../feature/auth/login/logic/login_cubit.dart';
import '../../feature/auth/register/logic/register_cubit.dart';
import '../../feature/auth/register/presentaion/registeration_screen.dart';
import '../../feature/auth/sign_up/logic/sign_up_cubit.dart';
import '../../feature/auth/sign_up/presentation/view/phone_verify.dart';
import '../../feature/auth/sign_up/presentation/view/sign_up.dart';
//import '../../feature/chat_screen.dart';
import '../../feature/contact_ymtaz/presentation/more_info/about_ymtaz.dart';
import '../../feature/contact_ymtaz/presentation/more_info/faq.dart';
import '../../feature/digital_office/logic/office_provider_cubit.dart';
import '../../feature/digital_office/view/adjust_office_main.dart';
import '../../feature/digital_office/view/my_orders/my_advisory_reqests_lawyer_screen.dart';
import '../../feature/digital_office/view/my_orders/my_appointments_reqests_lawyer_screen.dart';
import '../../feature/digital_office/view/my_orders/my_services.dart';
import '../../feature/digital_office/view/work_time/working_hours_advisory.dart';
import '../../feature/forensic_guide/data/model/judicial_guide_response_model.dart';
import '../../feature/forensic_guide/presentation/forensic_duide_category_details_screen.dart';
import '../../feature/forensic_guide/presentation/forensic_guide_category_sub_screen.dart';
import '../../feature/forensic_guide/presentation/sub_data_details.dart';
import '../../feature/law_guide/presentation/law_guide_main_screen.dart';
import '../../feature/layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../feature/layout/account/presentation/my_payments/my_payments_screen.dart';
import '../../feature/layout/account/presentation/profile_provider/edit_profile_instructions.dart';
import '../../feature/layout/account/presentation/profile_provider/edit_provider.dart';
import '../../feature/layout/account/presentation/profile_provider/edit_user_info.dart';
import '../../feature/layout/account/presentation/profile_provider/my_profile_screen.dart';
import '../../feature/layout/account/presentation/profile_provider/payout_setting_screen.dart';
import '../../feature/layout/account/presentation/profile_provider/remove_account.dart';
import '../../feature/layout/account/presentation/profile_provider/see_my_profile_screen.dart';
import '../../feature/layout/account/presentation/support_and_information.dart';
import '../../feature/layout/services/data/model/services_requirements_response.dart';
import '../../feature/layout/services/presentation/lawyers_selections.dart';
import '../../feature/layout/services/presentation/service_details_screen.dart';
import '../../feature/layout/services/presentation/servise_sub_type.dart';
import '../../feature/learning_path/logic/learning_path_cubit.dart';
import '../../feature/learning_path/presentation/pages/learning_path_page.dart';
import '../../feature/learning_path/presentation/pages/learning_paths_page.dart';
import '../../feature/learning_path/presentation/pages/learning_path_home_page.dart';
import '../../feature/library_guide/presentation/main_category_screen.dart';
import '../../feature/my_appointments/logic/appointments_cubit.dart';
import '../../feature/my_appointments/presentation/orders/my_requestes_screen.dart';
import '../../feature/notifications/presentation/read_notification_screen.dart';
import '../../feature/package_and_subscriptions/data/model/packages_model.dart'
as packs;
import '../../feature/package_and_subscriptions/presentation/packages_screen.dart';
import '../../feature/points_and_balance/presentation/points_and_balance_screen.dart';
import '../../feature/training/presentation/training_main_screen.dart';
import '../../feature/ymtaz_elite/presentation/elite_lawyer_section/elite_clients_requests.dart';
import '../../feature/ymtaz_elite/presentation/elite_main_screen.dart';
import '../../feature/ymtaz_elite/presentation/elite_request_screen.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_response.dart' as advisory;
import 'package:yamtaz/feature/advisory_committees/presentation/advisory_committees_screen.dart';
import 'package:yamtaz/feature/advisory_committees/presentation/advisory_commttee_search_screen.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_guide_response.dart' as digital;
import 'package:yamtaz/feature/digital_guide/presentation/digetal_screen.dart';
import 'package:yamtaz/feature/digital_guide/presentation/digital_guide_search.dart';
import '../di/dependency_injection.dart';


class AppRouter {
  static const int fadeDuration = 400;

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return _getFadeTransition(SplashScreen());
      case Routes.onBoard:
        return _getFadeTransition(const OnboardingScreen());
      case Routes.homeLayout:
        return _getFadeTransition(const LayoutScreen());

      case Routes.myAppointments:
        return _getFadeTransition(BlocProvider.value(
          value: getit<AppointmentsCubit>()
            ..getAppointmentsoffersClient(),
          child: const MyAppointmentsRequestsScreen(),
        ));

      case Routes.appointmentYmatz:
        return _getFadeTransition(BlocProvider.value(
          value: getit<AppointmentsCubit>()
            ..load(),
          child: AppointmentData(),
        ));

      case Routes.orders:
        return _getFadeTransition(MyPageScreen());
      case Routes.adjustScreen:
        return _getFadeTransition(const AdjustScreen());
      case Routes.mainOffice:
        return _getFadeTransition(BlocProvider.value(
            value: getit<OfficeProviderCubit>()
              ..getAnalytics(),
            child: const AdjustOfficeMain()));
      case Routes.myWorkingHoursAppointmetns:
        return _getFadeTransition(BlocProvider.value(
          value: getit<OfficeProviderCubit>()
            ..geteWorkingDays(),
          child: const WorkingHoursAdvisory(serviceId: 1),
        ));
      case Routes.myWorkingHoursAdvisory:
        return _getFadeTransition(BlocProvider.value(
          value: getit<OfficeProviderCubit>()
            ..geteWorkingDays(),
          child: const WorkingHoursAdvisory(serviceId: 3),
        ));

      case Routes.myAdvisoriesOffice:
        return _getFadeTransition(BlocProvider.value(
            value: getit<OfficeProviderCubit>()
              ..loadAdvisory(),
            child: const MyAdvisroyLawyerScreen()));

      case Routes.myAppointmentOffice:
        return _getFadeTransition(BlocProvider.value(
            value: getit<OfficeProviderCubit>()
              ..loadAppoinemtns(),
            child: const MyAppointmentsLawyerScreen()));

      case Routes.myServicesOffice:
        return _getFadeTransition(BlocProvider.value(
            value: getit<OfficeProviderCubit>()
              ..loadServices(),
            child: const MyServicesLawyerScreen()));

      case Routes.pointsAndBalance:
        return _getFadeTransition(const PointsAndBalanceScreen());

      case Routes.packages:
        return _getFadeTransition(BlocProvider.value(
            value: getit<PackagesAndSubscriptionsCubit>()
              ..getdata(),
            child: const PackagesScreen()));
      case Routes.packageDetails:
        return _getFadeTransition(BlocProvider.value(
            value: getit<PackagesAndSubscriptionsCubit>(),
            child: PackageDetails(
              package: settings.arguments as packs.Package,
            )));

      case Routes.trainingScreen:
        return _getFadeTransition(TrainingMainScreen());
      case Routes.trainingClips:
        return _getFadeTransition(const TrainingView());
      case Routes.notifications:
        return _getFadeTransition(BlocProvider.value(
          value: getit<NotificationCubit>()
            ..getNotifications(),
          child: const NotificationScreen(),
        ));

      case Routes.notificationsData:
        return _getFadeTransition(ReadNotificationScreen(
          data: settings.arguments as NotificationItem,
        ));

      case Routes.servicesSubTypeScreen:
        return _getFadeTransition(BlocProvider.value(
          value: getit<ServicesCubit>(),
          child: ServicesSubTypeScreen(items: settings.arguments as Item),
        ));
      case Routes.servicesReservationScreen:
        return _getFadeTransition(BlocProvider.value(
          value: getit<ServicesCubit>(),
          child: ServiceDetailsScreen(),
        ));

      case Routes.lawyerSelection:
        return _getFadeTransition(BlocProvider.value(
          value: getit<ServicesCubit>()
            ..serviceLawyersById(
                getit<ServicesCubit>().selectedSubService!.id.toString(),
                getit<ServicesCubit>().selectedLevel!.level!.id.toString()),
          child: LawyersSelections(),
        ));
    // case Routes.servicesReservationByService:
    //   return _getFadeTransition(BlocProvider.value(
    //     value: getit<ServicesCubit>(),
    //     child: ServiceReservationByServiceScreen(
    //         service: settings.arguments as fast_search.Service),
    //   ));
    //
    // case Routes.servicesReservationLawyerScreen:
    //   return _getFadeTransition(BlocProvider.value(
    //     value: getit<ServicesCubit>(),
    //     child: LawyerServiceRequest(lawyer: settings.arguments as Map),
    //   ));

      case Routes.services:
        return _getFadeTransition(BlocProvider.value(
            value: getit<ServicesCubit>(), child: ServicesScreen()));

      case Routes.myServices:
        return _getFadeTransition(BlocProvider.value(
            value: getit<ServicesCubit>()
              ..getMyServicesRequestOffers(),
            child: const MyServicesRequestsScreen()));

      case Routes.login:
        return _getFadeTransition(
          BlocProvider(
            create: (context) => getit<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.forgetPasswordClient:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ForgetCubit>(),
            child: const ForgetPasswordLawyerScreen(),
          ),
        );

      case Routes.forgetPasswordProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ForgetCubit>(),
            child: const ForgetPasswordLawyerScreen(),
          ),
        );
      case Routes.forgetPasswordOtpProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ForgetCubit>(),
            child: CheckCodeLawyerScreen(email: settings.arguments.toString()),
          ),
        );
      case Routes.resetPasswordProvider:
        final args = settings.arguments as Map<String, String>;
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ForgetCubit>(),
            child: ResetPasswordLawyerScreen(
              code: args['code'] ?? '',
              email: args['email'] ?? '',
            ),
          ),
        );

      case Routes.signup:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>()
              ..firtInit(),
            child: SignUpScreen(),
          ),
        );
      case Routes.regestirationScreen:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<RegisterCubit>(),
            child: RegestirationScreen(
              type: settings.arguments as int,
            ),
          ),
        );
      case Routes.signupProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>(),
            child: SignUpProvider(),
          ),
        );

      case Routes.editProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>()
              ..loadUserData(getit<MyAccountCubit>().userDataResponse
              as LoginProviderResponse),
            child: EditProviderData(),
          ),
        );

      case Routes.editProviderInstruction:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>(),
            child: const EditProfileInstructions(),
          ),
        );

      case Routes.editProviderInfo:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>()
              ..loadUserDataProvider(settings.arguments as UserDataResponse),
            child: EditUserInfoProvider(),
          ),
        );

      case Routes.profileProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: const MyProfileProviderScreen(),
          ),
        );

      case Routes.seeProviderInfo:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: const SeeMyProfileProvider(),
          ),
        );

      case Routes.profileClient:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: const MyProfileClientScreen(),
          ),
        );

      case Routes.seeClientInfo:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: const SeeMyProfileClient(),
          ),
        );
      case Routes.removeClient:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: RemoveAccount(),
          ),
        );
      case Routes.removeProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>(),
            child: RemoveAccountProvider(),
          ),
        );
      case Routes.payoutSettingProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>()
              ..getIban(),
            child: PayoutSettingScreen(),
          ),
        );

      case Routes.workSettingProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>()
              ..getMyWorkExperience(),
            child: WorkExperienceScreen(),
          ),
        );

      case Routes.editClient:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>()
              ..loadClientData(),
            child: const ClientEditProfile(),
          ),
        );

      case Routes.signupProviderData:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>()
              ..firstInitprovider(),
            child: SignUpProviderData(
              data: settings.arguments as Map,
            ),
          ),
        );

      case Routes.verifyProvider:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>()
              ..firstInitprovider(),
            child: SignUpProviderData(
              data: settings.arguments as Map,
            ),
          ),
        );

      case Routes.verifyProviderOtp:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>(),
            child: VerifyProviderOtp(
              data: settings.arguments as Map,
            ),
          ),
        );
      case Routes.myAdvisoryOrderDetails:
        return _getFadeTransition(ViewOrderDetails(
          servicesRequirementsResponse: settings.arguments as Reservation,
        ));

      case Routes.myAdvisoryOrders:
        return _getFadeTransition(BlocProvider.value(
            value: getit<AdvisoryCubit>(), child: const AdvisoryOrders()));

      case Routes.advisoryScreen:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<AdvisoryCubit>(),
            child: MainAdvisoryScreen(),
          ),
        );

      case Routes.contactYmtaz:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const ContactYmtazScreen(),
          ),
        );

      case Routes.faq:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const Faq(),
          ),
        );

      case Routes.privacyYmtaz:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const PrivacyPolicy(),
          ),
        );

      case Routes.aboutYmtaz:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const AboutYmtaz(),
          ),
        );

      case Routes.support:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const SupportAndInformation(),
          ),
        );

      case Routes.myPaymentsScreen:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<MyAccountCubit>()
              ..getPayments(),
            child: const MyPaymentsScreen(),
          ),
        );
      case Routes.socialMedia:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<ContactYmtazCubit>(),
            child: const SocialMediaScreen(),
          ),
        );

      case Routes.verify:
        return _getFadeTransition(
          BlocProvider.value(
            value: getit<SignUpCubit>(),
            child: MobileVerify(
              type: settings.arguments as int,
            ),
          ),
        );

    // foresic guide
      case Routes.forensicGuide:
        return _getFadeTransition(const ForensicGuideScreen());
      case Routes.forensicGuideCategory:
        return _getFadeTransition(ForensicGuideCategoryScreen(
          data: settings.arguments as JudicialGuidesMainCategory,
        ));
      case Routes.forensicGuideSubCategory:
        return _getFadeTransition(ForensicGuideSubCategoryScreen(
          data: settings.arguments as SubCategory,
        ));

      case Routes.forensicGuideSubCategoryDetails:
        return _getFadeTransition(SubDataDetails(
          data: settings.arguments as SubCategory,
        ));
      case Routes.forensicGuideDetails:
        return _getFadeTransition(ForensicGuideCategoryDetailsScreen(
          data: settings.arguments as JudicialGuide,
        ));

    // fast search
      case Routes.fastSearch:
        return _getFadeTransition(BlocProvider.value(
          value: getit<DigitalGuideCubit>(),
          child: FastSearchScreen(),
        ));

      case Routes.digitalGuide:
        return _getFadeTransition(const DigetalScreen());

      case Routes.digitalGuideSearch:
        return _getFadeTransition(DigitalGuideSearch(
          cat: settings.arguments as digital.Category,
        ));

      case Routes.advisoryCommitteesScreen:
        return _getFadeTransition(const AdvisoryCommitteesScreen());

      case Routes.advisoryCommitteeLawyersScreen:
        return _getFadeTransition(AdvisoryCommitteeSearchScreen(
          cat: settings.arguments as advisory.CategoryAdvisorCommitte,
        ));


    // law guide
      case Routes.lawGuide:
        return _getFadeTransition(BlocProvider.value(
            value: getit<LawGuideCubit>()
              ..getLawGuide(),
            child: LawGuideMainScreen()));

      case Routes.libraryGuide:
        return _getFadeTransition(BlocProvider.value(
            value: getit<LibraryCubit>()
              ..getLawGuide(),
            child: const MainBooksCategoryScreen()));

      /*case Routes.aiAssistant:
        return _getFadeTransition(const ChatScreen());*/

    // elite
      case Routes.elite:
        return _getFadeTransition(BlocProvider.value(
            value: getit<YmtazEliteCubit>(),
            child: EliteMainScreen()));

      case Routes.eliteRequestsClients:
        return _getFadeTransition(BlocProvider.value(
            value: getit<YmtazEliteCubit>(),
            child: EliteClientsRequests()));
      case Routes.eliteRequestScreen:
        return _getFadeTransition(BlocProvider.value(
            value: getit<YmtazEliteCubit>(),
            child: EliteRequestScreen()));

      case Routes.eliteRequests:
        return _getFadeTransition(BlocProvider.value(
          value: getit<YmtazEliteCubit>(),
          child: const EliteRequestsScreen(),
        ));

      case Routes.eliteRequestDetails:
        return _getFadeTransition(EliteRequestDetailsScreen(
          request: settings.arguments as Request,
        ));


      case Routes.learningPathHome:
        return _getFadeTransition(const LearningPathHomePage());

      case Routes.learningPath:
        return _getFadeTransition(BlocProvider.value(
          value: getit<LearningPathCubit>(),
          child: LearningPathPage(pathId: settings.arguments as int),
        ),
        );

      case Routes.learningPaths:
        return _getFadeTransition(BlocProvider.value(
          value: getit<LearningPathCubit>(),
          child: LearningPathsPage(),
        ),
        );

      // case Routes.bookDetails:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return _getFadeTransition(MaterialPageRoute(
      //     builder: (_) => BookDetailsPage(
      //       items: args['items'],
      //       currentIndex: args['currentIndex'],
      //       pathId: args['pathId'],
      //     ),
      //   ));

    // library guide

      default:
        return _getFadeTransition(SplashScreen());
    }
  }

  //  _getFadeTransition(Widget child) {
  //   return child;
  // }

  Route _getFadeTransition(Widget child) {
    if (Platform.isIOS) {
      return MaterialPageRoute(
        builder: (_) => child,
      );
    } else {
      return PageTransition(
        child: child,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: fadeDuration),
      );
    }
  }
}
