import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_clone/domain/app_failure/app_failure.dart';
import 'package:twitter_clone/domain/auth/auth_repository.dart';
import 'package:twitter_clone/domain/auth/models/auth_model.dart';
import 'package:twitter_clone/presentation/widgets/custom_snackbar.dart';
import 'package:twitter_clone/utils/connectivity/connectivity_util.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoadAuthFromDb>(_loadAuthFromDb);
    on<SignUpUser>(_signUpUser);
    on<LoginUser>(_loginUser);
    on<LogOutUser>(_logOutUser);
  }

  void _loadAuthFromDb(LoadAuthFromDb event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final auth = authRepository.getAuthFromDb();

    if (auth == null) {
      emit(AuthNotFound());
    } else {
      emit(AuthSuccess(auth));
    }
  }

  void _signUpUser(SignUpUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _checkHaveConnection()) {
      await authRepository
          .signUp(email: event.email, password: event.password)
          .then((result) {
        result.fold((l) {
          emit(AuthError(l));
          _handleAuthError(emit, l, event.context);
        }, (r) => emit(AuthCreatedUser()));
      });
    } else {
      _handleInternetError(emit);
    }
  }

  void _logOutUser(LogOutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _checkHaveConnection()) {
      final auth = authRepository.getAuthFromDb() as AuthModel;

      await authRepository.logOut(auth.sessionId).then((result) {
        result.fold((l) {
          emit(AuthError(l));
          _handleAuthError(emit, l, event.context);
        }, (r) => emit(AuthLoggedOut()));
      });
    } else {
      _handleInternetError(emit);
    }
  }

  void _loginUser(LoginUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    if (await _checkHaveConnection()) {
      await authRepository
          .login(email: event.email, password: event.password)
          .then((result) {
        result.fold((l) {
          emit(AuthError(l));
          _handleAuthError(emit, l, event.context);
        }, (r) => emit(AuthSuccess(r)));
      });
    } else {
      _handleInternetError(emit);
    }
  }

  Future<bool> _checkHaveConnection() async =>
      await ConnectivityUtil.checkInternetConnection();

  _handleAuthError(
      Emitter<AuthState> emit, AppFailure error, BuildContext context) {
    showCustomSnackBar(context, message: error.message);
  }

  _handleInternetError(Emitter<AuthState> emit) {
    emit(AuthError(AppFailure.internet()));
  }
}
