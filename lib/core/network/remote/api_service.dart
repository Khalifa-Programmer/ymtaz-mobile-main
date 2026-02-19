import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:yamtaz/core/network/remote/api_constants.dart';
import 'package:yamtaz/core/shared/models/accurate_speecialties.dart';
import 'package:yamtaz/core/shared/models/degrees.dart';
import 'package:yamtaz/core/shared/models/functional_cases.dart';
import 'package:yamtaz/core/shared/models/general_specialty.dart';
import 'package:yamtaz/core/shared/models/languages_response.dart';
import 'package:yamtaz/core/shared/models/lawyer_type.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_accurate_specialization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_categories_types.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisories_general_specialization.dart';
import 'package:yamtaz/feature/advisory_window/data/model/advisory_request_response.dart';
import 'package:yamtaz/feature/advisory_window/data/model/all_advirsory_response.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/check_code_request_body.dart';
import 'package:yamtaz/feature/auth/forget_password/data/model/forget_request_body.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_request_body.dart';
import 'package:yamtaz/feature/auth/login/data/models/login_response.dart';
import 'package:yamtaz/feature/auth/login/data/models/visitor_login.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_provider_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_otp_request.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_request.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_response_body.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/about_ymtaz.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/contact_ymtaz_response.dart';
import 'package:yamtaz/feature/contact_ymtaz/data/models/my_contact_ymtaz_Response.dart';
import 'package:yamtaz/feature/digital_guide/data/model/fast_search_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_available_types_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_types_add_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/appointment_office_reservations_client.dart';
import 'package:yamtaz/feature/digital_office/data/models/create_services_ymtaz_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_clients_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/response_lawyer_to_appointment_offer.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_from_client_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_reply_success_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_ymtaz_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/success_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/work_days_and_times.dart';
import 'package:yamtaz/feature/digital_office/data/models/work_time_request_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/work_time_response_model.dart';
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';
import 'package:yamtaz/feature/intro/splash/model/splash_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_by_id_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_main_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_search_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_sub_main_response.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_response.dart';
import 'package:yamtaz/feature/layout/account/data/models/experience_model.dart';
import 'package:yamtaz/feature/layout/account/data/models/my_payments_response.dart';
import 'package:yamtaz/feature/layout/account/data/models/user_data_model.dart';
import 'package:yamtaz/feature/layout/account/presentation/client_profile/data/models/remove_response.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_lawyers_response.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_page_lawyer_response_model.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_page_response_model.dart';
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_request_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/law_details_response.dart';
import 'package:yamtaz/feature/library_guide/data/model/books_response.dart';
import 'package:yamtaz/feature/my_appointments/data/model/appointment_request_response.dart';
import 'package:yamtaz/feature/my_appointments/data/model/working_hours_response.dart';
import 'package:yamtaz/feature/notifications/data/model/notifications_resonse_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_offer_approval_response.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_pricing_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_paths_response.dart';

import '../../../feature/advisory_window/data/model/available_lawyers_for_advisory_type_model.dart';
import '../../../feature/auth/forget_password/data/model/check_code_response_body.dart';
import '../../../feature/auth/forget_password/data/model/forget_response_body.dart';
import '../../../feature/auth/forget_password/data/model/reset_password_request_body.dart';
import '../../../feature/auth/login/data/models/login_provider_response.dart';
import '../../../feature/auth/register/data/model/response_model.dart';
import '../../../feature/auth/sign_up/data/models/countries_response.dart';
import '../../../feature/auth/sign_up/data/models/nationalities_response.dart';
import '../../../feature/contact_ymtaz/data/models/contact_us_types.dart';
import '../../../feature/contact_ymtaz/data/models/faq.dart';
import '../../../feature/contact_ymtaz/data/models/privacy_policy.dart';
import '../../../feature/contact_ymtaz/data/models/social_media.dart';
import '../../../feature/digital_guide/data/model/lawyer_model.dart';
import '../../../feature/digital_office/data/models/appointment_offers_lawyer.dart';
import '../../../feature/digital_office/data/models/lawyer_advisory_requests_responnse.dart';
import '../../../feature/digital_office/data/models/lawyer_appointments.dart';
import '../../../feature/digital_office/data/models/response_lawyer_to_offer.dart';
import '../../../feature/digital_office/data/models/service_lawyer_offres_response.dart';
import '../../../feature/digital_office/data/models/success_appointments_request.dart';
import '../../../feature/layout/account/data/models/advisory_services_types_response.dart';
import '../../../feature/layout/account/data/models/iban_model.dart';
import '../../../feature/layout/account/data/models/invites_model.dart';
import '../../../feature/layout/account/data/models/points_rules.dart';
import '../../../feature/layout/account/data/models/success_fcm_response.dart';
import '../../../feature/layout/home/data/models/banners_model.dart';
import '../../../feature/layout/home/data/models/recent_joined_lawyers_model.dart';
import '../../../feature/layout/my_page/data/model/last_added.dart';
import '../../../feature/layout/services/data/model/available_lawyers_for_service_model.dart';
import '../../../feature/layout/services/data/model/respond_clinet_to_offer_response.dart';
import '../../../feature/learning_path/data/models/book_details_response.dart';
import '../../../feature/learning_path/data/models/learning_path_items_response.dart';
import '../../../feature/learning_path/data/models/learning_progress_response.dart';
import '../../../feature/my_appointments/data/model/appointment_offers_client.dart';
import '../../../feature/my_appointments/data/model/avaliable_appointment_lawyer_model.dart';
import '../../../feature/my_appointments/data/model/dates_types_response_model.dart';
import '../../../feature/my_appointments/data/model/my_reservations_response_model.dart';
import '../../../feature/my_appointments/data/model/reply_to_offer_appointment_response.dart';
import '../../../feature/notifications/data/model/mark_notification_seen_response.dart';
import '../../../feature/package_and_subscriptions/data/model/my_package_model.dart';
import '../../../feature/package_and_subscriptions/data/model/packages_model.dart';
import '../../../feature/package_and_subscriptions/data/model/packages_subscribe_model.dart';
import '../../../feature/ymtaz_elite/data/model/elite_category_model.dart';
import '../../../feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import '../../../feature/ymtaz_elite/data/model/elite_request_model.dart';
import '../../../feature/ymtaz_elite/data/model/elite_pricing_requests_model.dart';
import '../../../feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';
import '../../../feature/advisory_committees/data/model/advisory_committees_response.dart';
import '../../../feature/digital_guide/data/model/digital_guide_response.dart';
import '../../../feature/digital_guide/data/model/digital_search_response_model.dart';
import '../../models/base_response.dart';

import '../../shared/models/resend_code.dart';
import 'package:yamtaz/feature/learning_path/data/models/favourite_items_response.dart';

part 'api_service.g.dart';

// Run the following command in your terminal to generate the code:
// `dart run build_runner build --delete-conflicting-outputs`
@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // ====== AUTH new  ====== //
  // في ملف api_service.dart
  @POST(ApiConstants.login)
  @Headers(<String, dynamic>{'Content-Type': 'application/json'})
  Future<LoginProviderResponse> login(@Body() LoginRequestBody body);

  @POST(ApiConstants.register)
  Future<ResponseModel> register(@Body() FormData body);

  @POST(ApiConstants.registerClient)
  Future<ResponseModel> registerClientUnified(@Body() FormData body);

  @POST(ApiConstants.registerProvider)
  Future<ResponseModel> registerProviderUnified(@Body() FormData body);

  @POST(ApiConstants.verifyPhone)
  Future<ResponseModel> verifyPhone(
      @Field('phone') String phone, @Field('phone_code') String countryCode);

  @POST(ApiConstants.confirmPhone)
  Future<ResponseModel> confirmPhone(@Field('otp') String otp,
      @Field('phone') String phone, @Field('phone_code') String countryCode);

  // ====== AUTH Client  ====== //
  @POST(ApiConstants.login)
  Future<LoginResponse> loginClient(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.registerClient)
  Future<SignUpResponse> registerClient(
      @Body() SignUpRequestBody signUpRequestBody);

  @POST(ApiConstants.verifyClient)
  Future<VerifypResponse> verifyClient(
      @Body() VerifyRequestBody verifyRequestBody);

  @POST(ApiConstants.verfyOtpProfile)
  Future<LoginResponse> verifyOtpEdit(
      @Header('Authorization') String token, @Field('otp') String otp);

  @POST(ApiConstants.forgetPasswordClient)
  Future<ForgetResponse> forgetPasswordClient(
      @Body() ForgetRequestBody forgetRequestBody);

  @POST(ApiConstants.verifyForgetClient)
  Future<CheckCodeResponse> verifyForgetClient(
      @Body() CheckCodeRequestBody checkCodeRequestBody);

  @POST(ApiConstants.resetPasswordClient)
  Future<LoginResponse> resetPasswordClient(
      @Body() ResetPasswordRequestBody resetPasswordRequestBody);

  // send fcm token
  @POST(ApiConstants.fcmClient)
  Future<SuccessFcmResponse> sendFcmToken(
      @Header('Authorization') String token, @Body() FormData body);

  // send fcm token
  @POST(ApiConstants.fcmProvider)
  Future<SuccessFcmResponse> sendFcmTokenProvider(
      @Header('Authorization') String token, @Body() FormData body);

  @DELETE('${ApiConstants.fcmDeleteClient}/{id}')
  Future<SuccessFcmResponse> deleteFcmToken(
      @Header('Authorization') String token, @Path('id') String id);

  @DELETE('${ApiConstants.fcmDeleteProvider}/{id}')
  Future<SuccessFcmResponse> deleteFcmTokenProvider(
      @Header('Authorization') String token, @Path('id') String id);

  // profile client
  @GET(ApiConstants.profile)
  Future<LoginProviderResponse> getProfile(
      @Header('Authorization') String token);

  @POST(ApiConstants.checkUserClient)
  Future<SplashResponse> checkClient(@Header('Authorization') String token);

  @POST(ApiConstants.checkUserProvider)
  Future<SplashResponse> checkProvider(@Header('Authorization') String token);

  //edit client
  @POST(ApiConstants.profile)
  Future<LoginProviderResponse> updateProfile(
      @Header('Authorization') String token, @Body() FormData body);

  //remove client
  @POST(ApiConstants.reomoveProfile)
  Future<RemoveResponse> removeProfile(@Header('Authorization') String token,
      @Body() FormData body); //remove client
  @POST(ApiConstants.reomoveProfileProvider)
  Future<RemoveResponse> removeProfileProvider(
      @Header('Authorization') String token, @Body() FormData body);

  // ====== AUTH Lawyer  ====== //
  @POST(ApiConstants.login)
  Future<LoginProviderResponse> loginProvider(
      @Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.registerProvider)
  Future<SignUpProviderResponse> registerProvider(
      @Body() FormData signUpRequestBody);

  @GET(ApiConstants.profileProvider)
  Future<UserDataResponse> getProvider(@Header('Authorization') String token);

  @GET(ApiConstants.pointsRules)
  Future<PointsRules> getPointsRules(@Header('Authorization') String token);

  @POST(ApiConstants.editProvider)
  Future<LoginProviderResponse> editProvider(@Body() FormData signUpRequestBody,
      @Header('Authorization') String token);

  @POST(ApiConstants.verificationProvider)
  Future<VerifypResponse> verifyProvider(
      @Body() VerifyProviderRequest verifyRequestBody);

  @POST(ApiConstants.verificationotp)
  Future<VerifypResponse> verifyProviderOtp(
      @Body() VerifyProviderOtpRequest verifyRequestBody);

  @POST(ApiConstants.forgetPasswordLawyer)
  Future<ForgetResponse> forgetPasswordLawyer(@Field('email') String email);

  @POST(ApiConstants.verifyForgetLawyer)
  Future<CheckCodeResponse> verifyForgetLawyer(
      @Body() CheckCodeRequestBody checkCodeRequestBody);

  @POST(ApiConstants.resetPasswordLawyer)
  Future<LoginResponse> resetPasswordLawyer(
      @Body() ResetPasswordRequestBody resetPasswordRequestBody);

  // resend code

  @POST(ApiConstants.resendOtp)
  Future<ResendCode> resendCode(@Header('Authorization') String token);

  // ====== General Data  ======
  @GET(ApiConstants.countries)
  Future<CountriesResponse> getCountries();

  @GET(ApiConstants.nationalities)
  Future<NationalitiesResponse> nationalities();

  // ==genral data
  @GET(ApiConstants.generalSpecialty)
  Future<GeneralSpecialty> getGeneralSpecialty();

  @GET(ApiConstants.accurateSpecialty)
  Future<AccurateSpecialties> getAccurateSpecialty();

  @GET(ApiConstants.degrees)
  Future<Degrees> getDegrees();

  @GET(ApiConstants.langs)
  Future<LanguagesResponse> getLangs();

  @GET(ApiConstants.sections)
  Future<SectionsType> getSections();

  @GET(ApiConstants.functionalCases)
  Future<FunctionalCases> getFunctionalCases();

  @GET(ApiConstants.lawyerTypes)
  Future<LawyerTypes> lawyerTypes();

  // home

  @GET(ApiConstants.recentLawyers)
  Future<RecentJoinedLawyersModel> getRecentLawyers();

  @GET(ApiConstants.banners)
  Future<BannersModel> getBanners();

  // appointments

  @GET(ApiConstants.appointmentsTypes)
  Future<DatesTypesResponseModel> getAppointmentsTypes(
      @Header('Authorization') String token);

  @GET(ApiConstants.appointmentsoffersClient)
  Future<AppointmentOffersClient> getAppointmentsoffersClient(
      @Header('Authorization') String token);

  @GET('${ApiConstants.appointmentsTypes}/{id}/lawyers')
  Future<AvaliableAppointmentLawyerModel> getAppointmentLawyers(
      @Header('Authorization') String token,
      @Query('importance_id') String importanceId,
      @Query('city_id') String cityId,
      @Query('region_id') String regionId,
      @Path('id') String id);

  @POST(ApiConstants.appointmentsRequest)
  Future<AppontmentRequestResponse> appointmentsRequest(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.replyToOfferAppointment)
  Future<ReplyToOfferAppointmentResponse> respondToAppointmentOffer(
      @Header('Authorization') String token, @Body() FormData body);

  @GET(ApiConstants.myAppointments)
  Future<MyReservationsResponseModel> getMyAppointments(
      @Header('Authorization') String token);

  // appointments New
  @GET(ApiConstants.ymtazApppointmentsWorkHours)
  Future<WorkingHoursResponse> getAppointmentsWorkHours(
      @Header('Authorization') String token,
      @Query('from_date') String fromDate,
      @Query('to_date') String toDate,
      @Query('required_time') String requiredTime);

  // @GET(ApiConstants.ymtazAdvisoryWorkHours)
  // Future<WorkingHoursResponse> getAdvisoryWorkHours(
  //     @Header('Authorization') String token,
  //     @Query('from_date') String fromDate,
  //     @Query('to_date') String toDate,
  //     @Query('required_time') String requiredTime);

  @GET(ApiConstants.ymtazAdvisoryWorkHours)
  Future<WorkingHoursResponse> getAdvisoryWorkHoursToLawyer(
      @Header('Authorization') String token,
      @Query('from_date') String fromDate,
      @Query('to_date') String toDate,
      @Query('lawyer_id') String lawerId,
      @Query('required_time') String requiredTime);

  // packages
  @GET(ApiConstants.packages)
  Future<PackagesModel> getPackages(@Header('Authorization') String token);

  @GET(ApiConstants.myPackage)
  Future<MyPackageModel> myPackage(@Header('Authorization') String token);

  @POST(ApiConstants.packageSubscribe)
  Future<PackagesSubscribeModel> subscribePackage(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  // @POST(ApiConstants.packagesProviderSubscripe)
  // Future<BuyPackageModel> buyPackage(
  //     @Header('Authorization') String token, @Body() FormData body);

  // @GET('${ApiConstants.packagesRequest}/{id}')
  // Future<SuccessFcmResponse> confirmPayment(
  //     @Header('Authorization') String token, @Path('id') String id);

  // Google Sign In endpoint
  @POST(ApiConstants.googleLogin)
  Future<VisitorLogin> googleLogin(@Field('id_token') String token);

  // Add Apple Sign In endpoint
  @POST(ApiConstants.appleLogin)
  Future<VisitorLogin> appleLogin(@Field('identity_token') String token);

  // new Apiiiiiiiis >>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // my experience
  @GET(ApiConstants.myWorkExperience)
  Future<ExperienceModel> getMyWorkExperience(
      @Header('Authorization') String token);

  @GET(ApiConstants.myPayments)
  Future<MyPaymentsResponse> getPayments(@Header('Authorization') String token);

  // add experience
  @POST(ApiConstants.myWorkExperience)
  Future<ExperienceModel> addMyWorkExperience(
      @Header('Authorization') String token, @Body() dynamic body);

  // add iban
  @POST(ApiConstants.myIban)
  Future<IbanModel> addMyIban(
      @Header('Authorization') String token, @Body() FormData body);

  // my iban
  @GET(ApiConstants.myIban)
  Future<IbanModel> getMyIban(@Header('Authorization') String token);

  // advisory Window New API
  @GET(ApiConstants.advisoriesTypes)
  Future<AdvisoriesCategoriesTypes> getAdvisoriesTypes(
      @Header('Authorization') String token);

  @GET('${ApiConstants.advisoriesTypes}/{id}/general')
  Future<AdvisoriesGeneralSpecialization> getGeneralTypesByAdvisoryId(
      @Header('Authorization') String token, @Path('id') String advisoryTypeId);

  @GET('${ApiConstants.advisoriesTypes}/{id}/general/{generalId}/sub')
  Future<AdvisoriesAccurateSpecialization>
      getAccurateTypesByGeneralAndAdvisoryId(
          @Header('Authorization') String token,
          @Path('id') String advisoryTypeId,
          @Path('generalId') String generalTypeId);

  @GET('${ApiConstants.advisoryLawyersById}sub/{sub_category_id}/lawyers')
  Future<AvailableLawyersForAdvisoryTypeModel> advisoryLawyersById(
      @Header('Authorization') String token,
      @Query('importance_id') String importanceId,
      @Path('sub_category_id') String subCategoryId);

  @GET(ApiConstants.ymtazAdvisoryWorkHours)
  Future<WorkingHoursResponse> getAdvisoryWorkHours(
      @Header('Authorization') String token,
      @Query('from_date') String fromDate,
      @Query('to_date') String toDate,
      @Query('required_time') String requiredTime);

  @POST(ApiConstants.createAdvisoryRequest)
  Future<AdvisoryRequestResponse> createAdvisoryRequest(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.replyAdvisorServicesProvider)
  Future<ServicesReplySuccessResponse> replyAdvisorServicesProvider(
      @Header('Authorization') String token, @Body() FormData body);

  // new Apiiiiiiiis >>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @GET(ApiConstants.getMyServicesClient)
  Future<AllAdvisoryResponse> getMyAdvisorClientFromYmtaz(
      @Header('Authorization') String token);

  @GET(ApiConstants.getMyServicesClientDigital)
  Future<AllAdvisoryResponse> getMyAdvisorClientFromDigital(
      @Header('Authorization') String token);

  @GET('${ApiConstants.advisorServicesTypesClient}/{id}')
  Future<AdvisoryServicesTypesResponse> getAdvisorServicesTypesClient(
      @Header('Authorization') String token, @Path('id') String id);

  @POST(ApiConstants.createAdvisoryRequest)
  Future<AdvisoryRequestResponse> createAdvisorServicesClient(
      @Header('Authorization') String token, @Body() FormData body);

  @GET(ApiConstants.getMyServicesProvider)
  Future<AllAdvisoryResponse> getMyAdvisorProviderFromYmtaz(
      @Header('Authorization') String token);

  @GET(ApiConstants.getMyServicesProviderDigital)
  Future<AllAdvisoryResponse> getMyAdvisorProviderFromDigital(
      @Header('Authorization') String token);

  @GET(ApiConstants.advisorServicesTypesProvider)
  Future<AdvisoryServicesTypesResponse> getAdvisorServicesTypesProvider(
      @Header('Authorization') String token);

  @POST(ApiConstants.createAdvisorServicesProvider)
  Future<AdvisoryRequestResponse> createAdvisorServicesProvider(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.createAdvisorServicesProviderWithLawyer)
  Future<AdvisoryRequestResponse> createAdvisorServicesProviderWithLawyer(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.createAdvisorServicesClientWith)
  Future<AdvisoryRequestResponse> createAdvisorServicesClientWithLawyer(
      @Header('Authorization') String token, @Body() FormData body);

  // get lawyer data by id
  @GET('${ApiConstants.lawyerServicesBase}/{id}')
  Future<LawyerModel> getLawyerDataById(
      @Header('Authorization') String token, @Path('id') String id);

  // Ymtaz contact us
  @GET(ApiConstants.contactYmtazClientNew)
  Future<MyContactYmtazResponse> getMyYmtazMessagesClient(
      @Header('Authorization') String token);

  // Ymtaz about us
  @GET(ApiConstants.aboutUs)
  Future<AboutYmtaz> getAboutUs();

  // faq
  @GET(ApiConstants.faq)
  Future<Faq> getFaq();

  // social media
  @GET(ApiConstants.socialMedia)
  Future<SocialMedia> getSocial();

  // privacy policy
  @GET(ApiConstants.privacyPolicy)
  Future<PrivacyPolicy> getPrivacyPolicy();

  @POST(ApiConstants.contactYmtazClientNew)
  Future<ContactYmtazResponse> contactYmtazClient(
      @Header('Authorization') String token, @Body() FormData body);

  @GET(ApiConstants.contactYmtazClientNew)
  Future<MyContactYmtazResponse> getMyYmtazMessagesProvider(
      @Header('Authorization') String token);

  @GET(ApiConstants.contactYmtazTypes)
  Future<ContactUsTypes> getContactUsTypes(
      @Header('Authorization') String token);

  @POST(ApiConstants.contactYmtazClientNew)
  Future<ContactYmtazResponse> contactYmtazProvider(
      @Header('Authorization') String token, @Body() FormData body);

  // @POST(ApiConstants.digitalGuideSearchClient)
  // Future<DigitalSearchResponseModel> searchDigitalGuideClient(
  //     @Header('Authorization') String token, @Body() FormData body);

  // Services
  @GET(ApiConstants.servicesClient)
  Future<ServicesRequirementsResponse> getServicesClient(
      @Header('Authorization') String token);

  @GET(ApiConstants.servicesProvider)
  Future<ServicesRequirementsResponse> ggetServicesProvider(
      @Header('Authorization') String token);

  @GET(ApiConstants.myServicesClientOffers)
  Future<MyServicesRequestsResponse> getMyServicesRequestOffers(
      @Header('Authorization') String token);

  @POST(ApiConstants.myServicesClientOffersRespond)
  Future<RespondClinetToOfferResponse> myServicesClientOffersRespond(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.myServices)
  Future<ServicesRequestResponse> servicesRequestProvider(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.servicesRequestClient)
  Future<ServicesRequestResponse> servicesRequestClient(
      @Header('Authorization') String token, @Body() FormData body);

  @GET('${ApiConstants.serviceLawyersById}/{id}/lawyers')
  Future<AvailableLawyersForServiceModel> serviceLawyersById(
      @Header('Authorization') String token,
      @Query('importance_id') String importanceId,
      @Path('id') String serviceId);

  // office analytics

  @GET(ApiConstants.lawyerOfficeAnalytics)
  Future<MyOfficeResponseModel> getOfficeAnalytics(
      @Header('Authorization') String token);

  // office services
  @GET(ApiConstants.servicesYmtazToProvider)
  Future<ServicesYmtazResponseModel> getServicesYmtazToProvider(
      @Header('Authorization') String token);

  @POST(ApiConstants.createservicesYmtazToProvider)
  Future<CreateServicesYmtazResponseModel> createServicesYmtazToProvider(
      @Header('Authorization') String token, @Body() FormData body);

  @DELETE('${ApiConstants.hideAndDeleteServicesYmtazToProvider}{id}')
  Future<SuccessModel> deleteServiceFromProfile(
      @Header('Authorization') String token, @Path('id') String id);

  @POST('${ApiConstants.hideAndDeleteServicesYmtazToProvider}{id}')
  Future<SuccessModel> hideServiceFromProfile(
      @Header('Authorization') String token,
      @Path('id') String id,
      @Body() Map<String, String> body);

  @DELETE('${ApiConstants.hideAndDeleteAdvisoryServicesYmtazToProvider}{id}')
  Future<SuccessModel> deleteAdvisoryServiceFromProfile(
      @Header('Authorization') String token, @Path('id') String id);

  @POST('${ApiConstants.hideAndDeleteAdvisoryServicesYmtazToProvider}{id}')
  Future<SuccessModel> hideAdvisoryServiceFromProfile(
      @Header('Authorization') String token,
      @Path('id') String id,
      @Body() Map<String, String> body);

  @DELETE('${ApiConstants.hideAndDeleteAppointmentsYmtazToProvider}{id}')
  Future<SuccessModel> deleteAppointmentsFromProfile(
      @Header('Authorization') String token, @Path('id') String id);

  @POST('${ApiConstants.hideAndDeleteAppointmentsYmtazToProvider}{id}')
  Future<SuccessModel> hideAppointmentsProfile(
      @Header('Authorization') String token,
      @Path('id') String id,
      @Body() Map<String, String> body);

  @POST(ApiConstants.createsAppointmentsTypesToProvider)
  Future<SuccessAppointmentsRequest> createAppointmentsTypesToProvider(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.lawyerWorkHours)
  Future<WorkTimeResponseModel> lawyerWorkingHours(
      @Header('Authorization') String token, @Body() WorkTimeRequestModel body);

  @GET(ApiConstants.lawyerWorkHours)
  Future<WorkDaysAndTimes> getLawyerWorkingHours(
    @Header('Authorization') String token,
  );

  // appointments types lawyer
  @GET(ApiConstants.appointmentsLawyerTypes)
  Future<LawyerAppointments> getAppointmentsLawyerTypes(
      @Header('Authorization') String token);

  @GET(ApiConstants.servicesRequestProviderOfficeClient)
  Future<ServicesFromClientsResponse> getServicesRequestFromClients(
      @Header('Authorization') String token);

  @GET(ApiConstants.servicesRequestsPending)
  Future<ServiceLawyerOffresResponse> servicesRequestsPending(
      @Header('Authorization') String token);

  @GET(ApiConstants.appointmentsRequestsPending)
  Future<AppointmentOffersLawyer> appointmentsRequestsPending(
      @Header('Authorization') String token);

  @POST('${ApiConstants.appointmentsRequestsAttend}{id}/start')
  Future<SuccessModel> appointmentsRequestsAttend(
      @Header('Authorization') String token,
      @Path('id') String reservationId,
      @Body() FormData body);

  @GET(ApiConstants.advisoryRequestProviderOffice)
  Future<LawyerAdvisoriesRequestsResponnse> getAdvisoryRequestFromClients(
      @Header('Authorization') String token);

  @GET(ApiConstants.appointmentRequestProviderOfficeClient)
  Future<AppointmentOfficeReservationsClient> getAppointmetnsFromClients(
      @Header('Authorization') String token);

  @POST(ApiConstants.replyServicesRequestProviderOfficeClient)
  Future<ServicesReplySuccessResponse> replyServicesRequestFromClients(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.replyServicesOfferProviderOfficeClient)
  Future<ResponseLawyerToOffer> replyServicesOfferProviderOfficeClient(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.replyAppointmentsOfferProviderOfficeClient)
  Future<ResponseLawyerToAppointmentOffer>
      replyAppointmentsOfferProviderOfficeClient(
          @Header('Authorization') String token, @Body() FormData body);

  @GET(ApiConstants.advisorServicesProviderOffice)
  Future<AdvisoryAvailableTypesResponse> getAdvisorServicesProviderOffice(
      @Header('Authorization') String token);

  @POST(ApiConstants.addAdvisorServicesProviderOffice)
  Future<AdvisoryTypesAddResponse> addAdvisorServicesProviderOffice(
      @Header('Authorization') String token, @Body() FormData body);

  @GET(ApiConstants.getAdvisorServicesProviderFromClient)
  Future<AllAdvisoryResponse> getAdvisorServicesProviderFromClient(
      @Header('Authorization') String token);

  @GET(ApiConstants.getAdvisorServicesProviderFromLawyer)
  Future<AllAdvisoryResponse> getAdvisorServicesProviderFromLawyer(
      @Header('Authorization') String token);

  @POST(ApiConstants.replyAdvisorServicesProvider)
  Future<AdvisoryRequestResponse> replyAdvisorServicesProviderFromClient(
      @Header('Authorization') String token, @Body() FormData body);

  @POST(ApiConstants.replyAdvisorServicesProviderFromLawyer)
  Future<AdvisoryRequestResponse> replyAdvisorServicesProviderFromLawyer(
      @Header('Authorization') String token, @Body() FormData body);

  // ====== Office Clients ======
  static const String base = "client/lawyer/";

  @GET(ApiConstants.officeClients)
  Future<MyClientsResponse> getClients(
      @Header('Authorization') String token, @Path('id') String id);

  // get my page data
  @GET(ApiConstants.myPage)
  Future<MyPageResponseModel> getMyPageDataClient(
      @Header('Authorization') String token);

  @GET(ApiConstants.myLastAdded)
  Future<LastAdded> myLastAdded(@Header('Authorization') String token);

  @GET(ApiConstants.myLawyers)
  Future<MyLawyersResponse> myLawyers(@Header('Authorization') String token);

  // Digital Guide
  @GET(ApiConstants.digitalGuideCategoriesClient)
  Future<DigitalGuideResponse> getDigitalGuide(
      @Header('Authorization') String token);

  @POST(ApiConstants.digitalGuideSearchClient)
  Future<DigitalSearchResponseModel> searchDigitalGuideClient(
      @Header('Authorization') String token, @Body() FormData body);

  // Advisory Committees
  @GET(ApiConstants.advisoryCommitteesClient)
  Future<AdvisoryCommitteesResponse> getAdvisoryCommittees(
      @Header('Authorization') String token);

  @GET("${ApiConstants.advisoryCommitteesLawyersById}{id}")
  Future<AdvisoryCommitteesLawyersResponse> getAdvisoryCommitteesLawyersById(
      @Header('Authorization') String token, @Path('id') String id);

  @GET(ApiConstants.lawyerAdvisorServicesBase)
  Future<dynamic> getLawyerAdvisors(
      @Header('Authorization') String token, @Query('id') String id);

  @GET(ApiConstants.lawyerServicesBase)
  Future<dynamic> getServices(
      @Header('Authorization') String token, @Query('id') String id);


  @GET(ApiConstants.myPage)
  Future<MyPageLawyerResponseModel> getMyPageDataProvider(
      @Header('Authorization') String token);

  // notifications
  @GET(ApiConstants.notifications)
  Future<NotificationsResponseModel> getNotifications(
      @Header('Authorization') String token);

  @POST(ApiConstants.notificationSeen)
  Future<MarkNotificationSeenResponse> notificationSeen(
      @Header('Authorization') String token, @Body() Map<String, String> body);

  // favorite

  @GET(ApiConstants.fastSearch)
  Future<FastSearchResponseModel> fastSearch(
      @Header('Authorization') String token, @Query('name') String name);

  // judicialGuide
  @GET(ApiConstants.judicialGuide)
  Future<JudicialGuideResponseModel> getJudicialGuide(
      @Header('Authorization') String token);

  // law guide main subs laws search

  @GET(ApiConstants.lawGuide)
  Future<LawGuideMainResponse> getLawGuide(
      @Header('Authorization') String token);

  @GET("${ApiConstants.lawGuide}/{id}")
  Future<LawGuideSubMainResponse> getLawGuideSubFromMain(
      @Header('Authorization') String token, @Path('id') String id);

  // @GET("${ApiConstants.lawGuideSub}{subId}")
  // Future<LawResponse> getLawsGuideSubFromSub(
  //     @Header('Authorization') String token,
  //     @Path('id') String id,
  //     @Path('subId') String subId);

  @GET("${ApiConstants.lawGuideSub}{subId}")
  Future<LawResponse> getLawsGuideSubFromSub(
    @Header('Authorization') String token,
    @Path('subId') String subId,
    @Query('perPage') int perPage,
    @Query('page') int page,
  );

  @GET("${ApiConstants.lawById}{id}")
  Future<LawByIdResponse> getLawById(
      @Header('Authorization') String token, @Path('id') String id);

  @POST(ApiConstants.lawGuideSearch)
  Future<LawGuideSearchResponse> searchLawGuide(
      @Header('Authorization') String token, @Body() FormData body);

// books

  @GET(ApiConstants.booksGuide)
  Future<BooksResponse> getMainCategoryBooks(
      @Header('Authorization') String token);

  // ivcitations
// send invitations
  @POST(ApiConstants.invite)
  Future<ResponseModel> inviteUser(
      @Header('Authorization') String token, @Body() Map<String, String> body);

  @GET(ApiConstants.invite)
  Future<InvitesModel> getInvitedUsers(@Header('Authorization') String token);

  // elite
  @GET(ApiConstants.eliteCategoris)
  Future<EliteCategoryModel> getEliteCategories(
      @Header('Authorization') String token);

  // elite my requests
  @GET(ApiConstants.eliteRequests)
  Future<EliteMyRequestsModel> getEliteRequests(
      @Header('Authorization') String token);

  // elite send request
  @POST(ApiConstants.eliteRequest)
  Future<EliteRequestModel> sendEliteRequest(
      @Header('Authorization') String token, @Body() FormData body);

  @GET('v1/elite/pricing-requests')
  Future<ElitePricingRequestsModel> getPricingRequests(
    @Header('Authorization') String token,
  );

  @POST(ApiConstants.elitePricingRequestReply)
  Future<ElitePricingResponse> replyToPricingRequest(
    @Header('Authorization') String token,
    @Body() Map<String, dynamic> body,
  );

  @POST('v1/elite/offers/{id}/approve')
  Future<EliteOfferApprovalResponse> approveEliteOffer(
    @Header('Authorization') String token,
    @Path('id') String offerId,
    @Body() Map<String, String> body,
  );

  @GET(ApiConstants.learningPaths)
  Future<LearningPathsResponse> getLearningPaths(
    @Header('Authorization') String token,
  );

  // @GET(ApiConstants.learningPathsAnalytics)
  // Future<LearningPathAnalyticsResponse> getLearningPathsAnalytics(
  //     @Header('Authorization') String token,
  //     );

  @GET(ApiConstants.learningPathItems)
  Future<LearningPathItemsResponse> getLearningPathItems(
    @Header('Authorization') String token,
    @Path('id') int pathId,
  );

  @GET('v1/law-guide/law/{id}')
  Future<LawDetailsResponse> getLawDetails(
    @Header('Authorization') String token,
    @Path('id') int lawId,
  );

  @POST('v1/learning-paths')
  Future<LearningProgressResponse> updateLearningProgress(
    @Header('Authorization') String token,
    @Field('type') String type,
    @Field('item_id') int itemId,
  );

  @GET('v1/book-guide/sections/{sectionId}')
  Future<BookDetailsResponse> getBookDetails(
    @Header('Authorization') String token,
    @Path('sectionId') int sectionId,
  );

  @POST('v1/learning-path/items/{itemId}/{type}')
  Future<LearningProgressResponse> updateLearningProgressbooks(
    @Header('Authorization') String token,
    @Path('type') String type,
    @Path('itemId') int itemId,
  );

  @POST('v1/learning-paths/learning-path-items/{id}/favourite')
  Future<BaseResponse> toggleFavouriteLearningPathItem(
    @Header('Authorization') String token,
    @Path('id') int itemId,
  );

  @GET('v1/learning-paths/learning-path-items/{id}/favourites')
  Future<FavouriteItemsResponse> getFavouriteLearningPathItems(
    @Header('Authorization') String token,
    @Path('id') int pathId,
  );
}
