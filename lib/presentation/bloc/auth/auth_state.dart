part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCreatedUser extends AuthState {}

class AuthNotFound extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel authModel;

  const AuthSuccess(this.authModel);

  @override
  List<Object> get props => [authModel];
}

class AuthError extends AuthState {
  final AppFailure error;

  const AuthError(this.error);

  @override
  List<Object> get props => [error];
}
