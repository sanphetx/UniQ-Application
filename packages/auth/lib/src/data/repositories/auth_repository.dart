import 'package:auth/src/data/models/payloads/sign_in_request.dart';
import 'package:core/core.dart';
import 'package:core/src/models/token.dart';
import 'package:core/src/repositories/token_repository.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signIn(SignInRequest request);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._apiClient, this._tokenRepository);

  final ApiClient _apiClient;
  final TokenRepository _tokenRepository;

  @override
  Future<Either<Failure, Unit>> signIn(SignInRequest request) async => ErrorHandler.handle<Unit>(() async {
    final response = await _apiClient.dio.post(
      '${AppEnvironment.config.apiBaseUrl}/auth/login',
      data: request.toJson(),
    );

    Map<String, dynamic> data;

    if (response.data is List && (response.data as List).isNotEmpty) {
      data = (response.data as List).first as Map<String, dynamic>;
    } else if (response.data is Map<String, dynamic>) {
      data = response.data as Map<String, dynamic>;
    } else {
      throw Exception('Invalid response format');
    }

    await _tokenRepository.setToken(
      TokenModel(
        accessToken: data['access_token'] ?? data['accessToken'] ?? 'temp_token',
        refreshToken: data['refresh_token'] ?? data['refreshToken'],
      ),
    );

    return unit;
  });
}
