import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repo/call_repo.dart';
import '../data/model/call_model.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallRepo _callRepo;

  CallCubit(this._callRepo) : super(CallInitial());

  List<CallModel>? callHistory;
  CallModel? activeCall;

  Future<void> startNewCall({
    required int receiverId,
    required String type,
    required String channelName,
    required String token,
  }) async {
    emit(CallLoading());
    final body = {
      'receiver_id': receiverId,
      'type': type,
      'channel_name': channelName,
      'token': token,
    };
    final result = await _callRepo.startCall(body);
    result.when(
      success: (data) {
        // Assuming data is the call object
        activeCall = CallModel.fromJson(data);
        emit(CallStarted(activeCall!));
      },
      failure: (error) => emit(CallError(error.toString())),
    );
  }

  Future<void> acceptCall(String callId) async {
    emit(CallLoading());
    final result = await _callRepo.acceptCall(callId);
    result.when(
      success: (data) {
        activeCall = CallModel.fromJson(data);
        emit(CallAccepted(activeCall!));
      },
      failure: (error) => emit(CallError(error.toString())),
    );
  }

  Future<void> rejectCall(String callId) async {
    emit(CallLoading());
    final result = await _callRepo.rejectCall(callId);
    result.when(
      success: (data) => emit(CallRejected()),
      failure: (error) => emit(CallError(error.toString())),
    );
  }

  Future<void> endCall(String callId) async {
    emit(CallLoading());
    final result = await _callRepo.endCall(callId);
    result.when(
      success: (data) {
        activeCall = null;
        emit(CallEnded());
      },
      failure: (error) => emit(CallError(error.toString())),
    );
  }

  Future<void> fetchCallHistory() async {
    emit(CallHistoryLoading());
    final result = await _callRepo.getCallHistory();
    result.when(
      success: (data) {
        // Assuming data is a list of calls
        if (data is List) {
          callHistory = data.map((e) => CallModel.fromJson(e)).toList();
        }
        emit(CallHistoryLoaded(callHistory ?? []));
      },
      failure: (error) => emit(CallHistoryError(error.toString())),
    );
  }
}
