import 'dart:async';

import 'package:core/src/constants/auth_status.dart';
import 'package:core/src/datasources/local/hive/hive_operation.dart';
import 'package:core/src/models/token.dart';

/// Repository interface for managing authentication tokens.
///
/// Provides methods to store, retrieve, and manage user authentication tokens
/// with reactive authentication status updates.
///
/// On initialization, loads the stored token from Hive to determine the user's
/// authentication state and emits the appropriate [AuthStatus].
abstract class TokenRepository {
  /// Retrieves the current authentication token.
  ///
  /// Returns the stored [TokenModel] if the user is authenticated,
  /// or `null` if no token is available or the user is unauthenticated.
  ///
  /// This getter waits for the authentication status to be determined
  /// if it's currently unknown before returning the token.
  Future<TokenModel?> get token;

  /// Stream of authentication status changes.
  ///
  /// Emits [AuthStatus] values whenever the authentication state changes:
  /// - [AuthStatus.authenticated] when a valid token is present
  /// - [AuthStatus.unauthenticated] when no token is available
  /// - [AuthStatus.unknown] during initial loading state
  ///
  /// The stream is broadcast and can have multiple listeners.
  Stream<AuthStatus> get authStatus;

  /// Stores a new authentication token.
  ///
  /// Persists the provided [token] to local storage and updates the
  /// authentication status to [AuthStatus.authenticated].
  Future<void> setToken(TokenModel token);

  /// Removes the current authentication token.
  ///
  /// Clears the stored token from local storage and updates the
  /// authentication status to [AuthStatus.unauthenticated].
  ///
  /// This method is typically called during user logout.
  Future<void> clearToken();

  /// Closes the repository and releases resources.
  ///
  /// Closes any open streams and performs cleanup operations.
  /// Should be called when the repository is no longer needed
  /// to prevent memory leaks.
  Future<void> close();
}

class TokenRepositoryImpl implements TokenRepository {
  TokenRepositoryImpl(this._tokenHiveOperation) {
    _tokenHiveOperation.getItem(_key).then(_setAuthStatus);
  }

  final HiveOperation<TokenModel> _tokenHiveOperation;
  final String _key = 'token';
  AuthStatus _authStatus = AuthStatus.unknown;
  TokenModel? _token;

  final StreamController<AuthStatus> _controller = StreamController<AuthStatus>.broadcast();

  @override
  Future<TokenModel?> get token async {
    if (_authStatus == AuthStatus.unknown) {
      await authStatus.firstWhere((status) => status != AuthStatus.unknown);
    }
    return _token;
  }

  @override
  Stream<AuthStatus> get authStatus async* {
    yield _authStatus;
    yield* _controller.stream;
  }

  @override
  Future<void> setToken(TokenModel token) async {
    await _tokenHiveOperation.insertOrUpdateItem(_key, token);
    _setAuthStatus(token);
  }

  @override
  Future<void> clearToken() async {
    await _tokenHiveOperation.deleteItem(_key);
    _setAuthStatus(null);
  }

  @override
  Future<void> close() async {
    await _controller.close();
  }

  void _setAuthStatus(TokenModel? token) {
    final newStatus = token != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;

    if (_authStatus != newStatus) {
      _authStatus = newStatus;
      _controller.add(_authStatus);
    }

    _token = token;
  }
}
