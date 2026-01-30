import 'package:yamtaz/config/enviroment.dart';

class ApiConstants {
  ApiConstants._();

  static Future<String> get baseUrl async {
    final env = await Environment.current();
    return env.apiBaseUrl;
  }

  //general data
  static const countries = "lawyer/general_data/countries";
  static const cities = "lawyer/general_data/cities";
  static const nationalities = "lawyer/general_data/nationalities";
  static const generalSpecialty = "lawyer/general_data/general-specialty";
  static const accurateSpecialty = "lawyer/general_data/accurate-specialty";
  static const degrees = "lawyer/general_data/degrees";
  static const langs = "lawyer/general_data/languages";
  static const lawyerTypes = "lawyer/general_data/lawyer-types";

  static const sections = "lawyer/general_data/sections";
  static const functionalCases = "lawyer/general_data/functional-cases";

  // auth new
  static const login = "v1/auth/login";
  static const register = "v1/auth/register";
  static const verifyPhone = "v1/auth/check-phone";
  static const confirmPhone = "v1/auth/confirm-phone";
  static const profile = "v1/profile";

  //auth client
  static const loginClient = "client/login";
  static const registerClient = "client/register";
  static const verifyClient = "client/activate-account";

  static const reomoveProfile = "client/profile/delete-account-request";

  static const verfyOtpProfile = "v1/auth/confirm-otp";

// recent lawyers in home screen

  static const recentLawyers = "v1/recentlyJoinedLawyers";
  static const banners = "v1/banners";

  // FCM user
  static const fcmClient = "v1/device";
  static const fcmProvider = "v1/device";

  static const fcmDeleteClient = "v1/device";
  static const fcmDeleteProvider = "v1/device";

  // splash screen ckeck user
  static const checkUserClient = "v1/auth/check";
  static const checkUserProvider = "v1/auth/check";

  // auth forget password client

  static const forgetPasswordClient = "v1/auth/forget-password";
  static const verifyForgetClient = "v1/auth/check-password";
  static const resetPasswordClient = "v1/auth/reset-password";

  // advisory window new API
  static const advisoriesTypes =
      "v1/advisory-services/payment-categories-types";

  // my work experience
  static const myWorkExperience = "v1/account/experiences";

  // get payments
  static const myPayments = "v1/payments";

  // my iban
  static const myIban = "v1/account/bank-info";

  // advisor client

  static const advisorServicesClient = "v1/advisory-services/services";
  static const advisorMainCategoryClient = "v1/advisory-services/base";
  static const advisorServicesTypesClient = "v1/advisory-services/types";
  static const advisorPaymentsTypesClient =
      "v1/advisory-services/payment-categories";
  static const advisorSectionsByIDClient =
      "v1/advisory-services/base-payment-category-id";
  static const getMyServicesClient = "v1/advisory-services/ymtaz";
  static const getMyServicesClientDigital =
      "v1/advisory-services/digital-guide";
  static const createAdvisoryRequest = "v1/advisory-services";
  static const advisoryLawyersById = "v1/advisory-services/";

  // advisor services
  static const lawyerAdvisorServicesBase = "v1/lawyer";
  static const lawyerServicesBase = "v1/lawyer/";

  // appointments
  static const appointmentsAvailable = "v1/reservations/available";
  static const appointmentsRequest = "v1/reservations/create";
  static const replyToOfferAppointment = "v1/reservations/replyToOffer";
  static const myAppointments = "v1/reservations/booked";

  // appointments new Section
  static const appointmentsTypes = "v1/reservations/types";
  static const appointmentsoffersClient = "v1/reservations/offers";
  static const ymtazApppointmentsWorkHours = "v1/working-hours/1";
  static const ymtazAdvisoryWorkHours = "v1/working-hours/3";

  // advisor lawyer
  static const advisorServicesProvider = "v1/advisory-services/services";
  static const advisorServicesTypesProvider = "v1/advisory-services/types";
  static const advisorPaymentsTypesProvider =
      "v1/advisory-services/payment-categories";
  static const advisorSectionsByIDProvider =
      "v1/advisory-services/base-payment-category-id";
  static const getMyServicesProvider = "v1/advisory-services/ymtaz";
  static const getMyServicesProviderDigital =
      "v1/advisory-services/digital-guide";
  static const createAdvisorServicesProvider = "v1/advisory-services";

  static const createAdvisorServicesProviderWithLawyer =
      "v1/lawyer/advisory-services";
  static const createAdvisorServicesClientWith = "v1/lawyer/advisory-services";

  // ymtaz contact us
  static const contactYmtazClient = "client/contact-ymtaz";
  static const contactYmtazTypes = "v1/contact-us/types";
  static const contactYmtazClientNew = "v1/contact-us";
  static const contactYmtazProvider = "lawyer/contact-ymtaz";

  // ymtaz about us
  static const aboutUs = "v1/general-data/static-page/who-are-we";

  // ymtaz privacy policy
  static const privacyPolicy = "v1/general-data/static-page/privacy-policy";

  // ymtaz faq
  static const faq = "v1/general-data/static-page/faq";

  static const socialMedia = "v1/general-data/static-page/social-media";

  // auth forget password lawyer
  static const forgetPasswordLawyer = "v1/auth/forget-password";
  static const verifyForgetLawyer = "v1/auth/check-password";
  static const resetPasswordLawyer = "v1/auth/reset-password";

  // resend otp
  static const resendOtp = "v1/auth/resend-otp";

  //auth lawyer
  static const loginProvider = "lawyer/login";
  static const registerProvider = "lawyer/register";

  static const verificationProvider = "lawyer/verification/first-step";
  static const verificationotp = "lawyer/check/verification/first-step";

  static const editProvider = "v1/profile";
  static const profileProvider = "lawyer/profile";

  static const reomoveProfileProvider = "lawyer/profile/delete-account-request";

  // digital guide
  static const digitalGuideCategoriesProvider = "v1/digital-guide/categories";
  static const digitalGuideCategoriesClient = "v1/digital-guide/categories";
  static const digitalGuideSearchClient = "v1/digital-guide/search";
  static const digitalGuideSearchProvider = "v1/digital-guide/search";

  // advisory committees
  static const advisoryCommitteesProvider = "v1/advisory-committees/categories";
  static const advisoryCommitteesClient = "v1/advisory-committees/categories";
  static const advisoryCommitteesLawyersById =
      "v1/advisory-committees/advisors/categories/";

  // services
  static const servicesProvider = "v1/services/main-category";

  static const myServices = "v1/services/requests";

  static const servicesClient = "v1/services/main-category";

  static const myServicesClientOffers =
      "v1/services/requests/offers"; // new api for offers
  static const myServicesClientOffersRespond =
      "v1/services/requests/respond"; // new api for offers
  static const servicesRequestClient = "v1/services/requests";

  static const serviceLawyersById = "v1/services/";

  // pacakge
  static const packages = "v1/packages";
  static const myPackage = "v1/profile/package";
  static const packageSubscribe = "v1/packages/subscribe";

  // visitor
  static const visitorLogin = "auth/google/callback/";

  // Apple Sign In 
  static const appleLogin = "auth/apple/callback";

  ///-------------------- provier office ----------------------------------------//
  ///

  //lawyer Office Info
  static const lawyerOfficeAnalytics = "v1/profile/analytics";

  //lawyer work hours

  static const lawyerWorkHours = "v1/working-hours";

  //add appointmets to lawyer
  static const appointmentsLawyerTypes = "v1/reservations/pricing";

  static const servicesYmtazToProvider =
      "v1/services-request/getLawyerServicePrices";
  static const createservicesYmtazToProvider = "v1/services-request/create";
  static const hideAndDeleteServicesYmtazToProvider = "v1/services-request/";

  static const createsAppointmentsTypesToProvider = "v1/reservations/pricing";
  static const reservationsLawyerTypes = "v1/reservations/types";

  // provider office services request
  static const servicesRequestProviderOfficeClient =
      "v1/services-request/requested";

  static const servicesRequestsPending = "v1/services-request/pending";
  static const appointmentsRequestsPending = "v1/reservations/lawyer-offers";

  static const appointmentsRequestsAttend = "v1/reservations/requested/";

  //reply services
  static const replyServicesRequestProviderOfficeClient =
      "v1/services-request/requested/reply"; //new

  static const replyServicesOfferProviderOfficeClient =
      "v1/services-request/pending/offer";

  static const replyAppointmentsOfferProviderOfficeClient =
      "v1/reservations/replyWithOffer";

  // provider office advisory request
  static const advisoryRequestProviderOffice = "v1/advisory-services/requested";

  //reply advisory
  static const replyAdvisoryRequestProviderOffice =
      "v1/advisory-services/requested/reply";

  static const appointmentRequestProviderOfficeClient =
      "v1/reservations/requested";

  // provider office advisory services
  static const hideAndDeleteAdvisoryServicesYmtazToProvider =
      "v1/advisory-services/";
  static const hideAndDeleteAppointmentsYmtazToProvider = "v1/reservations/";

  // provider office advisory services fetch data
  static const advisorServicesProviderOffice =
      "v1/advisory-services/availableForPricing";

  // add advisor services to provider account
  static const addAdvisorServicesProviderOffice =
      "v1/advisory-services/createPrice";

  // get advisor services to provider account
  static const getAdvisorServicesProviderFromClient =
      "v1/advisory-services/requested/lawyer";
  static const getAdvisorServicesProviderFromLawyer =
      "v1/advisory-services/requested/client";

  // reply advisor services from client
  static const replyAdvisorServicesProvider =
      "v1/advisory-services/requested/reply";

  // reply advisor services from lawyer
  static const replyAdvisorServicesProviderFromLawyer =
      "v1/advisory-services/requested/reply/lawyer";

  // office Clients
  static const officeClients = "v1/profile/clients";

  ///-------------------- ----------------------------------------//
  ///
  ///
  /// my Page
  static const myPage = "v1/profile/my-page";
  static const myLastAdded = "v1/most-bought";
  static const myLawyers = "v1/profile/lawyers";

  // notifications
  static const notifications = "v1/notifications";
  static const notificationSeen = "v1/notifications/seen";

  // favorite
  static const addToFavorite = "v1/lawyer";
  static const getFav = "v1/profile/favourites";

  //fast search
  static const fastSearch = "v1/fast-search";

  // judicial-guide
  static const judicialGuide = "v1/judicial-guide/main";

  // law guide
  static const lawGuide = "v1/law-guide/main";
  static const lawGuideSub = "v1/law-guide/sub/";
  static const lawGuideSearch = "v1/law-guide/search";
  static const lawById = "v1/law-guide/law/";

  // library guide
  static const booksGuide = "v1/books/main";

  //gamification
  static const pointsRules = "v1/activities";

  // invites
  static const invite = "v1/invites";

  // Elite
  static const eliteCategoris = "v1/elite/categories";
  static const eliteRequests = "v1/elite/requests";
  static const eliteRequest = "v1/elite/requests";
  static const elitePricingRequestReply = "v1/elite/pricing-requests/reply";

  // Learning Paths
  static const learningPaths = "v1/learning-paths";
  static const learningPathItems = "v1/learning-paths/{id}/learning-path-items";
  static const learningPathItemFavourite = "v1/learning-paths/learning-path-items/:id/favourite";

  static const String updateLearningProgress = '/learning-path/update-progress';
}
