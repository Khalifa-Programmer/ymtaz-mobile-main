import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/nationalities_response.dart';
import 'package:yamtaz/feature/layout/account/data/repos/my_account_repo.dart';

import '../../../../core/router/routes.dart';
import '../../../auth/login/data/models/login_provider_response.dart';
import 'my_account_state.dart';

class MyAccountCubit extends Cubit<MyAccountState> {
  final MyAccountRepo _myAccountRepo;

  String? countryCodeSelected;

  MyAccountCubit(this._myAccountRepo) : super(const MyAccountState.initial());

  TextEditingController removeAccountController = TextEditingController();
  TextEditingController removeAccountDevController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  //get provider
  LoginProviderResponse? userDataResponse;

  void loading() {
    var userType = CacheHelper.getData(key: 'userType');
    if (userDataResponse == null && userType == 'provider') {
      getProviderData();
    } else if (clientProfile == null && userType == 'client') {
      getClientData();
    }
  }

  // add provider work experience
  Future<void> addMyWorkExperience(
      List<Map<String, dynamic>> experience) async {
    emit(const MyAccountState.loadingGetAccountExperience());

    try {
      // Define the date formatter
      final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en');

      // Prepare the request body
      final List<Map<String, dynamic>> requestBody = experience.map((exp) {
        // Parse and format 'from' and 'to' fields
        return {
          "title": exp['title'],
          "company": exp['company'],
          "from": formatter.format(DateTime.parse(exp['from'])),
          // Ensure 'from' is formatted
          if (exp['to'] != null)
            "to": formatter.format(DateTime.parse(exp['to'])),
          // Format 'to' if it exists
        };
      }).toList();

      // Log the request body for debugging
      print("Request Body: $requestBody");

      // Send the API request
      final response = await _myAccountRepo.addMyWorkExperience(requestBody);

      response.when(
        success: (responseModel) {
          emit(MyAccountState.successGetAccountExperience(responseModel));
          getMyWorkExperience(); // Reload experiences after adding
        },
        failure: (fail) {
          emit(MyAccountState.errorGetAccountExperience(
            error: extractErrors(fail['data']),
          ));
        },
      );
    } catch (e) {
      emit(MyAccountState.errorGetAccountExperience(error: e.toString()));
    }
  }

  // get provider work experience
  Future<void> getMyWorkExperience() async {
    emit(const MyAccountState.loadingGetAccountExperience());
    final response = await _myAccountRepo.getMyWorkExperience();
    response.when(success: (responseModel) {
      emit(MyAccountState.successGetAccountExperience(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorGetAccountExperience(
          error: extractErrors(fail['data'])));
    });
  }

  Future<void> getPayments() async {
    emit(const MyAccountState.loadingPaymentsDone());
    final response = await _myAccountRepo.getPayments();
    response.when(success: (responseModel) {
      emit(MyAccountState.successPaymentsDone(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorPaymentsDone(error: fail['message'].toString()));
    });
  }

  // ADD IBAN
  Future<void> addIban(FormData iban) async {
    emit(const MyAccountState.loadingGetPayoutIban());
    final response = await _myAccountRepo.addIban(iban);
    response.when(success: (responseModel) {
      emit(MyAccountState.successGetPayoutIban(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorGetPayoutIban(
          error: extractErrors(fail['data'])));
    });
  }

  // get iban
  Future<void> getIban() async {
    emit(const MyAccountState.loadingGetPayoutIban());
    final response = await _myAccountRepo.getIban();
    response.when(success: (responseModel) {
      emit(MyAccountState.successGetPayoutIban(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorGetPayoutIban(
          error: extractErrors(fail['data'])));
    });
  }

  Future<void> validatePhone(String phone, String ccode) async {
    emit(const MyAccountState.loadingSignUpProviderOtp());
    final response = await _myAccountRepo.validatePhone(phone, ccode);
    response.when(success: (responseModel) {
      emit(MyAccountState.successSignUpProviderOtp(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorSignUpProviderOtp(
          error: extractErrors(fail['data'])));
    });
  }

  Future<void> getInvitations() async {
    emit(const MyAccountState.loadingInvitations());
    final response = await _myAccountRepo.getInvitations();
    response.when(success: (data) {
      emit(MyAccountState.successInvitations(data));
    }, failure: (error) {
      emit(MyAccountState.errorInvitations(error: error.toString()));
    });
  }

  Future<void> inviteUser(Map<String, String> data) async {
    emit(const MyAccountState.loadingSendInvite());
    final response = await _myAccountRepo.sendInvitation(data);

    response.when(success: (data) {
      emit(MyAccountState.successSendInvite(data));
      getit<MyAccountCubit>().getInvitations();
    }, failure: (error) {
      emit(MyAccountState.errorSendInvite(error: extractErrors(error['data'])));

      getit<MyAccountCubit>().getInvitations();
    });
  }

  Future<void> verifyPhoneOtp(String phone, String ccode, String code) async {
    emit(const MyAccountState.loadingSignUpProviderOtpEdit());
    final response = await _myAccountRepo.verifyPhoneOtp(phone, ccode, code);
    response.when(success: (responseModel) {
      emit(MyAccountState.successSignUpProviderOtpEdit(responseModel));
    }, failure: (fail) {
      emit(MyAccountState.errorSignUpProviderOtpEdit(
          error: fail['message'].toString()));
    });
  }

  Future<void> refresh() async {
    var userType = CacheHelper.getData(key: 'userType');

    if (userType == 'provider') {
      await getProviderData();
    } else if (userType == 'c') {
      // await getClientData();
    }
  }

  Future<void> getProviderData() async {
    emit(const MyAccountState.loadingGetProvider());
    final result = await _myAccountRepo.getProviderData();
    result.when(
      success: (data) {
        userDataResponse = data;
        emit(MyAccountState.successGetProvider(data));
      },
      failure: (error) {
        emit(MyAccountState.errorGetProvider(error: error.toString()));
      },
    );
  }

  //remove account
  Future<void> removeAccount() async {
    emit(const MyAccountState.loadingRemoveAccount());
    FormData data = FormData.fromMap({
      "delete_reason": removeAccountController.text,
      "development_proposal": removeAccountDevController.text,
    });
    final result = await _myAccountRepo.removeAccount(data);
    result.when(
      success: (data) {
        emit(MyAccountState.successRemoveAccount(data));
      },
      failure: (error) {
        emit(MyAccountState.errorRemoveAccount(error: error.toString()));
      },
    );
  }

  //remove account
  Future<void> removeAccountProvider() async {
    emit(const MyAccountState.loadingRemoveAccount());
    FormData data = FormData.fromMap({
      "delete_reason": removeAccountController.text,
      "development_proposal": removeAccountDevController.text,
    });
    final result = await _myAccountRepo.removeAccountProvider(data);
    result.when(
      success: (data) {
        emit(MyAccountState.successRemoveAccount(data));
      },
      failure: (error) {
        emit(MyAccountState.errorRemoveAccount(error: error.toString()));
      },
    );
  }

  // sign out provider

  void signOut(BuildContext context) {
    CacheHelper.removeData(key: 'token');
    CacheHelper.removeData(key: 'userType');
    context.pushNamedAndRemoveUntil(Routes.login, predicate: (route) => false);
  }

  //get client data
  LoginProviderResponse? clientProfile;

  Future<void> getClientData() async {
    emit(const MyAccountState.loadingGetClient());
    final result = await _myAccountRepo.getClientData();
    result.when(
      success: (data) {
        clientProfile = data;

        emit(MyAccountState.successGetClient(data));
      },
      failure: (error) {
        emit(MyAccountState.errorGetClient(error: error.toString()));
      },
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  CountriesResponse? countries;
  NationalitiesResponse? nationalities;
  Nationality? targetNationality;

  Country? targetCountry;

  Region? targetRegion;

  City? targetCity;

  Position? currentPositionUser;

  Map<String, int> accountType = {
    'فرد': 1,
    'مؤسسة': 2,
    'شركة': 3,
    'جهة حكومية': 4,
    'هيئة': 5,
  };
  int accountTypeValue = -1;
  String accountTypeValueName = "";

  Future<void> loadApiData() async {
    try {
      List<ApiResult<dynamic>> results =
          await _myAccountRepo.fetchAllDataRequest();

      for (ApiResult<dynamic> result in results) {
        result.when(
          success: (data) {
            if (data is CountriesResponse) {
              countries = data;
            } else if (data is NationalitiesResponse) {
              nationalities = data;
            }
          },
          failure: (error) {},
        );
      }
    } catch (error) {}
  }

  Map<String, String> gender = {
    'ذكر': "Male",
    'أنثى': "Female",
  };
  String? targetGender;
  String selectedGender = '';
  String targetPhoneCode = '';
  int selectedNationality = -1;
  int selectedCountry = -1;
  int selectedRegion = -1;
  int selectedDistricts = -1;
  int selectedCountryPhoneCode = -1;

  loadClientData() async {
    await loadApiData();
    clientProfile = getit<MyAccountCubit>().clientProfile;

    phoneController.text = clientProfile!.data!.account!.phone ?? '';
    emailController.text = clientProfile!.data!.account!.email ?? '';
    nameController.text = clientProfile!.data!.account!.name ?? '';
    countryCodeSelected =
        clientProfile!.data!.account!.phoneCode.toString() ?? '';
    accountTypeValue = clientProfile!.data!.account!.type ?? -1;

    accountTypeValueName = getAccountTypeKeyById(accountTypeValue) ?? '';

    print(accountTypeValue);

    Map<String, String> reversedGenderMap = Map.fromEntries(
        gender.entries.map((entry) => MapEntry(entry.value, entry.key)));

    // print(reversedGenderMap[clientProfile!.data!.account!.gender]);

    targetGender = clientProfile!.data!.account!.gender == null
        ? null
        : reversedGenderMap[clientProfile!.data!.account!.gender!]!;
    selectedGender = clientProfile!.data!.account!.gender ?? '';

    selectedCountry = clientProfile!.data!.account!.country?.id ?? -1;

    if (selectedCountry != -1) {
      targetCountry = getCountryById(selectedCountry);
      regions = getRegionsByCountryId(selectedCountry);
      selectedRegion = clientProfile!.data!.account!.region?.id ?? -1;
      targetRegion = getRegionById(selectedRegion);
      selectedDistricts = clientProfile!.data!.account!.city?.id ?? -1;
    }

    selectedNationality = clientProfile!.data!.account!.nationality?.id ?? -1;
    targetNationality = getNationalityById(selectedNationality);

    cities = targetRegion?.cities;
    targetCity = getCityById(selectedDistricts);
    if (clientProfile!.data!.account!.latitude != null &&
        clientProfile!.data!.account!.longitude != null) {
      currentPositionUser = Position(
        latitude: double.parse(clientProfile!.data!.account!.latitude!),
        longitude: double.parse(clientProfile!.data!.account!.longitude!),
        altitude: 0,
        accuracy: 0,
        speed: 0,
        speedAccuracy: 0,
        heading: 0,
        headingAccuracy: 0,
        timestamp: DateTime.now(),
        altitudeAccuracy: 0,
      );
    }
    emit(const MyAccountState.loadDataSuccess());
  }

  Future<void> updateClientProfile() async {
    emit(const MyAccountState.loadingEditClient());
    FormData data = FormData.fromMap({
      "name": nameController.text,
      "account_type": "client",
      "email": emailController.text,
      "phone": phoneController.text,
      "gender": selectedGender,
      "phone_code": countryCodeSelected,
      "longitude": currentPositionUser!.longitude.toString(),
      "latitude": currentPositionUser!.latitude.toString(),
      "country_id": selectedCountry,
      "nationality_id": selectedCountry,
      'city_id': selectedDistricts.toString(),
      'region_id': selectedRegion.toString(),
      'type': accountTypeValue,
    });
    if (otpController.text.isNotEmpty) {
      data.fields.add(MapEntry('otp', otpController.text));
    }

    final result = await _myAccountRepo.updateClientData(data);
    result.when(
      success: (data) {
        getit<MyAccountCubit>().getClientData();

        emit(MyAccountState.successEditClient(data));
      },
      failure: (error) {
        emit(MyAccountState.errorEditClient(
            error: extractErrors(error['data'])));
      },
    );
  }

  String extractErrors(Map<String, dynamic> errorData) {
    // Check if 'errors' exists and is a map
    final errorsMap = errorData['errors'] as Map<String, dynamic>?;
    if (errorsMap == null || errorsMap.isEmpty) {
      return 'حدث خطأ ما راجع البيانات';
    }

    final errorMessages = <String>[];

    // Iterate through each field and collect its error messages
    errorsMap.forEach((field, messages) {
      if (messages is List && messages.isNotEmpty) {
        final formattedMessages =
            messages.map((msg) => msg.toString()).join('\n');
        errorMessages.add(formattedMessages);
      }
    });

    // If no error messages were extracted, return a generic error message
    if (errorMessages.isEmpty) {
      return 'حدث خطأ ما  راجع البيانات';
    }

    // Join all extracted error messages into a single string
    return errorMessages.join('\n');
  }

  void selectDistricts(int cityId) {
    selectedDistricts = cityId;
    emit(const MyAccountState.loadDataSuccess());
  }

  void selectCounrty(List<Region> data, int countryId, int phoneCode) {
    selectedDistricts = -1;
    selectedRegion = -1;
    selectedCountryPhoneCode = phoneCode;
    selectedCountry = countryId;
    regions = data;
    cities = [];
    emit(const MyAccountState.loadDataSuccess());
  }

  List<Region>? regions = [];
  List<City>? cities = [];

  void selectRegion(List<City> data, int redgionId) {
    selectedRegion = redgionId;
    cities = [];
    cities = data;
    targetCity = null;
    emit(const MyAccountState.loadDataSuccess());
  }

  Nationality? getNationalityById(int? countryId) {
    if (countryId == null ||
        countries == null ||
        countries!.data?.countries == null ||
        countryId == -1) {
      return null; // Return null if any necessary parameter is null
    } else {
      try {
        return nationalities!.data!.nationalities!.firstWhere(
          (country) => country.id == countryId,
        );
      } catch (e) {
        return null;
      }
    }
  }

  Country? getCountryById(int? countryId) {
    if (countryId == null ||
        countries == null ||
        countries!.data?.countries == null ||
        countryId == -1) {
      return null; // Return null if any necessary parameter is null
    } else {
      return countries!.data!.countries!.firstWhere(
        (country) => country.id == countryId,
      );
    }
  }

  List<Region>? getRegionsByCountryId(int? countryId) {
    if (countryId == null ||
        countries == null ||
        countries!.data?.countries == null) {
      return null; // Return null if any necessary parameter is null
    } else {
      try {
        Country? country = countries!.data!.countries!.firstWhere(
          (country) => country.id == countryId,
        );

        return country.regions;
      } catch (e) {
        return null;
      }
    }
  }

  Region? getRegionById(int? regionId) {
    if (regionId == null || regions == null || regionId == -1) {
      return null; // Return null if any necessary parameter is null
    } else {
      try {
        return regions!.firstWhere(
          (region) => region.id == regionId,
        );
      } catch (e) {
        return null;
      }
    }
  }

  City? getCityById(int? cityId) {
    if (cityId == null || regions == null || cityId == -1) {
      return null; // Return null if any necessary parameter is null
    } else {
      try {
        return regions!
            .expand((region) => region.cities ?? [])
            .firstWhere((city) => city.id == cityId, orElse: () => null);
      } catch (e) {
        return null;
      }
    }
  }

  // send fcm token
  Future<void> sendFcmToken() async {
    emit(const MyAccountState.loadingSendFcmToken());
    final messaging = FirebaseMessaging.instance;
    try {
      String? token = await messaging.getToken();
      if (token == null) {
        throw Exception("Failed to retrieve FCM token");
      }

      final result = await _myAccountRepo.sendFcmToken();
      result.when(
        success: (data) {
          emit(const MyAccountState.successSendFcmToken());
        },
        failure: (error) {
          emit(MyAccountState.errorSendFcmToken(error: error.toString()));
        },
      );
    } catch (e) {
      emit(MyAccountState.errorSendFcmToken(error: e.toString()));
    }
  }

  Future<void> deleteFcmToken(String token) async {
    emit(const MyAccountState.loadingSendFcmToken());

    final result = await _myAccountRepo.deleteFcmToken(token);
    result.when(
      success: (data) {
        emit(const MyAccountState.successSendFcmToken());
      },
      failure: (error) {
        emit(MyAccountState.errorSendFcmToken(error: error.toString()));
      },
    );
  }

  String? getAccountTypeKeyById(int id) {
    try {
      return accountType.entries.firstWhere((entry) => entry.value == id).key;
    } catch (e) {
      return null; // Return null if the ID is not found
    }
  }

  // get points rules
  Future<void> getPointsRules() async {
    emit(const MyAccountState.loadingGetProvider());
    final result = await _myAccountRepo.getPointsRules();
    result.when(
      success: (data) {
        emit(MyAccountState.successPointsRules(data));
      },
      failure: (error) {
        emit(MyAccountState.errorPointsRules(error: error.toString()));
      },
    );
  }
}
