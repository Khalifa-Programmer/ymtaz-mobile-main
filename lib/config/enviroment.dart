import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

const apiBaseUrlProd = "https://ymtaz.sa/api/"; // Production API URL
const apiBaseUrlDev = "https://dev.ymtaz.sa/api/"; // Development API URL

enum EnvironmentType {
  dev(apiBaseUrlDev, "pk_test_mnFqjU2gvCe4C49LLEVWLXRePxKemWbKZ4jM7Tdc"), // مفتاح تجريبي عام من توثيق ميسر
  prod(apiBaseUrlProd, "pk_live_ApQ5efJukmLXcxRvjpmwFyQoPL4r3y1EbMcZfZQ4");

  const EnvironmentType(this.apiBaseUrl, this.moyasarPublishableKey);

  final String apiBaseUrl;
  final String moyasarPublishableKey;
}

class Environment {
  static EnvironmentType? _current;

  static Future<EnvironmentType> current() async {
    if (_current != null) return _current!;

    // تحديد البيئة بناءً على وضع التشغيل (Debug vs Release)
    if (kReleaseMode) {
      _current = EnvironmentType.prod;
      print('🚀 PRODUCTION MODE: Using Live Environment.');
    } else {
      _current = EnvironmentType.dev;
      print('🛠️ DEVELOPMENT MODE: Using Test Environment.');
    }

    return _current!;
  }
}
