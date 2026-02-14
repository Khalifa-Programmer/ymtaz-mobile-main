import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_available_types_response.dart'
    as advisory;
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_from_client_response.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_ymtaz_response_model.dart'
    as services;
import 'package:yamtaz/feature/digital_office/data/models/work_days_and_times.dart';
import 'package:yamtaz/feature/digital_office/data/models/work_time_request_model.dart';
import 'package:yamtaz/feature/digital_office/data/repo/office_provider_repo.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

import '../data/models/appointment_offers_lawyer.dart' as appOffres;
import '../data/models/appointment_office_reservations_client.dart'
    as appointment;
import '../data/models/lawyer_advisory_requests_responnse.dart';
import '../data/models/lawyer_appointments.dart';
import '../data/models/service_lawyer_offres_response.dart';

class OfficeProviderCubit extends Cubit<OfficeProviderState> {
  OfficeProviderRepo repo;

  OfficeProviderCubit(this.repo) : super(const OfficeProviderState.initial());

  bool isSunday = false;
  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;
  bool isSaturday = false;
  int dayIndexSelected = 0;

  List<Time> workingHours = [];

  //get analysis for products
  MyOfficeResponseModel? myOfficeResponseModel;

  Future<void> getAnalytics() async {
    emit(const OfficeProviderState.loadingAnalytics());
    final result = await repo.getAnalytics();
    result.whenOrNull(
      success: (data) {
        myOfficeResponseModel = data;
        emit(const OfficeProviderState.loadedAnalytics());
      },
      failure: (message) {
        emit(OfficeProviderState.errorAnalytics(message));
      },
    );
  }

  services.ServicesYmtazResponseModel? servicesYmtazResponseModel;

  Future<void> getServices() async {
    emit(const OfficeProviderState.loadingServices());
    final result = await repo.getServicesYmtazToProvider();
    result.whenOrNull(
      success: (data) {
        servicesYmtazResponseModel = data;
        emit(OfficeProviderState.loadedServices(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServices(message));
      },
    );
  }

  LawyerAppointments? datesTypesResponse;

  Future<void> getAppointments() async {
    emit(const OfficeProviderState.loadingAppointmentsTypes());
    final result = await repo.getAppointmentsLawyerTypes();
    result.whenOrNull(
      success: (data) {
        datesTypesResponse = data;
        emit(const OfficeProviderState.loadedAppointmentsTypes());
      },
      failure: (message) {
        emit(OfficeProviderState.errorAppointmentsTypes(message));
      },
    );
  }

  Future<void> getMyClients() async {
    emit(const OfficeProviderState.loadingMyClients());
    String id = getit
        .get<MyAccountCubit>()
        .userDataResponse!
        .data!
        .account!
        .id
        .toString();
    final result = await repo.getMyClients(id);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedMyClients(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorMyClients(message));
      },
    );
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

  List<TextEditingController> textEditingControllers = [];

  Future<void> loadServices() async {
    pendingServicesRequest = null;
    clientOrders = null;
    emit(const OfficeProviderState.loadingServicesRequestFromClients());
    final results = await Future.wait([
      repo.getServicesRequestFromClients(),
      repo.servicesRequestsPending(),
    ]);

    results[0].whenOrNull(
      success: (data) {
        clientOrders = data as ServicesFromClientsResponse;
        emit(OfficeProviderState.loadedServicesRequestFromClients(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServicesRequestFromClients(message));
      },
    );

    results[1].whenOrNull(
      success: (data) {
        pendingServicesRequest = data as ServiceLawyerOffresResponse;
        emit(OfficeProviderState.loadedOffersServicesRequests(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServicesRequestFromClients(message));
      },
    );
  }

  appointment.AppointmentOfficeReservationsClient? appointmentsRequested;
  appOffres.AppointmentOffersLawyer? pendingAppointmentsRequest;

  Future<void> getAppointmentsRequestFromClients() async {
    emit(const OfficeProviderState.loadingAdvisoryServicesRequests());
    final result = await repo.getAppointmentsRequestFromClients();
    result.whenOrNull(
      success: (data) {
        appointmentsRequested = data;
        emit(const OfficeProviderState.loadedAdvisoryServicesRequests());
      },
      failure: (message) {
        emit(OfficeProviderState.errorAdvisoryServicesRequests(message));
      },
    );
  }

  Future<void> loadAppoinemtns() async {
    appointmentsRequested = null;
    pendingAppointmentsRequest = null;
    emit(const OfficeProviderState.loadingServicesRequestFromClients());
    final results = await Future.wait([
      repo.getAppointmentsRequestFromClients(),
      repo.appointmentsRequestsPending(),
    ]);

    results[0].whenOrNull(
      success: (data) {
        appointmentsRequested =
            data as appointment.AppointmentOfficeReservationsClient;
        emit(OfficeProviderState.loadedAppointmentsRequestFromClients(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorAppointmentsRequestFromClients(message));
      },
    );

    results[1].whenOrNull(
      success: (data) {
        pendingAppointmentsRequest = data as appOffres.AppointmentOffersLawyer;
        emit(OfficeProviderState.loadedOffersAppointmentsRequests(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorAppointmentsRequestFromClients(message));
      },
    );
  }

  void loadAdvisory() {
    getAdvisoryRequestFromClients();
  }

  LawyerAdvisoriesRequestsResponnse? clientAdvisory;

  Future<void> getAdvisoryRequestFromClients() async {
    emit(const OfficeProviderState.loadingAdvisoryServicesRequests());
    final result = await repo.getAdvisoryRequestFromClients();
    result.whenOrNull(
      success: (data) {
        clientAdvisory = data;
        emit(const OfficeProviderState.loadedAdvisoryServicesRequests());
      },
      failure: (message) {
        emit(OfficeProviderState.errorAdvisoryServicesRequests(message));
      },
    );
  }

  Future<void> appointmentsRequestsAttend(FormData body, String id) async {
    emit(const OfficeProviderState.loadingStartAppointment());
    final result = await repo.appointmentsRequestsAttend(body, id);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedStartAppointment());
      },
      failure: (message) {
        emit(OfficeProviderState.errorStartAppointment(message['message']));
      },
    );
  }

  // appointmentLawyer.AppointmentOfficeReservationsLawyer ? providerAppoitmentLawyer;

  // get services from clients and reply to them
  ServicesFromClientsResponse? clientOrders;

  // Future<void> getServicesRequestFromClients() async {
  //   emit(const OfficeProviderState.loadingServicesRequestFromClients());
  //   final result = await repo.getServicesRequestFromClients();
  //   result.whenOrNull(
  //     success: (data) {
  //       clientOrders = data;
  //       emit(OfficeProviderState.loadedServicesRequestFromClients(data));
  //     },
  //     failure: (message) {
  //       emit(OfficeProviderState.errorServicesRequestFromClients(message));
  //     },
  //   );
  // }
  ServiceLawyerOffresResponse? pendingServicesRequest;

  Future<void> servicesRequestsPending() async {
    pendingServicesRequest = null;
    emit(const OfficeProviderState.loadingServicesRequestFromClients());
    final result = await repo.servicesRequestsPending();
    result.whenOrNull(
      success: (data) {
        pendingServicesRequest = data;
        emit(OfficeProviderState.loadedOffersServicesRequests(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServicesRequestFromClients(message));
      },
    );
  }

  Future<void> replyServicesRequestFromClients(FormData data) async {
    emit(const OfficeProviderState.loadingServicesReplyFromClients());
    final result = await repo.replyServicesRequestFromClients(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedServicesReplyFromClients(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServicesReplyFromClients(message));
      },
    );
  }

  Future<void> replyServicesOfferProviderOfficeClient(FormData data) async {
    emit(const OfficeProviderState.loadingOfferSend());
    final result = await repo.replyServicesOfferProviderOfficeClient(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedOfferSend(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorOfferSend(message));
      },
    );
  }

  Future<void> replyAppointmentsOfferProviderOfficeClient(FormData data) async {
    emit(const OfficeProviderState.loadingAppointmentOfferSend());
    final result = await repo.replyAppointmentsOfferProviderOfficeClient(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedAppointmentOfferSend(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorAppointmentOfferSend(message));
      },
    );
  }

  Future<void> replyAdvisoryRequestFromClients(FormData data) async {
    emit(const OfficeProviderState.loadingServicesReplyFromClients());
    final result = await repo.replyAdvisoryRequestFromClients(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedServicesReplyFromClients(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorServicesReplyFromClients(message));
      },
    );
  }

  // add advisory and get advisory
  advisory.AdvisoryAvailableTypesResponse? advisoryAvailableTypesResponse;

  Future<void> getAdvisorServicesProviderOffice() async {
    emit(const OfficeProviderState.loadingAdvisoryAvaliable());
    final result = await repo.getAdvisorServicesProviderOffice();
    result.whenOrNull(
      success: (data) {
        advisoryAvailableTypesResponse = data;
        emit(OfficeProviderState.loadedAdvisoryAvaliable(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorAdvisoryAvaliable(message));
      },
    );
  }

  Future<void> addAdvisory(FormData data) async {
    emit(const OfficeProviderState.loadingAddAdvisory());
    final result = await repo.addAdvisorServicesProviderOffice(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedAddAdvisory(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorAddAdvisory(message));
      },
    );
  }

  void saveWorkingHours(
      {required String dayNum,
      required String service,
      required String from,
      required String to,
      required int minsBetween}) {
    // اريد في حالة وجود ال dayOfWeek في ال list ان يتم تعديل القيمة

    if (workingHours.any((element) => element.dayOfWeek == dayNum)) {
      workingHours.removeWhere((element) => element.dayOfWeek == dayNum);
      workingHours.add(Time(
          service: service,
          dayOfWeek: dayNum,
          from: from,
          to: to,
          minsBetween: minsBetween));
    } else {
      workingHours.add(Time(
          service: service,
          dayOfWeek: dayNum,
          from: from,
          to: to,
          minsBetween: minsBetween));
    }
  }

  void removeDayFromWorkingHours(String dayNum) {
    workingHours.removeWhere((element) => element.dayOfWeek == dayNum);
  }

  Future<void> storeWorkingDays() async {
    emit(const OfficeProviderState.loadingPostWorkingHours());
    final data =
        WorkTimeRequestModel(times: convertToApiFormat(workDaysAndTimes, 15));
    final result = await repo.postWorkingHours(data);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedPostWorkingHours());
      },
      failure: (message) {
        emit(OfficeProviderState.errorPostWorkingHours(message['message']));
      },
    );
  }

  WorkDaysAndTimes? workDaysAndTimes;

  Future<void> geteWorkingDays() async {
    emit(const OfficeProviderState.loadingWorkingHours());
    final result = await repo.getWorkingHours();
    result.whenOrNull(
      success: (data) {
        workDaysAndTimes = data;
        emit(const OfficeProviderState.loadedWorkingHours());
      },
      failure: (message) {
        emit(OfficeProviderState.errorWorkingHours(message));
      },
    );
  }

  // create services
  Future<void> createServices(FormData data) async {
    emit(const OfficeProviderState.loadingRequestServices());
    final result = await repo.createServicesYmtazToProvider(data);
    result.whenOrNull(
      success: (data) {
        emit(OfficeProviderState.loadedRequestServices(data));
      },
      failure: (message) {
        emit(OfficeProviderState.errorRequestServices(message));
      },
    );
  }

  Future<void> hideService(String id, bool ishidden) async {
    emit(const OfficeProviderState.loadingHideServices());
    int value = ishidden ? 0 : 1;

    Map<String, String> data = {
      "status": value.toString(),
    };

    final result = await repo.hideServices(id, data);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedHideServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorHideServices(message));
      },
    );
  }

  Future<void> removeService(String id) async {
    emit(const OfficeProviderState.loadingDeleteServices());
    final result = await repo.deleteServices(id);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedDeleteServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorDeleteServices(message));
      },
    );
  }

  Future<void> hideAdvisoryService(String id, bool ishidden) async {
    emit(const OfficeProviderState.loadingHideServices());
    int value = ishidden ? 0 : 1;

    Map<String, String> data = {
      "status": value.toString(),
    };

    final result = await repo.hideAdvisoryServices(id, data);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedHideServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorHideServices(message));
      },
    );
  }

  Future<void> removeAdvisory(String id) async {
    emit(const OfficeProviderState.loadingDeleteServices());
    final result = await repo.deleteAdvisory(id);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedDeleteServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorDeleteServices(message));
      },
    );
  }

  Future<void> hideAppointments(String id, bool ishidden) async {
    emit(const OfficeProviderState.loadingHideServices());
    int value = ishidden ? 0 : 1;

    Map<String, String> data = {
      "status": value.toString(),
    };

    final result = await repo.hideAppointments(id, data);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedHideServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorHideServices(message));
      },
    );
  }

  Future<void> deleteAppointments(String id) async {
    emit(const OfficeProviderState.loadingDeleteServices());
    final result = await repo.deleteAppointments(id);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedDeleteServices());
      },
      failure: (message) {
        emit(OfficeProviderState.errorDeleteServices(message));
      },
    );
  }

  Future<void> createAppointments(FormData data) async {
    emit(const OfficeProviderState.loadingCreateAppointmentsTypes());
    final result = await repo.createAppointmentsTypesToProvider(data);
    result.whenOrNull(
      success: (data) {
        emit(const OfficeProviderState.loadedCreateAppointmentsTypes());
      },
      failure: (message) {
        emit(OfficeProviderState.errorCreateAppointmentsTypes(message));
      },
    );
  }

  List<Time> convertToApiFormat(
      WorkDaysAndTimes? workDaysAndTimes, int minsBetween) {
    List<Time> apiData = [];

    if (workDaysAndTimes != null) {
      for (var service in workDaysAndTimes.data!.workingSchedule!) {
        for (var day in service.days!) {
          for (var timeSlot in day.timeSlots!) {
            apiData.add(Time(
                service: service.service,
                dayOfWeek: day.dayOfWeek,
                from: timeSlot.from,
                to: timeSlot.to,
                minsBetween: minsBetween));
          }
        }
      }
    }

    return apiData;
  }

  bool validateWorkingDays() {
    if (workingHours.isEmpty) {
      emit(const OfficeProviderState.errorPostWorkingHours(
          'يجب اختيار يوم واحد على الاقل'));
      return false;
    }
    return true;
  }

  void clearAppointmentsData() {
    datesTypesResponse = null;
    textEditingControllers.clear();
  }

  void changeDayIndexSelected(int dayIndex) {
    dayIndexSelected = dayIndex;
    emit(const OfficeProviderState.changeDayIndexSelected());
  }

  void resetWorkingHours() {
    workingHours.clear();
    dayIndexSelected = 0;
    isMonday = false;
    isTuesday = false;
    isWednesday = false;
    isThursday = false;
    isFriday = false;
    isSaturday = false;
    isSunday = false;
    workDaysAndTimes = null;
  }

  List<TimeSlot> times = [];

  List<TimeSlot> getAdvisoryTimesForDay(int day, int serviceId) {
    if (workDaysAndTimes != null) {
      final schedule = workDaysAndTimes!.data!.workingSchedule!.firstWhere(
        (element) => element.service == serviceId.toString(),
        orElse: () => WorkingSchedule(service: serviceId.toString(), days: []),
      );

      if (schedule.days != null) {
        final daySchedule = schedule.days!.firstWhere(
          (element) => element.dayOfWeek == day.toString(),
          orElse: () => Day(dayOfWeek: day.toString(), timeSlots: []),
        );
        times = daySchedule.timeSlots ?? [];
        return daySchedule.timeSlots ?? [];
      }
    }
    return [];
  }

  void deleteTimeSlot(TimeSlot tim, int day) {
    if (times.isNotEmpty) {
      times.removeWhere(
          (element) => element.to == tim.to && element.from == tim.from);
    }

    emit(const OfficeProviderState.changeDayIndexSelected());
  }

  void addTimeSlot(TimeSlot timeSlot, int dayIndex, int serviceId) {
    if (workDaysAndTimes != null) {
      final schedule = workDaysAndTimes!.data!.workingSchedule!.firstWhere(
        (element) => element.service == serviceId.toString(),
        orElse: () {
          final newSchedule =
              WorkingSchedule(service: serviceId.toString(), days: []);
          workDaysAndTimes!.data!.workingSchedule!.add(newSchedule);
          return newSchedule;
        },
      );

      final daySchedule = schedule.days!.firstWhere(
        (element) => element.dayOfWeek == dayIndex.toString(),
        orElse: () {
          final newDay = Day(dayOfWeek: dayIndex.toString(), timeSlots: []);
          schedule.days!.add(newDay);
          return newDay;
        },
      );

      if (!daySchedule.timeSlots!.contains(timeSlot)) {
        daySchedule.timeSlots!.add(timeSlot);
        // times.add(timeSlot);
      }
    }

    emit(const OfficeProviderState.changeDayIndexSelected());
  }

  // adjust services New

  void getServicesListPrices(services.Datum service) {
    textEditingControllers.clear();
    if (service.lawyerPrices != null && service.lawyerPrices!.isNotEmpty) {
      for (int i = 0; i < service.lawyerPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.lawyerPrices![i].price.toString()));
      }
    } else {
      for (int i = 0; i < service.ymtazLevelsPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.ymtazLevelsPrices![i].price.toString()));
      }
    }
  }

  void getAppointmentsListPrices(ReservationType service) {
    textEditingControllers.clear();
    if (service.lawyerPrices != null && service.lawyerPrices!.isNotEmpty) {
      for (int i = 0; i < service.lawyerPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.lawyerPrices![i].price.toString()));
      }
    } else {
      for (int i = 0; i < service.ymtazPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.ymtazPrices![i].price.toString()));
      }
    }
  }

  void getAdvisoryListPrices(advisory.Type service) {
    textEditingControllers.clear();
    if (service.lawyerPrices != null && service.lawyerPrices!.isNotEmpty) {
      for (int i = 0; i < service.lawyerPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.lawyerPrices![i].price.toString()));
      }
    } else {
      for (int i = 0; i < service.ymtazPrices!.length; i++) {
        textEditingControllers.add(TextEditingController(
            text: service.ymtazPrices![i].price.toString()));
      }
    }
  }
}
