part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;

  const UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoading extends UserState {}

class UserError extends UserState {
  final AppFailure error;

  const UserError(this.error);

  @override
  List<Object> get props => [error];
}
