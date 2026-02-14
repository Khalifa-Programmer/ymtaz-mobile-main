import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/shared/models/accurate_speecialties.dart';
import 'package:yamtaz/core/shared/models/degrees.dart' as d;
import 'package:yamtaz/core/shared/models/functional_cases.dart';
import 'package:yamtaz/core/shared/models/general_specialty.dart';
import 'package:yamtaz/core/shared/models/languages_response.dart';
import 'package:yamtaz/core/shared/models/lawyer_type.dart';
import 'package:yamtaz/core/shared/models/section_type.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_request_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/sign_up_response_body.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_otp_request.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/verify_provider_request.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_state.dart';
import 'package:yamtaz/feature/layout/account/data/models/user_data_model.dart';

import '../../login/data/models/login_provider_response.dart';
import '../data/models/nationalities_response.dart';
import '../data/models/verify_request_body.dart';
import '../data/repos/sign_up_repo.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._signUpRepo) : super(const SignUpState.initial());

  final SignUpRepo _signUpRepo;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  String providerphoneCode = '';
  String? countryCodeSelected;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //text fields for provider
  final TextEditingController providerFirstNameController =
      TextEditingController();
  final TextEditingController providerSecondNameController =
      TextEditingController();
  final TextEditingController providerThirdNameController =
      TextEditingController();
  final TextEditingController providerFourthNameController =
      TextEditingController();

  final TextEditingController providerEmailController = TextEditingController();
  final TextEditingController providerPhoneController = TextEditingController();

  final TextEditingController providerPasswordController =
      TextEditingController();
  final TextEditingController providerConfirmPasswordController =
      TextEditingController();
  final TextEditingController degreeOtherSpecialtyController =
      TextEditingController();

  final TextEditingController refController = TextEditingController();

  String providerPhone = ''; // for take +2323
  File? profileImage;
  File? logoImage;
  File? resumeImage;
  File? degreeVerifyImage;
  File? idImage;

  //File? degreeImage;
  DateTime? selectedBirthDate;

  final TextEditingController aboutController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final FocusNode idFieldFocus = FocusNode();

  final TextEditingController licenseId = TextEditingController();

  final pinOtpController = TextEditingController();
  final globalFormKey = GlobalKey<FormState>();
  final pinGlobalFormKey = GlobalKey<FormState>();
  SignUpResponse? signUpResponse;
  final TextEditingController otpController = TextEditingController();

  Map<String, int> accountType = {
    'فرد': 1,
    'مؤسسة': 2,
    'شركة': 3,
    'جهة حكومية': 4,
    'هيئة': 5,
  };

  Map<String, int> idType = {
    'هوية وطنية': 1,
    'جواز السفر': 2,
    'هوية مقيم': 3,
  };

  Map<String, String> gender = {
    'ذكر': "Male",
    'أنثى': "Female",
  };

  bool isObsecure = true;

  void firtInit() {
    emitCounrties();
    emitNationalities();
  }

  Type? targetType;
  FunctionalCase? targetFunctionalCase;
  d.Degree? targetDegree;

  AccurateSpecialty? targetAccurateSpecialty;
  GeneralSpecialtyElement? targetGeneralSpecialty;

  bool isLoading = true;
  LanguagesResponse? langs;
  List<Language>? selectedLanguages;
  bool phoneIsverifed = true;

  Future<void> validatePhone(String phone, String ccode) async {
    emit(const SignUpState.loadingSignUpProviderOtp());
    final response = await _signUpRepo.validatePhone(phone, ccode);
    response.when(success: (responseModel) {
      emit(SignUpState.successSignUpProviderOtp(responseModel));
    }, failure: (fail) {
      emit(SignUpState.errorSignUpProviderOtp(
          error: extractErrors(fail['data'])));
    });
  }

  Future<void> verifyPhoneOtp(String phone, String ccode, String code) async {
    emit(const SignUpState.loadingSignUpProviderOtpEdit());
    final response = await _signUpRepo.verifyPhoneOtp(phone, ccode, code);
    response.when(success: (responseModel) {
      emit(SignUpState.successSignUpProviderOtpEdit(responseModel));
    }, failure: (fail) {
      emit(SignUpState.errorSignUpProviderOtpEdit(
          error: fail['message'].toString()));
    });
  }

  Future<void> loadApiData() async {
    emit(const SignUpState.loadingAllData());
    try {
      List<ApiResult<dynamic>> results = await _signUpRepo.fetchAllData();

      for (ApiResult<dynamic> result in results) {
        result.when(
          success: (data) {
            if (data is CountriesResponse) {
              countries = data;
            } else if (data is NationalitiesResponse) {
              nationalities = data;
            } else if (data is GeneralSpecialty) {
              generalSpecialty = data;
            } else if (data is AccurateSpecialties) {
              accurateSpecialty = data;
            } else if (data is d.Degrees) {
              degrees = data;
            } else if (data is SectionsType) {
              sections = data;
            } else if (data is FunctionalCases) {
              functionalCases = data;
            } else if (data is LawyerTypes) {
              lawyerTypes = data;
            } else if (data is LanguagesResponse) {
              langs = data;
            }

            emit(const SignUpState.successAllData());
          },
          failure: (error) {
            emit(SignUpState.errorAllData(error: error.toString()));
          },
        );
      }
    } catch (error) {}
  }

  bool? isNetworkImageCv = false;

  bool? isNetworkImageDegree = false;

  bool? isNetworkImageCompany = false;
  bool? isNetworkImageId = false;

  bool? isNetworkImageLogo = false;

  bool? isNetworkImageProfile = false;

  Nationality? targetNationality;

  Country? targetCountry;

  Region? targetRegion;

  City? targetCity;

  Position? currentPositionUser;
  String? targetGender;
  String? targetIdentitiyType;

  Future<void> loadUserData(LoginProviderResponse userData) async {
    await loadApiData();
    // البيانات الاساسية للمستخدم
    providerFirstNameController.text = userData.data!.account!.firstName ?? "";
    providerSecondNameController.text =
        userData.data!.account!.secondName ?? "";
    providerThirdNameController.text = userData.data!.account!.thirdName ?? "";
    providerFourthNameController.text =
        userData.data!.account!.fourthName ?? "";
    emailController.text = userData.data!.account!.email ?? "";
    phoneController.text = userData.data!.account!.phone ?? "";
    providerphoneCode = userData.data!.account!.phoneCode.toString() ?? "966";

    aboutController.text = userData.data!.account!.about ?? "";
    selectedBirthDate = userData.data!.account!.birthday;
    idController.text = userData.data!.account!.natId ?? "";
    accountTypeValue = userData.data!.account!.type ?? -1;

    idTypeValue = userData.data!.account!.identityType ?? -1;

    if (userData.data!.account!.identityType != null) {
      targetIdentitiyType =
          idType.entries.firstWhere((entry) => entry.value == idTypeValue).key;
    }

    degreeOtherSpecialtyController.text =
        userData.data!.account!.otherDegree ?? "";

    selectedCountry = userData.data!.account?.country?.id ?? -1;
    targetCountry = getCountryById(selectedCountry);
    regions = getRegionsByCountryId(selectedCountry);
    selectedRegion = userData.data!.account!.region?.id ?? -1;
    targetRegion = getRegionById(selectedRegion);
    selectedDistricts = userData.data!.account!.city?.id ?? -1;
    selectedNationality = userData.data!.account!.nationality == null
        ? -1
        : userData.data!.account!.nationality!.id!;
    targetNationality = getNationalityById(selectedNationality);
    cities = targetRegion?.cities ?? [];
    targetCity = getCityById(selectedDistricts);
    currentPositionUser = userData.data!.account!.latitude != null ||
            userData.data!.account!.longitude != null
        ? Position(
            latitude: double.parse(userData.data!.account!.latitude!),
            longitude: double.parse(userData.data!.account!.longitude!),
            altitude: 0,
            accuracy: 0,
            speed: 0,
            speedAccuracy: 0,
            heading: 0,
            headingAccuracy: 0,
            timestamp: DateTime.now(),
            altitudeAccuracy: 0,
          )
        : null;

    if (userData.data!.account!.photo != "https://api.ymtaz.sa/Male.png" ||
        userData.data!.account!.photo != "https://api.ymtaz.sa/Female.png") {
      isNetworkImageProfile = true;
    }
    if (userData.data!.account!.logo != "https://api.ymtaz.sa/Male.png" ||
        userData.data!.account!.logo != "https://api.ymtaz.sa/Female.png") {
      isNetworkImageLogo = true;
    }

    if (userData.data!.account!.cv != null) {
      isNetworkImageCv = true;
    }
    if (userData.data!.account!.degreeCertificate != null) {
      isNetworkImageDegree = true;
    }
    if (userData.data!.account!.companyLisencesFile != null) {
      isNetworkImageCompany = true;
    }
    if (userData.data!.account!.idFile != null) {
      isNetworkImageId = true;
    }

    // لتحديد نوع الحساب فردي او مؤسسة او شركة في الاختيارات
    if (lawyerTypes?.data?.types != null) {
      if (accountTypeValue != -1) {
        final matchingTypes = lawyerTypes!.data!.types!.where(
          (type) => type.id == accountTypeValue,
        );

        if (matchingTypes.isNotEmpty) {
          targetType = matchingTypes.first;
        } else {
          // Handle the case where no matching type is found
          print(
              "No matching lawyer type found for accountTypeValue: $accountTypeValue");
        }
      }
    }

    //لتحديد نوع الحساب فردي او مؤسسة او شركة
    if (targetType != null) {
      needCompanyName = targetType!.needCompanyName!;
      needLicenseNo = targetType!.needCompanyLicenceNo!;
      needLicenseFile = targetType!.needCompanyLicenceNo!;
    }
    if (needLicenseNo == 1) {
      licenseNoController.text =
          userData.data!.account!.companyLisencesNo ?? "";
    }
    if (needCompanyName == 1) {
      companyNameController.text = userData.data!.account!.companyName ?? "";
    }
    //لتحديد نوع الحساب ذكر او أنثى
    Map<String, String> reversedGenderMap = Map.fromEntries(
        gender.entries.map((entry) => MapEntry(entry.value, entry.key)));
    targetGender = reversedGenderMap[userData.data!.account!.gender] ?? "";
    selectedGender = userData.data!.account!.gender ?? '';
    selectedDegree = userData.data!.account!.degree?.id ?? -1;
    degreeOtherSpecialtyController.text = userData.data!.account!.otherDegree ??
        userData.data!.account!.degree?.title ??
        "";
    selectedFunctionalCase = userData.data!.account!.functionalCases?.id ?? -1;
    selectedAccurateSpecialty =
        userData.data!.account!.accurateSpecialty?.id ?? -1;
    selectedGeneralSpecialty =
        userData.data!.account!.generalSpecialty?.id ?? -1;

    // لتحديد الدولة في الاختيارت و الجنسيه
    // selectedCountry = userData.data!.client!.country!;
    if (functionalCases?.data?.functionalCases != null &&
        userData.data?.account?.functionalCases?.id != null &&
        selectedFunctionalCase != -1) {
      try {
        targetFunctionalCase = functionalCases!.data!.functionalCases!
            .firstWhere((element) =>
                    element.id ==
                    userData.data!.account!.functionalCases!
                        .id // Cast null to the correct type
                );
      } catch (e) {
        // Handle the case where no matching functional case is found
        print("No matching functional case found for the user.");
      }

      if (targetFunctionalCase == null) {
        // Handle the case where no matching functional case is found
        print("No matching functional case found for the user.");
      }
    }
    //
    // // لتحديد الدرجة العلمية
    // selectedDegree = userData.data!.client!.degree!.id!;
    if (degrees?.data?.degrees != null &&
        userData.data?.account?.degree?.id != null &&
        userData.data?.account?.degree?.id != -1) {
      try {
        targetDegree = degrees!.data!.degrees!.firstWhere(
          (element) => element.id == userData.data!.account!.degree!.id,
        );
      } catch (e) {
        // Handle the case where no matching degree is found
        print("No matching degree found for the user.");
      }

      if (targetDegree != null) {
        if (targetDegree!.needCertificate == 1) {
          selectedDegreeNeedCertificate = true;
        } else {
          selectedDegreeNeedCertificate = false;
        }
      } else {
        // Handle the case where no matching degree is found
        print("No matching degree found for the user.");
      }
    }
    // لتحديد التخصص العام
    // selectedGeneralSpecialty = userData.data!.client!.generalSpecialty!.id!;
    if (generalSpecialty?.data?.generalSpecialty != null &&
        userData.data?.account?.generalSpecialty?.id != null &&
        selectedGeneralSpecialty != -1) {
      try {
        // البحث عن التخصص بناءً على id المستخدم
        targetGeneralSpecialty =
            generalSpecialty!.data!.generalSpecialty!.firstWhere(
          (element) =>
              element.id == userData.data!.account!.generalSpecialty!.id!,
        );
      } catch (e) {
        // إذا لم يتم العثور على التخصص في القائمة، لن يتم تعيين أي قيمة
        // يمكن ترك الكتلة فارغة أو تسجيل الخطأ إن كنت ترغب بذلك
      }

      if (targetGeneralSpecialty == null) {
        // Handle the case where no matching general specialty is found
        print("No matching general specialty found for the user.");
      }
    }
    // لتحديد التخصص account
    selectedAccurateSpecialty =
        userData.data!.account!.accurateSpecialty?.id ?? -1;
    if (accurateSpecialty?.data?.accurateSpecialty != null &&
        userData.data?.account?.accurateSpecialty?.id != null &&
        userData.data?.account?.accurateSpecialty?.id != -1) {
      try {
        targetAccurateSpecialty = accurateSpecialty!.data!.accurateSpecialty!
            .firstWhere((element) =>
                    element.id ==
                    userData.data!.account!.accurateSpecialty!
                        .id! // Return null if no match is found
                );
      } catch (e) {}

      if (targetAccurateSpecialty == null) {
        // Handle the case where no matching accurate specialty is found
        print("No matching accurate specialty found for the user.");
      }
    }
    // المهنة
    // هنا بجيب المهن الي في ملف العميل وبستخدمها في الاختيارات
    if (sections != null) {
      selectedSections =
          sections!.data!.digitalGuideCategories!.where((element) {
        // Check if any section's 'id' is present in userData.client.sections
        return userData.data!.account!.sections!.any((section) =>
            section.section != null && element.id == section.section!.id);
      }).toList();

//selectedSectionsNeedLicense
      selectedSectionsNeedLicense =
          sections!.data!.digitalGuideCategories!.where((element) {
        // Check if any section's 'id' is present in userData.client.sections
        return userData.data!.account!.sections!.any((section) =>
            section.section != null &&
            element.id == section.section!.id &&
            section.section!.needLicense == 1);
      }).toList();

      for (int i = 0; i < selectedSections.length; i++) {
        if (userData.data!.account!.sections![i].section!.needLicense == 1) {
          selectedSectionsNeedLicenseText.add(TextEditingController(
            text:
                userData.data!.account!.sections![i].lawyerLicenseNo.toString(),
          ));
          selectedSectionsNeedLicenseFiles.add(null);
          if (userData.data!.account!.sections![i].lawyerLicenseFile != null) {
            selectedSectionsContainLicenseImageBool.add(true);
          } else {
            selectedSectionsContainLicenseImageBool.add(false);
          }
          // downloadAndAddFile(
          //     userData.data!.client!.sections![i].lawyerLicenseFile! , i);
        }
      }
    }
    print(isLoading);
    // اضافة اللغات المختارة

    if (langs != null) {
      selectedLanguages = langs!.data!.languages!.where((element) {
        // Check if any section's 'id' is present in userData.client.sections
        return userData.data!.account!.languages!
            .any((lang) => lang.id != null && element.id == lang.id);
      }).toList();
    }

    isLoading = false;

    emit(const SignUpState.successAllData());
  }

  String? image;

  Future<void> loadUserDataProvider(UserDataResponse userData) async {
    providerFirstNameController.text = userData.data!.client!.firstName ?? "";
    providerSecondNameController.text = userData.data!.client!.secondName ?? "";
    providerThirdNameController.text = userData.data!.client!.thirdName ?? "";
    providerFourthNameController.text = userData.data!.client!.fourthName!;
    emailController.text = userData.data!.client!.email ?? "";
    phoneController.text = userData.data!.client!.phone ?? "";
    providerphoneCode = userData.data!.client!.phoneCode!;

    image = userData.data!.client!.photo!;
  }

  Future<void> downloadAndAddFile(String fileUrl, int i) async {
    try {
      final response = await Dio().get<List<int>>(fileUrl,
          options: Options(responseType: ResponseType.bytes));

      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Determine the file extension based on the response content type or URL
      final contentType = response.headers.map['content-type']?.first;
      final fileExtension =
          contentType != null ? '.${contentType.split('/').last}' : '.unknown';

      // Create a File object in the temporary directory with a unique name
      final file = File(
          '${tempDir.path}/file_${DateTime.now().millisecondsSinceEpoch}$fileExtension');

      // Write the file data to the file
      await file.writeAsBytes(response.data!);

      // Add the File object to your list
      selectedSectionsNeedLicenseFiles.insert(i, file);
    } catch (error) {}
  }

  void firstInitprovider() {
    emitCounrties();
    emitNationalities();
    emitGeneralSpecialty();
    emitAccurateSpecialty();
    emitDegrees();
    emitLangs();
    emitSections();
    emitLawyerTypes();
    emitFunctionalCases();
  }

  int selectedCountry = -1;
  int selectedRegion = -1;
  int selectedDistricts = -1;

  int accountTypeValue = -1;
  int needLicenseNo = -1;
  int needCompanyName = -1;
  int needLicenseFile = -1;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController licenseNoController = TextEditingController();
  File? licenseFileCompany;

  int idTypeValue = -1;

  int selectedNationality = -1;
  String selectedGender = '';
  int selectedDegree = -1;
  bool selectedDegreeNeedCertificate = false;
  bool selectedDegreeIsSpecial = false;
  int selectedGeneralSpecialty = -1;
  int selectedAccurateSpecialty = -1;
  int selectedSection = -1; // replaced with new list

  List<DigitalGuideCategory> selectedSections = [];
  List<DigitalGuideCategory> selectedSectionsNeedLicense = [];
  List<File?> selectedSectionsNeedLicenseFiles = [];
  List<TextEditingController> selectedSectionsNeedLicenseText = [];
  List<bool?> selectedSectionsContainLicenseImageBool = [];

  int selectedFunctionalCase = -1;
  int selectedCountryPhoneCode = -1;

  //edit provider
  Future<void> emitEditProviderState(FormData edit) async {
    emit(const SignUpState.loadingEditProvider());
    final response = await _signUpRepo.editProvider(edit);
    response.when(success: (response) {
      emit(SignUpState.successEditProvider(response));
    }, failure: (fail) {
      emit(SignUpState.errorEditProvider(
          error: fail['data'] != null
              ? extractErrors(fail['data'])
              : fail['message']));
    });
  }

  //get provider data
  // UserDataResponse? userDataResponse;
  //
  // Future<void> emitGetProviderState() async {
  //   emit(const SignUpState.loadingGetProvider());
  //   final response = await _signUpRepo.getProviderData();
  //   response.when(success: (user) {
  //     userDataResponse = user;
  //     emit(SignUpState.successGetProvider(user));
  //   }, failure: (fail) {
  //     emit(SignUpState.errorGetProvider(error: extractErrors(fail['data'])));
  //   });
  // }

  /// deprecated
  Future<void> emitSignUpProviderState(FormData signUpRequestBody) async {
    emit(const SignUpState.loadingSignUpProvider());
    final response = await _signUpRepo.registerProvider(signUpRequestBody);
    response.when(success: (signupResponse) {
      emit(SignUpState.successSignUpProvider(signupResponse));
    }, failure: (fail) {
      emit(SignUpState.errorSignUpProvider(error: extractErrors(fail['data'])));
    });
  }

  /// deprecated

  Future<void> emitSignUpState(SignUpRequestBody signUpRequestBody) async {
    emit(const SignUpState.loading());
    final response = await _signUpRepo.registerClient(signUpRequestBody);
    response.when(success: (signupResponse) {
      signUpResponse = signupResponse;
      emit(SignUpState.success(signupResponse));
    }, failure: (fail) {
      emit(SignUpState.error(
          error: fail['data'] != null
              ? extractErrors(fail['data'])
              : fail['message']));
    });
  }

  //verify

  Future<void> emitVerifyState(VerifyRequestBody verifyRequestBody) async {
    emit(const SignUpState.loadingVerify());
    final response = await _signUpRepo.verifyClient(verifyRequestBody);
    response.when(success: (verify) {
      emit(SignUpState.successVerify(verify));
    }, failure: (fail) {
      emit(SignUpState.errorVerify(error: extractErrors(fail['data'])));
    });
  }

  Future<void> emitVerifyEditState(String otp, String token) async {
    emit(const SignUpState.loadingVerifyOtpEdit());
    final response = await _signUpRepo.verifyOtpEdit(token, otp);
    response.when(success: (verify) {
      emit(SignUpState.successVerifyOtpEdit(verify));
    }, failure: (fail) {
      emit(SignUpState.errorVerifyOtpEdit(error: fail['message']));
    });
  }

  Future<void> emitCounrties() async {
    emit(const SignUpState.loadingCountries());
    final response = await _signUpRepo.getCountries();
    response.when(success: (countriesResponse) {
      countries = countriesResponse;
      emit(SignUpState.successCountries(countriesResponse));
    }, failure: (fail) {
      emit(SignUpState.errorCountries(error: extractErrors(fail['data'])));
    });
  }

  Future<void> resendCode(String token) async {
    emit(const SignUpState.loadingResendOtp());
    final response = await _signUpRepo.resendCode(token);
    response.when(success: (Response) {
      emit(SignUpState.successResendOtp(Response.message ?? ""));
    }, failure: (fail) {
      emit(SignUpState.errorResendOtp(error: fail['message']));
    });
  }

  void selectDistricts(int cityId) {
    selectedDistricts = cityId;
    emit(SignUpState.successCountries(countries!));
  }

  CountriesResponse? countries;

  void selectCounrty(List<Region> data, int countryId, int phoneCode) {
    selectedDistricts = -1;
    selectedRegion = -1;
    selectedCountryPhoneCode = phoneCode;
    selectedCountry = countryId;
    regions = data;
    cities = [];
    emit(SignUpState.successCountries(countries!));
  }

  Country? getCountryById(int? countryId) {
    if (countryId == null ||
        countries == null ||
        countryId == -1 ||
        countries!.data?.countries == null) {
      return null; // Return null if any necessary parameter is null
    }

    return countries!.data!.countries!.firstWhere(
      (country) => country.id == countryId,
    );
  }

  Nationality? getNationalityById(int? countryId) {
    if (countryId == null ||
        countryId == -1 ||
        countries == null ||
        countries!.data?.countries == null) {
      return null; // Return null if any necessary parameter is null or countryId is -1
    }

    return nationalities!.data!.nationalities!.firstWhere(
      (country) => country.id == countryId,
    );
  }

  List<Region>? getRegionsByCountryId(int? countryId) {
    if (countryId == null ||
        countryId == -1 ||
        countries == null ||
        countries!.data?.countries == null) {
      return []; // Return an empty list if any necessary parameter is null or countryId is -1
    }

    Country? country = countries!.data!.countries!.firstWhere(
      (country) => country.id == countryId,
    );

    return country.regions;
  }

  Region? getRegionById(int? regionId) {
    if (regionId == null ||
        regionId == -1 ||
        regions == null ||
        selectedCountry == -1) {
      return null; // Return null if any necessary parameter is null or regionId is -1
    }

    return regions!.firstWhere(
      (region) => region.id == regionId,
    );
  }

  City? getCityById(int? cityId) {
    if (cityId == null || cityId == -1 || regions == null) {
      return null; // Return null if any necessary parameter is null or cityId is -1
    }

    return regions!
        .expand((region) => region.cities ?? [])
        .firstWhere((city) => city.id == cityId, orElse: () => null);
  }

  List<Region>? regions = [];
  List<City>? cities = [];

  void selectRegion(List<City> data, int redgionId) {
    selectedRegion = redgionId;
    cities = [];
    cities = data;
    targetCity = null;

    emit(SignUpState.successCountries(countries!));
  }

  // general specialty

  GeneralSpecialty? generalSpecialty;

  Future<void> emitGeneralSpecialty() async {
    emit(const SignUpState.loadingGeneralSpecialty());
    final response = await _signUpRepo.getGeneralSpecialty();
    response.when(success: (generalSpecialtyResponse) {
      generalSpecialty = generalSpecialtyResponse;
      emit(SignUpState.successGeneralSpecialty(generalSpecialtyResponse));
    }, failure: (fail) {
      emit(SignUpState.errorGeneralSpecialty(
          error: extractErrors(fail['data'])));
    });
  }

  // accurate specialty
  AccurateSpecialties? accurateSpecialty;

  Future<void> emitAccurateSpecialty() async {
    emit(const SignUpState.loadingAccurateSpecialty());
    final response = await _signUpRepo.getAccurateSpecialty();
    response.when(success: (accurateSpecialtyResponse) {
      accurateSpecialty = accurateSpecialtyResponse;
      emit(SignUpState.successAccurateSpecialty(accurateSpecialtyResponse));
    }, failure: (fail) {
      emit(SignUpState.errorAccurateSpecialty(
          error: extractErrors(fail['data'])));
    });
  }

  // degrees
  d.Degrees? degrees;

  Future<void> emitDegrees() async {
    emit(const SignUpState.loadingDegrees());
    final response = await _signUpRepo.getDegrees();
    response.when(success: (degreesResponse) {
      degrees = degreesResponse;
      emit(SignUpState.successDegrees(degreesResponse));
    }, failure: (fail) {
      emit(SignUpState.errorDegrees(error: extractErrors(fail['data'])));
    });
  }

  Future<void> emitLangs() async {
    emit(const SignUpState.loadingDegrees());
    final response = await _signUpRepo.getLangs();
    response.when(success: (degreesResponse) {
      langs = degreesResponse;
      emit(const SignUpState.loadingDegrees());
    }, failure: (fail) {
      emit(SignUpState.errorDegrees(error: extractErrors(fail['data'])));
    });
  }

  // sections
  SectionsType? sections;

  Future<void> emitSections() async {
    emit(const SignUpState.loadingSections());
    final response = await _signUpRepo.getSections();
    response.when(success: (sectionsResponse) {
      sections = sectionsResponse;
      emit(SignUpState.successSections(sectionsResponse));
    }, failure: (fail) {
      emit(SignUpState.errorSections(error: extractErrors(fail['data'])));
    });
  }

  // functional cases
  FunctionalCases? functionalCases;

  Future<void> emitFunctionalCases() async {
    emit(const SignUpState.loadingFunctionalCases());
    final response = await _signUpRepo.getFunctionalCases();
    response.when(success: (functionalCasesResponse) {
      functionalCases = functionalCasesResponse;
      emit(SignUpState.successFunctionalCases(functionalCasesResponse));
    }, failure: (fail) {
      emit(
          SignUpState.errorFunctionalCases(error: extractErrors(fail['data'])));
    });
  }

// nationalities
  NationalitiesResponse? nationalities;

  Future<void> emitNationalities() async {
    emit(const SignUpState.loadingCountries());
    final response = await _signUpRepo.getNationalities();
    response.when(success: (nationalitiesResponse) {
      nationalities = nationalitiesResponse;
      emit(SignUpState.successNationalities(nationalitiesResponse));
    }, failure: (fail) {
      emit(SignUpState.errorCountries(error: extractErrors(fail['data'])));
    });
  }

  // lawyer types

  LawyerTypes? lawyerTypes;

  Future<void> emitLawyerTypes() async {
    emit(const SignUpState.loadingLawyerTypes());
    final response = await _signUpRepo.getLawyerTypes();
    response.when(success: (lawyerTypesResponse) {
      lawyerTypes = lawyerTypesResponse;
      emit(SignUpState.successLawyerTypes(lawyerTypesResponse));
    }, failure: (fail) {
      emit(SignUpState.errorLawyerTypes(error: extractErrors(fail['data'])));
    });
  }

  // verify provider
  Future<void> emitVerifyProviderState(
      VerifyProviderRequest verifyRequestBody) async {
    emit(const SignUpState.loadingVerifyProvider());
    final response = await _signUpRepo.verifyProvider(verifyRequestBody);
    response.when(success: (verify) {
      emit(SignUpState.successVerifyProvider(verify));
    }, failure: (fail) {
      emit(SignUpState.errorVerifyProvider(error: extractErrors(fail['data'])));
    });
  }

  // verify provider otp
  Future<void> emitVerifyProviderOtpState(
      VerifyProviderOtpRequest verifyRequestBody) async {
    emit(const SignUpState.loadingVerifyProviderOtp());
    final response = await _signUpRepo.verifyProviderOtp(verifyRequestBody);
    response.when(success: (verify) {
      emit(SignUpState.successVerifyProviderOtp(verify));
    }, failure: (fail) {
      emit(SignUpState.errorVerifyProviderOtp(
          error: extractErrors(fail['data'])));
    });
  }

  Future<File?> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return null;
      final imageFinal = File(image.path);
      String fileExtension = extension(imageFinal.path);

      if (fileExtension == '.png' ||
          fileExtension == '.jpg' ||
          fileExtension == '.jpeg' ||
          fileExtension == '.PNG' ||
          fileExtension == '.JPG' ||
          fileExtension == '.JPEG' ||
          fileExtension == '.pdf') {
        return imageFinal;
      } else {
        emit(const SignUpState.errorImage(
            error: 'يجب اختيار صورة او ملف بصيغة png,jpg,jpeg,PNG,JPG,JPEG'));
        return null;
      }
    } on PlatformException {
      emit(const SignUpState.errorImage(
          error: 'يجب اختيار صورة او ملف بصيغة png,jpg,jpeg,PNG,JPG,JPEG'));
    }
    emit(const SignUpState.successImage());
    return null;
  }

  void removeImage(File imageFile) {
    profileImage = imageFile;
    emit(const SignUpState.successImage());
  }

  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'png',
          'JPEG',
          'JPG',
          'jpg',
          'jpeg',
          'PNG',
          'PDF'
        ],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        File pickedFile = File(file.path!);

        // if (file.size! > (5 * 1024 * 1024)) { // 5 MB limit as an example
        //   emit(const SignUpState.errorImage(
        //       error: 'File size exceeds the allowed limit (5 MB).'));
        //   print("object");
        //   return null;
        // }

        String fileExtension = extension(pickedFile.path);
        if (fileExtension == '.png' ||
            fileExtension == '.jpg' ||
            fileExtension == '.jpeg' ||
            fileExtension == '.PNG' ||
            fileExtension == '.JPG' ||
            fileExtension == '.JPEG' ||
            fileExtension == '.pdf') {
          return pickedFile;
        } else {
          emit(const SignUpState.errorImage(
              error: 'يجب اختيار صورة او ملف بصيغة png,jpg,jpeg,PNG,JPG,JPEG'));
          return null;
        }

        // You can now use the pickedFile as needed

        // You can return the file if needed
        // return pickedFile;
      } else {}
    } catch (e) {
      emit(const SignUpState.errorImage(
          error: 'يجب اختيار صورة او ملف بصيغة png,jpg,jpeg,PNG,JPG,JPEG'));
    }

    // If there is an error or the user cancels, return null
    return null;
  }

  String extractErrors(dynamic errorData) {
    if (errorData == null) return 'حدث خطأ ما مراجعة البيانات';

    if (errorData is! Map<String, dynamic>) {
      return errorData.toString();
    }

    // 1. Check if 'errors' exists and is a map (typical Laravel structure)
    final errorsMap = errorData['errors'] as Map<String, dynamic>?;
    if (errorsMap != null && errorsMap.isNotEmpty) {
      final errorMessages = <String>[];

      // Iterate through each field and collect its error messages
      errorsMap.forEach((field, messages) {
        if (messages is List && messages.isNotEmpty) {
          final formattedMessages =
              messages.map((msg) => msg.toString()).join('\n');
          errorMessages.add(formattedMessages);
        } else if (messages is String) {
          errorMessages.add(messages);
        }
      });

      if (errorMessages.isNotEmpty) {
        return errorMessages.join('\n');
      }
    }

    // 2. Check for top-level 'message' field
    if (errorData['message'] != null &&
        errorData['message'].toString().isNotEmpty) {
      return errorData['message'].toString();
    }

    // 3. Fallback to a generic error message
    return 'حدث خطأ ما مراجعة البيانات';
  }

  void changeObsecure() {
    isObsecure = !isObsecure;
    emit(const SignUpState.changeScreenValues());
  }
}
