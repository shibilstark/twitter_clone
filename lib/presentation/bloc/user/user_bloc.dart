import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_clone/domain/app_failure/app_failure.dart';
import 'package:twitter_clone/domain/auth/auth_repository.dart';
import 'package:twitter_clone/domain/auth/models/auth_model.dart';
import 'package:twitter_clone/domain/user/models/user_model.dart';
import 'package:twitter_clone/domain/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

@injectable
class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  UserBloc(this.userRepository, this.authRepository) : super(UserInitial()) {
    on<GetUser>(_getUser);
    on<UpdateUser>(_updateUser);
  }

  void _getUser(GetUser event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final userId = (authRepository.getAuthFromDb() as AuthModel).userId;

    await userRepository.getUser(userId).then((result) {
      result.fold((l) => emit(UserError(l)), (r) => emit(UserSuccess(r)));
    });
  }

  void _updateUser(UpdateUser event, Emitter<UserState> emit) async {}
}
