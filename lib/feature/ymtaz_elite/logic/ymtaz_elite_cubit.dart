import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_category_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_pricing_response.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_lawyer_section/models/service_request.dart';

import '../data/model/elite_my_requests_model.dart';
import '../data/model/elite_request_model.dart';
import '../data/model/elite_consultants_response.dart';
import '../data/model/elite_pricing_requests_model.dart';
import '../data/model/elite_promo_model.dart';
import '../data/models/elite_service_item.dart';
import '../../advisory_window/data/model/agora_token_response.dart';

part 'ymtaz_elite_state.dart';

class YmtazEliteCubit extends Cubit<YmtazEliteState> {
  final YmtazEliteRepo _ymtazEliteRepo;
  YmtazEliteCubit(this._ymtazEliteRepo) : super(YmtazEliteInitial());

  EliteCategoryModel? categories;
  int? selectedCategoryId;
  PendingPricing? selectedRequest;
  final Map<String, EliteServiceItem> _addedServices = {};
  EliteConsultantsResponse? eliteConsultantsData;
  ElitePromoModel? elitePromoTexts;
  List<PendingPricing>? pricingRequests;
  List<Request>? eliteRequests;
  bool _isLoadingElite = false;
  bool _isLoadingPricing = false;

  Future<void> getEliteConsultants() async {
    emit(YmtazEliteConsultantsLoading());
    final result = await _ymtazEliteRepo.getEliteConsultants();
    result.when(
      success: (data) {
        eliteConsultantsData = data;
        emit(YmtazEliteConsultantsSuccess(data));
      },
      failure: (error) {
        emit(YmtazEliteConsultantsError(error.toString()));
      },
    );
  }

  Future<void> getElitePromoTexts() async {
    emit(YmtazElitePromoTextsLoading());
    final result = await _ymtazEliteRepo.getElitePromoTexts();
    result.when(
      success: (data) {
        elitePromoTexts = data;
        emit(YmtazElitePromoTextsSuccess(data));
      },
      failure: (error) {
        emit(YmtazElitePromoTextsError(error.toString()));
      },
    );
  }

  Future<void> getCategories() async {
    emit(YmtazEliteLoading());
    final result = await _ymtazEliteRepo.getEliteCategories();
    result.when(
      success: (data) {
        categories = data;
        emit(YmtazEliteSuccess());
      },
      failure: (error) {
        emit(YmtazEliteError(error.toString()));
      },
    );
  }

  void selectCategory(int id) {
    selectedCategoryId = id;
    emit(YmtazEliteCategorySelected(id));
  }

  Future<void> sendEliteRequest(FormData formData) async {
    emit(YmtazEliteRequestLoading());
    final result = await _ymtazEliteRepo.sendEliteRequest(formData);
    result.when(
      success: (data) {
        getEliteRequests(forceRefresh: true); // Trigger refresh from API
        emit(YmtazEliteRequestSuccess(data));
      },
      failure: (error) {
        emit(YmtazEliteRequestError(error.toString()));
      },
    );
  }

  Future<void> getEliteRequests({bool forceRefresh = false}) async {
    if (_isLoadingElite && !forceRefresh) return;
    if (eliteRequests != null && !forceRefresh) {
      emit(YmtazEliteRequestsLoaded(eliteRequests!));
      return;
    }
    
    _isLoadingElite = true;
    emit(YmtazEliteLoading());
    final result = await _ymtazEliteRepo.getEliteRequests();
    _isLoadingElite = false;
    
    result.when(
      success: (data) {
        eliteRequests = data.data?.requests ?? [];
        emit(YmtazEliteRequestsLoaded(eliteRequests!));
      },
      failure: (error) {
        emit(YmtazEliteError(error.toString()));
      },
    );
  }

  Future<void> getPricingRequests({bool forceRefresh = false}) async {
    if (_isLoadingPricing && !forceRefresh) return;
    if (pricingRequests != null && !forceRefresh) {
      emit(YmtazElitePricingRequestsLoaded(pricingRequests!));
      return;
    }

    _isLoadingPricing = true;
    emit(YmtazEliteLoading());
    final result = await _ymtazEliteRepo.getPricingRequests();
    _isLoadingPricing = false;

    result.when(
      success: (data) {
        pricingRequests = data.data!.pendingPricing ?? [];
        emit(YmtazElitePricingRequestsLoaded(pricingRequests!));
      },
      failure: (error) {
        emit(YmtazEliteError(error.toString()));
      },
    );
  }

  void selectRequest(PendingPricing request) {
    selectedRequest = request;
    emit(YmtazEliteSelectedRequest(request));
  }

  bool canAddService(String type) {
    return !_addedServices.containsKey(type);
  }

  void addService(EliteServiceItem service) {
    try {
      if (canAddService(service.type)) {
        _addedServices[service.type] = service;
        print('Before emit - services: ${_addedServices.length}'); // للتشخيص
        emit(YmtazEliteServicesUpdated(Map<String, EliteServiceItem>.from(_addedServices)));
        print('After emit - service added: ${service.type} - ${service.title}'); // للتشخيص
      }
    } catch (e) {
      print('Error in addService: $e'); // للتشخيص
    }
  }

  void removeService(String type) {
    _addedServices.remove(type);
    // Make sure to emit the state with a new map instance
    emit(YmtazEliteServicesUpdated(Map<String, EliteServiceItem>.from(_addedServices)));
  }

  Future<void> submitPricingReply(List<BaseServiceRequest> serviceRequests) async {
    if (selectedRequest == null) {
      emit(YmtazElitePricingReplyError('لا يوجد طلب محدد'));
      return;
    }

    final Map<String, dynamic> body = {
      'elite_service_request_id': selectedRequest!.id,
    };

    // استخراج الاستشارة إذا وجدت
    final consultationRequest = serviceRequests.whereType<ConsultationRequest>().firstOrNull;
    if (consultationRequest != null) {
      body['advisory_service_sub_id'] = consultationRequest.accurateSpecializationId;
      body['advisory_service_sub_price'] = consultationRequest.price;
      
      // إضافة التاريخ والوقت فقط إذا كان نوع الاستشارة 2
      if (consultationRequest.advisoryTypeId == "2") {
        body['advisory_service_date'] = consultationRequest.date;
        body['advisory_service_from_time'] = consultationRequest.fromTime;
        body['advisory_service_to_time'] = consultationRequest.toTime;
      }
    }

    // استخراج الخدمة إذا وجدت
    final serviceRequest = serviceRequests.whereType<ServiceRequest>().firstOrNull;
    if (serviceRequest != null) {
      body['service_sub_id'] = serviceRequest.subServiceId;
      body['service_sub_price'] = serviceRequest.price;
    }

    // استخراج الموعد إذا وجد
    final appointmentRequest = serviceRequests.whereType<AppointmentRequest>().firstOrNull;
    if (appointmentRequest != null) {
      body.addAll({
        'reservation_type_id': appointmentRequest.appointmentTypeId,
        'reservation_price': appointmentRequest.price,
        'reservation_date': "${appointmentRequest.date.year}-${appointmentRequest.date.month.toString().padLeft(2, '0')}-${appointmentRequest.date.day.toString().padLeft(2, '0')}", // تم تعديل تنسيق التاريخ
        'reservation_from_time': _formatTimeToHHMM(appointmentRequest.startTime),
        'reservation_to_time': _formatTimeToHHMM(appointmentRequest.endTime),
        'reservation_latitude': appointmentRequest.lat,
        'reservation_longitude': appointmentRequest.lng,
      });
    }

    emit(YmtazElitePricingReplyLoading());
    
    try {
      final result = await _ymtazEliteRepo.replyToPricingRequest(body);
      result.when(
        success: (data) {
          getPricingRequests(forceRefresh: true); // Refresh for provider
          emit(YmtazElitePricingReplySuccess(data));
        },
        failure: (error) {
          String errorMessage = _extractErrorMessage(error);
          if (errorMessage.contains('Request is not pending pricing')) {
            errorMessage = 'هذا الطلب لم يعد متاحاً للتسعير (ربما تم تسعيره بالفعل أو اكتمل)';
          }
          emit(YmtazElitePricingReplyError(errorMessage));
        },
      );
    } catch (e) {
      emit(YmtazElitePricingReplyError(e.toString()));
    }
  }

  String _extractErrorMessage(dynamic error) {
    if (error is Map) {
      // التحقق من وجود أخطاء تحقق (Validation Errors)
      if (error.containsKey('errors')) {
        final Map<String, dynamic> errors = error['errors'];
        if (errors.isNotEmpty) {
          final firstErrorValue = errors.values.first;
          if (firstErrorValue is List && firstErrorValue.isNotEmpty) {
            return firstErrorValue.first.toString();
          } else if (firstErrorValue is String) {
            return firstErrorValue;
          }
        }
      }
      
      // التحقق من وجود رسالة عامة
      if (error.containsKey('message')) {
        return error['message'].toString();
      }
    }
    
    return error?.toString() ?? 'حدث خطأ غير متوقع، يرجى المحاولة لاحقاً';
  }

  Future<void> rejectOffer(String offerId, String reason) async {
    emit(YmtazEliteOfferApprovalLoading());
    
    try {
      final result = await _ymtazEliteRepo.approveOffer(offerId, 'rejected');
      result.when(
        success: (data) {
          getEliteRequests(forceRefresh: true); // Refresh for client
          emit(YmtazEliteOfferApprovalSuccess("rejected")); // Specific signal for rejection
        },
        failure: (error) {
          emit(YmtazEliteOfferApprovalError(_extractErrorMessage(error)));
        },
      );
    } catch (e) {
      emit(YmtazEliteOfferApprovalError(e.toString()));
    }
  }

  Future<void> approveOffer(String offerId, String type) async {
    emit(YmtazEliteOfferApprovalLoading());
    
    try {
      final result = await _ymtazEliteRepo.approveOffer(offerId, type);
      result.when(
        success: (data) {
          if (data.data?.paymentUrl != null) {
            getEliteRequests(forceRefresh: true); // Refresh list for client
            emit(YmtazEliteOfferApprovalSuccess(data.data!.paymentUrl!));
          } else if (type == 'rejected') {
             getEliteRequests(forceRefresh: true);
             emit(const YmtazEliteOfferApprovalSuccess("rejected"));
          } else {
            emit(const YmtazEliteOfferApprovalError('لم يتم العثور على رابط الدفع'));
          }
        },
        failure: (error) {
          emit(YmtazEliteOfferApprovalError(_extractErrorMessage(error)));
        },
      );
    } catch (e) {
      emit(YmtazEliteOfferApprovalError(e.toString()));
    }
  }

  String _formatTimeToHHMM(String time) {
    // تحويل الوقت من "5:51 ص" إلى "05:51"
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    var hour = int.parse(timeParts[0]);
    final minute = timeParts[1];
    
    // تحويل 12 ساعة إلى 24 ساعة
    if (parts[1] == 'م' && hour != 12) {
      hour += 12;
    } else if (parts[1] == 'ص' && hour == 12) {
      hour = 0;
    }
    
    return '${hour.toString().padLeft(2, '0')}:$minute';
  }

  Future<void> requestRepricing({
    required int requestId,
    required int offerId,
    required String comment,
    int? categoryId,
    String? voicePath,
  }) async {
    emit(YmtazEliteRepricingLoading());

    try {
      final Map<String, dynamic> data = {
        'elite_service_request_id': requestId,
        'elite_service_offer_id': offerId,
        'description': comment,
        if (categoryId != null) 'elite_service_category_id': categoryId,
      };

      final formData = FormData.fromMap(data);

      if (voicePath != null) {
        formData.files.add(MapEntry(
          'files[0][file]',
          await MultipartFile.fromFile(voicePath, filename: 'reprice_voice.m4a'),
        ));
        formData.fields.add(const MapEntry('files[0][is_voice]', '1'));
      }

      // Using sendEliteRequest as a fallback or a general purpose endpoint if a specific reprice isn't found
      // Note: If a specific API is discovered later, this can be updated.
      final result = await _ymtazEliteRepo.sendEliteRequest(formData);

      result.when(
        success: (data) {
          getEliteRequests(forceRefresh: true); // Refresh for client
          emit(YmtazEliteRepricingSuccess());
        },
        failure: (error) => emit(YmtazEliteRepricingError(error.toString())),
      );
    } catch (e) {
      emit(YmtazEliteRepricingError(e.toString()));
    }
  }

  Future<void> getAgoraToken(String channelName) async {
    emit(YmtazEliteAgoraTokenLoading());
    final result = await _ymtazEliteRepo.getAgoraToken(channelName);
    result.when(
      success: (data) {
        emit(YmtazEliteAgoraTokenSuccess(data));
      },
      failure: (error) {
        emit(YmtazEliteAgoraTokenError(error.toString()));
      },
    );
  }
}

class YmtazEliteServicesUpdated extends YmtazEliteState {
  final Map<String, EliteServiceItem> services;

  const YmtazEliteServicesUpdated(this.services);
}
