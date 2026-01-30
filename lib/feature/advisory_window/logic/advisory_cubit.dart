import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_lawyer_section/models/service_request.dart';

import '../../my_appointments/data/model/working_hours_response.dart';
import '../data/model/advisories_accurate_specialization.dart';
import '../data/model/advisories_categories_types.dart';
import '../data/model/advisories_general_specialization.dart';
import '../data/model/advisory_request_response.dart';
import '../data/model/all_advirsory_response.dart';
import '../data/model/available_lawyers_for_advisory_type_model.dart' as lawyer;
import '../data/repo/advisory_repo.dart';

part 'advisory_state.dart';

class AdvisoryCubit extends Cubit<AdvisoryState> {
  final AdvisoryRepo _advisoryRepo;
  int currentStep = 0;
  int selectedAdvisoryType = 0;
  bool isNeedAppointment = true;
  int selectedGeneralType = 0;
  int selectedAccurateType = 0;
  SubCategory? selectedAccurateData;
  lawyer.Datum? selectedLawyer;

  LevelElement? selectedLevel;

  bool _generalTypesLoaded = false;
  bool _accurateTypesLoaded = false;

  AdvisoryCubit(this._advisoryRepo) : super(AdvisoryInitial());

  void nextStep() {
    if (currentStep < 6) {
      currentStep++;
      emit(AdvisoryStepChanged(currentStep));
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      if (currentStep == 2) {
        _accurateTypesLoaded = false;
      } else if (currentStep == 1) {
        _generalTypesLoaded = false;
      } else if (currentStep == 3) {
        selectedLevel = null;
        selectedAccurateData = null;
      }
      currentStep--;
      emit(AdvisoryStepChanged(currentStep));
    }
  }

  void resetSteps() {
    currentStep = 0;
    selectedAdvisoryType = 0;
    isNeedAppointment = true;
    selectedGeneralType = 0;
    selectedAccurateType = 0;
    selectedAccurateData = null;
    selectedLawyer = null;
    selectedLevel = null;
    advisoriesCategoriesTypes = null;
    advisoriesGeneralSpecialization = null;
    advisoriesAccurateSpecialization = null;
    availableDatesResponse = null;
    requestResponse = null;
    requestData = FormData();
    imagesDocs = [];
    recordPath = null;
    selectedDate = null;
    selectedFrom = null;
    selectedTo = null;
    description = null;
    subPriceId = null;
    _generalTypesLoaded = false;
    _accurateTypesLoaded = false;
    emit(AdvisoryStepChanged(currentStep));
  }

  AdvisoriesCategoriesTypes? advisoriesCategoriesTypes;

  void getAdvisoriesTypes() async {
    emit(AdvisoryTypesLoading());
    final result = await _advisoryRepo.getAdvisoriesTypes();
    result.when(
      success: (data) {
        advisoriesCategoriesTypes = data;
        emit(AdvisoryTypesLoaded(data));
      },
      failure: (error) {
        emit(AdvisoryTypesError(error));
      },
    );
  }

  void advisoryLawyersById(String serviceId, String importanceId) {
    emit(AdvisoryTypeLawyersLoading());
    _advisoryRepo.advisoryLawyersById(importanceId, serviceId).then((result) {
      result.when(
        success: (data) {
          emit(AdvisoryTypeLawyersLoaded(data));
        },
        failure: (error) {
          emit(AdvisoryTypeLawyersError(error));
        },
      );
    });
  }

  AdvisoriesGeneralSpecialization? advisoriesGeneralSpecialization;

  void getGeneralTypesByAdvisoryId(String advisoryTypeId) async {
    emit(AdvisoryGeneralTypesLoading());
    
    try {
      final result = await _advisoryRepo.getGeneralTypesByAdvisoryId(advisoryTypeId);
      result.when(
        success: (data) {
          advisoriesGeneralSpecialization = data;
          emit(AdvisoryGeneralTypesLoaded(data));
        },
        failure: (error) {
          emit(AdvisoryGeneralTypesError(error));
        },
      );
    } catch (e) {
      emit(AdvisoryGeneralTypesError(e));
    }
  }

  AdvisoriesAccurateSpecialization? advisoriesAccurateSpecialization;

  void getAccurateTypesByGeneralAndAdvisoryId(String advisoryTypeId, String generalTypeId) async {
    emit(AdvisoryAccurateTypesLoading());
    advisoriesAccurateSpecialization = null; // Reset previous data
    
    try {
      final result = await _advisoryRepo.getAccurateTypesByGeneralAndAdvisoryId(
        advisoryTypeId,
        generalTypeId,
      );
      
      result.when(
        success: (data) {
          advisoriesAccurateSpecialization = data;
          emit(AdvisoryAccurateTypesLoaded(data));
        },
        failure: (error) {
          emit(AdvisoryAccurateTypesError(error));
        },
      );
    } catch (e) {
      emit(AdvisoryAccurateTypesError(e));
    }
  }

  WorkingHoursResponse? availableDatesResponse;

  void getAvailableTimes(String lawyerId) async {
    emit(AdvisorDatesLoading());
    final result = await _advisoryRepo.getWorkingHours(15, lawyerId);
    result.when(
      success: (data) {
        availableDatesResponse = data;
        emit(AdvisorDatesLoaded());
      },
      failure: (error) {
        emit(AdvisorDatesError(error));
      },
    );
  }

  AdvisoryRequestResponse? requestResponse;

  Future<void> createAdvisoryRequest(FormData newRequestData) async {
    emit(AdvisorReservationLoading());
    try {
      final response = await _advisoryRepo.createAppointment(newRequestData);
      response.when(
        success: (data) {
          requestResponse = data;
          emit(AdvisorReservationLoaded(data));
        },
        failure: (error) {
          emit(AdvisorReservationError(error));
        },
      );
    } catch (e) {
      emit(AdvisorReservationError("error"));
    }
  }

  FormData requestData = FormData();
  List<PlatformFile> imagesDocs = [];
  String? recordPath;
  String? selectedDate;
  String? selectedFrom;
  String? selectedTo;
  String? description;
  String? subPriceId;

  void saveRequest(Map<String, Object?> map) async {
    // Create a new FormData instance and copy existing fields
    FormData newRequestData = FormData();
    newRequestData.fields.addAll(requestData.fields);

    newRequestData.fields
        .add(MapEntry("sub_price_id", map["level"].toString()));
    newRequestData.fields
        .add(MapEntry("description", map["details"] as String));
    description = map["details"] as String;
    // Create new MultipartFile instances for each file
    if (map["files"] != null) {
      imagesDocs = map["files"] as List<PlatformFile>;
      List<PlatformFile> images = map["files"] as List<PlatformFile>;
      for (int i = 0; i < images.length; i++) {
        newRequestData.files.add(MapEntry(
          "files[$i]",
          await MultipartFile.fromFile(images[i].path!,
              filename: images[i].name),
        ));
      }
    }

    // Create new MultipartFile instance for the recording
    if (map["recording"] != null || map["recording"] != "") {
      recordPath = map["recording"] as String;
      // print("recording path: $recordPath");
      if (recordPath != null && recordPath!.isNotEmpty) {
        newRequestData.files.add(MapEntry(
          "voice_file",
          await MultipartFile.fromFile(recordPath!, filename: "recording"),
        ));
      }
    }

    // Update the requestData with the new instance
    requestData = newRequestData;
  }

  void addTimeAndDateToRequest(String date, String from, String to) {
    requestData.fields.add(MapEntry("date", date));
    requestData.fields.add(MapEntry("from", from));
    requestData.fields.add(MapEntry("to", to));
    selectedDate = date;
    selectedFrom = from;
    selectedTo = to;
    // print(requestData.fields);
    // print(requestData.files);
  }

  // orders

  AllAdvisoryResponse? advisoriesResponseYmtaz;
  AllAdvisoryResponse? advisoriesResponseDigital;

  getAdvisories() async {
    getAdvisoriesFromYmtaz();
    getAdvisoriesFromDigitalGuide();
  }

  Future<void> getAdvisoriesFromYmtaz() async {
    emit(LoadingMyReservation());
    try {
      final response = await _advisoryRepo.getAdvisoriesFromYmtaz();
      response.when(
        success: (data) {
          advisoriesResponseYmtaz = data;
          emit(LoadedMyReservation());
        },
        failure: (error) {
          emit(ErrorMyReservation(error));
        },
      );
    } catch (e) {
      emit(ErrorMyReservation("error"));
    }
  }

  Future<void> getAdvisoriesFromDigitalGuide() async {
    emit(LoadingMyReservation());
    try {
      final response = await _advisoryRepo.getAdvisoriesFromDigital();
      response.when(
        success: (data) {
          advisoriesResponseDigital = data;
          emit(LoadedMyReservation());
        },
        failure: (error) {
          emit(ErrorMyReservation(error));
        },
      );
    } catch (e) {
      emit(ErrorMyReservation("error"));
    }
  }

  void sendServiceRequests(List<BaseServiceRequest> serviceRequests) {
    
  }
}
