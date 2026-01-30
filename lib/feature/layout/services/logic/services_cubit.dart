import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yamtaz/feature/layout/services/data/model/my_services_requests_response.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart'
    as services;
import 'package:yamtaz/feature/layout/services/data/repos/services_repo.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesRepo _servicesRepo;

  var formKey = GlobalKey<FormState>();

  ServicesCubit(this._servicesRepo) : super(const ServicesState.initial());

  /// new code
  services.Item? selectedMainType;
  services.Service? selectedSubService;
  services.YmtazLevelsPrice? selectedLevel;
  FormData requestData = FormData();

  List<Lawyer>? cachedLawyers;

  void loadServicesData() {
    // var userType = CacheHelper.getData(key: 'userType');
    if (servicesRequirementsResponse == null) {
      loadServices();
    }
  }

  services.ServicesRequirementsResponse? servicesRequirementsResponse;

  void loadServices() {
    emit(const ServicesState.loadingServices());
    _servicesRepo.getServices().then((result) {
      result.when(
        success: (data) {
          servicesRequirementsResponse = data;
          emit(ServicesState.loadedServices(data));
        },
        failure: (error) {
          emit(ServicesState.errorServices(error));
        },
      );
    });
  }

  //serviceLawyersById

  void serviceLawyersById(String serviceId, String importanceId) {
    emit(const ServicesState.serviceLawyersByIdLoading());
    _servicesRepo.serviceLawyersById(importanceId, serviceId).then((result) {
      result.when(
        success: (data) {
          emit(ServicesState.serviceLawyersByIdSuccess(data));
        },
        failure: (error) {
          emit(ServicesState.serviceLawyersByIdError(error));
        },
      );
    });
  }

  void requestService(FormData data) {
    emit(const ServicesState.requestService());
    _servicesRepo.servicesRequest(data).then((result) {
      result.when(
        success: (data) {
          emit(ServicesState.requestServiceSuccess(data));
        },
        failure: (error) {
          emit(ServicesState.requestServiceError(error['message']));
        },
      );
    });
  }

  void getServicesDataFirst() {
    // var userType = CacheHelper.getData(key: 'userType');
    // if (myServicesRequestResponse == null && userType != "guest") {
    getMyServicesRequestOffers();
    // }
  }

  // get services from api
  MyServicesRequestsResponse? myServicesRequestResponse;

  void getMyServicesRequestOffers() {
    print("loadServices");

    myServicesRequestResponse = null;
    emit(const ServicesState.getServices());
    _servicesRepo.getMyServicesRequestOffers().then((result) {
      result.when(
        success: (data) {
          myServicesRequestResponse = data;
          emit(ServicesState.getServicesSuccess(data));
        },
        failure: (error) {
          emit(ServicesState.getServicesError(error));
        },
      );
    });
  }

  void myServicesClientOffersRespond(FormData data) {
    myServicesRequestResponse = null;
    emit(const ServicesState.respondToOffer());
    _servicesRepo.myServicesClientOffersRespond(data).then((result) {
      result.when(
        success: (data) {
          emit(ServicesState.respondToOfferSuccess(data));
        },
        failure: (error) {
          emit(ServicesState.respondToOfferError(error));
        },
      );
    });
  }

  // void selectServideItemLawer(LawyerService service, List<LawyerPrice> levels) {
  //   selectedServiceLawyer = service;
  //   selectedServicePriceLawyer = levels;
  //   selectedServiceId = service.serviceId!;
  //   emit(const ServicesState.selectedServiceItem());
  // }

  void selectServideItem(
      services.Service service, List<services.YmtazLevelsPrice> levels) {
    selectedSubService = service;
    emit(const ServicesState.selectedServiceItem());
  }

  // void selectPeriority(int index) {
  //   selectedPriority = index;
  //   emit(const ServicesState.changeServicePrice());
  // }

  // void uploadDocument() async {
  //   documentFile = await pickFile();
  //   emit(const ServicesState.changeServicePrice());
  // }
  //
  // void deleteDocument() {
  //   documentFile = null;
  //   emit(const ServicesState.changeServicePrice());
  // }
  //
  // Future<File?> pickFile() async {
  //   try {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: [
  //         'pdf',
  //         'png',
  //         'JPEG',
  //         'JPG',
  //         'jpg',
  //         'jpeg',
  //         'PNG',
  //         // 'PDF'
  //       ],
  //       allowMultiple: false,
  //     );
  //
  //     if (result != null && result.files.isNotEmpty) {
  //       PlatformFile file = result.files.first;
  //       File pickedFile = File(file.path!);
  //
  //       // if (file.size! > (5 * 1024 * 1024)) { // 5 MB limit as an example
  //       //   emit(const SignUpState.errorImage(
  //       //       error: 'File size exceeds the allowed limit (5 MB).'));
  //       //   print("object");
  //       //   return null;
  //       // }
  //
  //       String fileExtension = extension(pickedFile.path);
  //       if (fileExtension == '.png' ||
  //           fileExtension == '.jpg' ||
  //           fileExtension == '.jpeg' ||
  //           fileExtension == '.PNG' ||
  //           fileExtension == '.JPG' ||
  //           fileExtension == '.JPEG' ||
  //           fileExtension == '.pdf') {
  //         return pickedFile;
  //       } else {
  //         return null;
  //       }
  //
  //       // You can now use the pickedFile as needed
  //
  //       // You can return the file if needed
  //       // return pickedFile;
  //     } else {}
  //   } catch (e) {}
  //
  //   // If there is an error or the user cancels, return null
  //   return null;
  // }

  void resetData() {
    selectedMainType = null;
    selectedSubService = null;
    selectedLevel = null;
    requestData = FormData();
    cachedLawyers = null;
    servicesRequirementsResponse = null;
    myServicesRequestResponse = null;
    emit(const ServicesState.initial());
  }
}
