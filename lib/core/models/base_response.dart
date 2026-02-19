class BaseResponse {
  final bool status;
  final int code;
  final String message;

  BaseResponse({
    required this.status,
    required this.code,
    required this.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
    );
  }
} 
