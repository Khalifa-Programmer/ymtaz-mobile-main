part of 'ymtaz_elite_cubit.dart';

sealed class YmtazEliteState extends Equatable {
  const YmtazEliteState();

  @override
  List<Object> get props => [];
}

final class YmtazEliteInitial extends YmtazEliteState {}

final class YmtazEliteLoading extends YmtazEliteState {}

final class YmtazEliteSuccess extends YmtazEliteState {}

final class YmtazEliteError extends YmtazEliteState {
  final String message;

  const YmtazEliteError(this.message);

  @override
  List<Object> get props => [message];
}

final class YmtazEliteCategorySelected extends YmtazEliteState {
  final int categoryId;

  const YmtazEliteCategorySelected(this.categoryId);

  @override
  List<Object> get props => [categoryId];
}

final class YmtazEliteRequestLoading extends YmtazEliteState {}

final class YmtazEliteRequestSuccess extends YmtazEliteState {
  final EliteRequestModel request;

  const YmtazEliteRequestSuccess(this.request);

  @override
  List<Object> get props => [request];
}

final class YmtazEliteRequestError extends YmtazEliteState {
  final String message;

  const YmtazEliteRequestError(this.message);

  @override
  List<Object> get props => [message];
}

final class YmtazEliteRequestsLoaded extends YmtazEliteState {
  final List<Request> requests;

  const YmtazEliteRequestsLoaded(this.requests);

  @override
  List<Object> get props => [requests];
}

final class YmtazElitePricingRequestsLoaded extends YmtazEliteState {
  final List<PendingPricing> requests;

  const YmtazElitePricingRequestsLoaded(this.requests);

  @override
  List<Object> get props => [requests];
}

final class YmtazEliteSelectedRequest extends YmtazEliteState {
  final PendingPricing request;

  const YmtazEliteSelectedRequest(this.request);

  @override
  List<Object> get props => [request];
}

final class YmtazElitePricingReplyLoading extends YmtazEliteState {}

final class YmtazElitePricingReplySuccess extends YmtazEliteState {
  final ElitePricingResponse response;

  const YmtazElitePricingReplySuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class YmtazElitePricingReplyError extends YmtazEliteState {
  final String message;

  const YmtazElitePricingReplyError(this.message);

  @override
  List<Object> get props => [message];
}

final class YmtazEliteOfferApprovalLoading extends YmtazEliteState {}

final class YmtazEliteOfferApprovalSuccess extends YmtazEliteState {
  final String paymentUrl;

  const YmtazEliteOfferApprovalSuccess(this.paymentUrl);

  @override
  List<Object> get props => [paymentUrl];
}

final class YmtazEliteOfferApprovalError extends YmtazEliteState {
  final String message;

  const YmtazEliteOfferApprovalError(this.message);

  @override
  List<Object> get props => [message];
}
