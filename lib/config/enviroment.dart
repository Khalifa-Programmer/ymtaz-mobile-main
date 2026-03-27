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

  static void set(EnvironmentType type) {
    _current = type;
  }

  static Future<EnvironmentType> current() async {
    if (_current != null) return _current!;

    // 1. Check for manual override via --dart-define
    const envFromDefine = String.fromEnvironment('ENVIRONMENT');
    if (envFromDefine == 'prod') {
      _current = EnvironmentType.prod;
    } else if (envFromDefine == 'dev') {
      _current = EnvironmentType.dev;
    } else {
      // 2. Logic based on build mode and package name
      try {
        final packageInfo = await PackageInfo.fromPlatform();
        if (packageInfo.packageName.endsWith('.dev')) {
          _current = EnvironmentType.dev;
        } else if (kReleaseMode) {
          _current = EnvironmentType.prod;
        } else {
          // Default to prod for official main (usually production flavor)
          _current = EnvironmentType.prod;
        }
      } catch (e) {
        _current = kReleaseMode ? EnvironmentType.prod : EnvironmentType.dev;
      }
    }

    if (_current == EnvironmentType.prod) {
      debugPrint('🚀 PRODUCTION MODE: Using Live Environment.');
    } else {
      debugPrint('🛠️ DEVELOPMENT MODE: Using Test Environment.');
    }

    return _current!;
  }
}

