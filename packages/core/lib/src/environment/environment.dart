import 'package:package_info_plus/package_info_plus.dart';
import 'package:core/src/environment/base_config.dart';
import 'package:core/src/environment/environment_config.dart';

class AppEnvironment {
  AppEnvironment._();

  static const dev = 'dev';
  static const uat = 'uat';
  static const prod = 'prod';

  static late BaseConfig config;

  static Future<void> initConfig() async {
    final packageName = (await PackageInfo.fromPlatform()).packageName;
    final envSuffix = packageName.split('.').last.toLowerCase();

    final environment = switch (envSuffix) {
      'dev' => AppEnvironment.dev,
      'uat' => AppEnvironment.uat,
      _ => AppEnvironment.prod,
    };

    config = _getConfig(environment);
  }

  static BaseConfig _getConfig(String environment) {
    switch (environment) {
      case AppEnvironment.prod:
        return ProdConfig();
      case AppEnvironment.uat:
        return UatConfig();
      default:
        return DevConfig();
    }
  }
}
