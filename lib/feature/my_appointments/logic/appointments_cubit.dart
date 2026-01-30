import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/my_appointments/data/model/my_reservations_response_model.dart';
import 'package:yamtaz/feature/my_appointments/data/model/working_hours_response.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';

import '../data/model/appointment_offers_client.dart';
import '../data/model/dates_types_response_model.dart';
import '../data/repo/appointment_repo.dart';

class AppointmentsCubit extends Cubit<AppointmentsState> {
  final AppointmentRepo _repo;

  AppointmentsCubit(this._repo) : super(const AppointmentsState.initial());

  int selectedCountry = -1;
  int selectedRegion = -1;
  int selectedDistricts = -1;

  void load() {
    //getAvailableTimes();
    getCountries();
    getAppointmentsTypes();
  }

  final formKey = GlobalKey<FormState>();
  WorkingHoursResponse? availableDatesResponse;
  DatesTypesResponseModel? datesTypesResponse;

  // void getAvailableTimes(int hours) async {
  //   emit(const AppointmentsState.loading());
  //   final result = await _repo.getWorkingHours( hours*60);
  //   result.when(
  //     success: (data) {
  //       availableDatesResponse = data;
  //       emit(AppointmentsState.loaded(data));
  //     },
  //     failure: (error) {
  //       emit(AppointmentsState.error(error));
  //     },
  //   );
  // }

  CountriesResponse? countriesResponse;

  void getCountries() async {
    emit(const AppointmentsState.loading());
    final result = await _repo.getCountries();
    result.when(
      success: (data) {
        countriesResponse = data;
        emit(AppointmentsState.loaded(data));
      },
      failure: (error) {
        emit(AppointmentsState.error(error));
      },
    );
  }

  List<Region>? regions = [];

  void selectCounrty(List<Region> data, int countryId) {
    selectedDistricts = -1;
    selectedRegion = -1;
    selectedCountry = countryId;
    regions = data;
    emit(AppointmentsState.loaded(data));
  }

  List<City>? cities = [];

  void selectRegion(List<City> data, int redgionId) {
    selectedRegion = redgionId;
    cities = [];
    cities = data;
    selectedRegion = -1;
    emit(AppointmentsState.loaded(data));
  }

  void getAppointmentsTypes() async {
    emit(const AppointmentsState.loading());
    final result = await _repo.getAppointmentsTypes();
    result.when(
      success: (data) {
        datesTypesResponse = data;
        emit(AppointmentsState.loaded(data));
      },
      failure: (error) {
        emit(AppointmentsState.error(error));
      },
    );
  }

  AppointmentOffersClient? appointmentOffersClient;
  void getAppointmentsoffersClient() async {
    emit(const AppointmentsState.loading());
    final result = await _repo.getAppointmentsoffersClient();
    result.when(
      success: (data) {
        appointmentOffersClient = data;
        emit(AppointmentsState.loaded(data));
      },
      failure: (error) {
        emit(AppointmentsState.error(error));
      },
    );
  }

  void getLawyers(
      String importanceId, String cityId, String regionId, String id) async {
    emit(const AppointmentsState.appointmentLawyersByIdLoading());
    final result =
        await _repo.getAppointmentLawyers(importanceId, cityId, id, regionId);
    result.when(
      success: (data) {
        emit(AppointmentsState.appointmentLawyersByIdSuccess(data));
      },
      failure: (error) {
        emit(AppointmentsState.appointmentLawyersByIdError(error));
      },
    );
  }

  void requestAppointment(FormData data) async {
    emit(const AppointmentsState.loadingRequest());

    final result = await _repo.requestAppointment(data);
    result.when(
      success: (data) {
        emit(AppointmentsState.loadedRequest(data));
        clear();
      },
      failure: (error) {
        emit(AppointmentsState.errorRequest(error.toString()));
      },
    );
  }

  void respondToAppointmentOffer(FormData data) async {
    emit(const AppointmentsState.respondToOffer());

    final result = await _repo.respondToAppointmentOffer(data);
    result.when(
      success: (data) {
        emit(AppointmentsState.respondToAppointmentOfferSuccess(data));
        clear();
      },
      failure: (error) {
        emit(AppointmentsState.respondToOfferError(error.toString()));
      },
    );
  }


  void clear() {
    availableDatesResponse = null;
    emit(const AppointmentsState.initial());
  }

  void reset() {
    selectedCountry = -1;
    selectedRegion = -1;
    selectedDistricts = -1;
    availableDatesResponse = null;
    datesTypesResponse = null;
    countriesResponse = null;
    regions = [];
    cities = [];
    // myReservationsResponseModel = null;
    emit(const AppointmentsState.initial());
  }
}
