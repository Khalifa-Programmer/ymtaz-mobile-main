part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object?> get props => [];
}

class CallInitial extends CallState {}

class CallLoading extends CallState {}

class CallStarted extends CallState {
  final CallModel call;
  const CallStarted(this.call);

  @override
  List<Object?> get props => [call];
}

class CallAccepted extends CallState {
  final CallModel call;
  const CallAccepted(this.call);

  @override
  List<Object?> get props => [call];
}

class CallRejected extends CallState {}

class CallEnded extends CallState {}

class CallError extends CallState {
  final String message;
  const CallError(this.message);

  @override
  List<Object?> get props => [message];
}

class CallHistoryLoading extends CallState {}

class CallHistoryLoaded extends CallState {
  final List<CallModel> history;
  const CallHistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class CallHistoryError extends CallState {
  final String message;
  const CallHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
