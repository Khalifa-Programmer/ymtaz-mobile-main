class SpecializationResponse {
  bool? status;
  int? code;
  String? message;
  List<Specialization>? data;

  SpecializationResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SpecializationResponse.fromJson(Map<String, dynamic> json) {
    return SpecializationResponse(
      status: json['status'] as bool?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Specialization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

class Specialization {
  int? id;
  String? title;
  String? description;
  String? icon;
  List<Service>? services;

  Specialization({
    this.id,
    this.title,
    this.description,
    this.icon,
    this.services,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'icon': icon,
        'services': services?.map((e) => e.toJson()).toList(),
      };
}

class Service {
  int? id;
  String? title;

  Service({
    this.id,
    this.title,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as int?,
      title: json['title'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}
