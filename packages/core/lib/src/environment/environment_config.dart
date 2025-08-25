import 'package:core/src/environment/base_config.dart';

class DevConfig extends BaseConfig {
  @override
  String get apiBaseUrl => 'https://dummyjson.com';

  @override
  String get appName => 'App Prod';
}

class UatConfig extends BaseConfig {
  @override
  String get apiBaseUrl => 'https://dummyjson.com';

  @override
  String get appName => 'App UAT';
}

class ProdConfig extends BaseConfig {
  @override
  String get apiBaseUrl => 'https://dummyjson.com';

  @override
  String get appName => 'App DEV';
}
