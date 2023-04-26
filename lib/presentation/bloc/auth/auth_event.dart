part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const SignUpUser({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginUser({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password, context];
}

class LogOutUser extends AuthEvent {
  final BuildContext context;
  const LogOutUser(this.context);

  @override
  List<Object> get props => [context];
}

class LoadAuthFromDb extends AuthEvent {
  final BuildContext context;
  const LoadAuthFromDb(this.context);

  @override
  List<Object> get props => [context];
}
