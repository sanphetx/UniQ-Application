import 'dart:async';

import 'package:auth/src/data/models/payloads/sign_in_request.dart';
import 'package:auth/src/data/repositories/auth_repository.dart';
import 'package:auth/src/logic/blocs/auth_state.dart';
import 'package:core/src/repositories/token_repository.dart';

class AuthBloc {
  AuthBloc(this._authRepository, this._tokenRepository);

  final AuthRepository _authRepository;
  final TokenRepository _tokenRepository;

  final StreamController<AuthState> _stateController = StreamController<AuthState>.broadcast();
  AuthState _currentState = const AuthState();

  Stream<AuthState> get state => _stateController.stream;
  AuthState get currentState => _currentState;

  void _emit(AuthState state) {
    _currentState = state;
    _stateController.add(state);
  }

  Future<void> signIn(String username, String password) async {
    _emit(_currentState.copyWith(status: AuthStateStatus.loading));

    final request = SignInRequest(username: username, password: password);
    final result = await _authRepository.signIn(request);

    result.fold(
      (failure) => _emit(_currentState.copyWith(status: AuthStateStatus.failure, failure: failure)),
      (_) => _emit(_currentState.copyWith(status: AuthStateStatus.success)),
    );
  }

  Future<void> signOut() async {
    await _tokenRepository.clearToken();
    _emit(const AuthState());
  }

  void dispose() {
    _stateController.close();
  }
}
