import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:core/src/datasources/local/hive/hive_encryption.dart';
import 'package:core/src/datasources/local/hive/hive_manager.dart';
import 'package:core/src/datasources/local/hive/hive_operation.dart';
import 'package:core/src/datasources/local/secure/secure_storage.dart';
import 'package:core/src/datasources/remote/api_client.dart';
import 'package:core/src/datasources/remote/dio_factory.dart';
import 'package:core/src/errors/error_handler.dart';
import 'package:core/src/injection/injection.dart';
import 'package:core/src/models/token.dart';
import 'package:core/src/module/base_module.dart';
import 'package:core/src/repositories/token_repository.dart';
import 'package:core/src/utils/file_operation_util.dart';

class CoreModule extends BaseModule {
  CoreModule._internal();

  factory CoreModule() => _instance;

  static final CoreModule _instance = CoreModule._internal();

  @override
  Future<void> init() async {
    sl.registerSingleton(Hive);

    sl.registerLazySingleton(() => DioFactory.getInstance());

    sl.registerLazySingleton(
      () => SecureStorage<String>(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
          iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        ),
      ),
    );

    sl.registerLazySingleton(() => FileOperationUtil());

    sl.registerLazySingleton(() => HiveManager(sl(), sl()));

    sl.registerLazySingleton(() => HiveEncryption(sl(), sl()));

    sl.registerLazySingleton<HiveOperation<TokenModel>>(() => HiveOperationImpl<TokenModel>(sl(), sl()));

    sl.registerLazySingleton<TokenRepository>(() => TokenRepositoryImpl(sl()));

    sl.registerLazySingleton(() => ApiClient(sl(), sl()));

    sl.registerLazySingleton(() => ErrorHandler());

    await sl<HiveManager>().init();
  }
}
