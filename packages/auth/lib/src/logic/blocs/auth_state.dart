import 'package:core/core.dart';

enum AuthStateStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({this.status = AuthStateStatus.initial, this.failure});

  final AuthStateStatus status;
  final Failure? failure;

  AuthState copyWith({AuthStateStatus? status, Failure? failure}) {
    return AuthState(status: status ?? this.status, failure: failure ?? this.failure);
  }

  @override
  List<Object?> get props => [status, failure];
}
