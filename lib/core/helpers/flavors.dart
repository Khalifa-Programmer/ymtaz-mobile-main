enum Flavor { DEV, PROD }

class FlavorConfig {
  final Flavor flavor;
  final String name;

  static FlavorConfig? _instance;

  FlavorConfig._(this.flavor, this.name);

  static void setInstance(Flavor flavor) {
    _instance = FlavorConfig._(flavor, flavor.toString().split('.').last);
  }

  static FlavorConfig? get instance => _instance;
}
