import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:auth/src/logic/blocs/auth_bloc.dart';
import 'package:core/core.dart';
import 'package:core/src/repositories/token_repository.dart';

class AuthModule extends BaseModule {
  AuthModule._internal();

  factory AuthModule() => _instance;

  static final AuthModule _instance = AuthModule._internal();

  @override
  Future<void> init() async {
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<ApiClient>(), sl<TokenRepository>()));

    sl.registerLazySingleton(() => AuthBloc(sl(), sl()));
  }
}
