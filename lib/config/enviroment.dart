import 'package:package_info_plus/package_info_plus.dart';

const apiBaseUrlProd = "https://ymtaz.sa/api/"; // Production API URL
const apiBaseUrlDev = "https://dev.ymtaz.sa/api/"; // Development API URL

enum EnvironmentType {
  dev(apiBaseUrlDev),
  prod(apiBaseUrlProd);

  const EnvironmentType(this.apiBaseUrl);

  final String apiBaseUrl;
}

class Environment {
  static EnvironmentType? _current;

  static Future<EnvironmentType> current() async {
    if (_current != null) {
      return _current!;
    }

    final packageInfo = await PackageInfo.fromPlatform();

    // Check package name to determine the environment
    switch (packageInfo.packageName) {
      case "com.ymtaz.ymtaz.dev": // Updated development package name
        _current = EnvironmentType.dev;
        break;
      default:
        _current = EnvironmentType.prod; // Default to production
    }
    return _current!;
  }
}
