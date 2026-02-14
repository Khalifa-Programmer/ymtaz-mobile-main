import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_category_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_payment_types.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_request_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/all_advirsory_response.dart';
import 'package:yamtaz/feature/advisory_services/data/repos/advisor_repo.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';
import 'package:yamtaz/feature/layout/account/data/models/advisory_services_types_response.dart';

import '../../my_appointments/data/model/working_hours_response.dart';
import '../data/model/advisory_main_category_response.dart';

class AdvisorCubit extends Cubit<AdvisorState> {
  final AdvisorRepo _advisorRepo;

  AdvisorCubit(this._advisorRepo) : super(const AdvisorState.initial());

  AdvisoryPaymentsResponse? paymentsResponse;
  AdvisoryServicesTypesResponse? typesResponse;

  int selectedTypeIndex = -1;

  // void selectType(int index) {
  //   selectedTypeIndex = index;
  //   emit(AdvisorState.selectedType(index));
  // }

  void getData() {
    if (typesResponse == null ||
        paymentsResponse == null ||
        mainCategoryResponse == null) {
      getMainCategories();
    }
  }

  void getMyServices() {
    if (mainCategoryResponse == null) {
      getMainCategories();
    }
  }

  // get main categories
  AdvisoryMainCategory? mainCategoryResponse;

  Future<void> getMainCategories() async {
    emit(const AdvisorState.loadingMainCategory());
    try {
      final response = await _advisorRepo.getMainCategories();
      response.when(
        success: (data) {
          mainCategoryResponse = data;
          emit(AdvisorState.sucessLoadMainCategory(data));
        },
        failure: (error) {
          emit(AdvisorState.errorLoadMainCategory(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorLoadMainCategory("error while store data"));
    }
  }

  // get advisories
  AllAdvisoryResponse? advisoriesResponseYmtaz;
  AllAdvisoryResponse? advisoriesResponseDigital;

   Future<void> getAdvisories() async {
     getAdvisoriesFromYmtaz();
     getAdvisoriesFromDigitalGuide();
  }

  Future<void> getAdvisoriesFromYmtaz() async {
    emit(const AdvisorState.loadingMyReservation());
    try {
      final response = await _advisorRepo.getAdvisoriesFromYmtaz();
      response.when(
        success: (data) {
          advisoriesResponseYmtaz = data;
          emit(AdvisorState.sucessMyReservation(data));
        },
        failure: (error) {
          emit(AdvisorState.errorMyReservation(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorMyReservation("error"));
    }
  }
  Future<void> getAdvisoriesFromDigitalGuide() async {
    emit(const AdvisorState.loadingMyReservation());
    try {
      final response = await _advisorRepo.getAdvisoriesFromDigital();
      response.when(
        success: (data) {
          advisoriesResponseDigital = data;
          emit(AdvisorState.sucessMyReservation(data));
        },
        failure: (error) {
          emit(AdvisorState.errorMyReservation(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorMyReservation("error"));
    }
  }



  AdvisoryRequestResponse? requestResponse;

  Future<void> createAppointment(FormData data) async {
    emit(const AdvisorState.loadingReservation());
    try {
      final response = await _advisorRepo.createAppointment(data);
      response.when(
        success: (data) {
          requestResponse = data;
          emit(AdvisorState.sucessReservation(data));
        },
        failure: (error) {
          emit(AdvisorState.errorReservation(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorReservation("error"));
    }
  }

  Future<void> createAppointmentWithLawyer(FormData data) async {
    emit(const AdvisorState.loadingReservation());
    try {
      final response = await _advisorRepo.createAppointmentWithLawyer(data);
      response.when(
        success: (data) {
          requestResponse = data;
          emit(AdvisorState.sucessReservation(data));
        },
        failure: (error) {
          emit(AdvisorState.errorReservation(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorReservation("error"));
    }
  }

  Future<void> getTypesAndPaymentTypes(String id) async {
    if (typesResponse != null || paymentsResponse != null) {
      paymentsResponse = null;
      typesResponse = null;
      sectionsResponse = null;
    }
    emit(const AdvisorState.loadingTypes());
    try {
      final payments = await _advisorRepo.getPaymentTypesById(id);
      // final types = await _advisorRepo.getTypes();
      // types.when(
      //   success: (data) {
      //     typesResponse = data;
      //     emit(AdvisorState.sucessLoadTypes(data));
      //   },
      //   failure: (error) {
      //     emit(AdvisorState.errorLoadTypes(error));
      //   },
      // );
      payments.when(
        success: (data) {
          paymentsResponse = data;
          emit(AdvisorState.sucessLoadTypes(data));
        },
        failure: (error) {
          emit(AdvisorState.errorLoadTypes(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorLoadTypes("error"));
    }
  }

  // getSections
  AdvisoryCateogryResponse? sectionsResponse;

  Future<void> getSections(String id) async {
    emit(const AdvisorState.loadingSections());
    try {
      final sections = await _advisorRepo.getSections(id);
      sections.when(
        success: (data) {
          sectionsResponse = data;
          emit(AdvisorState.sucessLoadSections(data));
        },
        failure: (error) {
          emit(AdvisorState.errorLoadSections(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorLoadSections("error"));
    }
  }
  WorkingHoursResponse ? availableDatesResponse;

  void getAvailableTimes([String ? lawyerId]) async {
    emit(const AdvisorState.loading());
    final result = await _advisorRepo.getWorkingHours( 15 , lawyerId);
    result.when(
      success: (data) {
        availableDatesResponse = data;
        emit(AdvisorState.loaded(data));
      },
      failure: (error) {
        emit(AdvisorState.error(error));
      },
    );
  }



  Future<void> getTypes(String id) async {
    emit(const AdvisorState.loadingSections());
    try {
      final sections = await _advisorRepo.getTypes(id);
      sections.when(
        success: (data) {
          typesResponse = data;
          emit(AdvisorState.sucessLoadSections(data));
        },
        failure: (error) {
          emit(AdvisorState.errorLoadSections(error));
        },
      );
    } catch (e) {
      emit(const AdvisorState.errorLoadSections("error"));
    }
  }

  void clearData() {
    sectionsResponse = null;
    paymentsResponse = null;
    typesResponse = null;
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
          // 'PDF'
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
          return null;
        }

        // You can now use the pickedFile as needed

        // You can return the file if needed
        // return pickedFile;
      } else {}
    } catch (e) {}

    // If there is an error or the user cancels, return null
    return null;
  }
}
