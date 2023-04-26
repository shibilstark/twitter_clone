import 'package:twitter_clone/domain/auth/models/auth_model.dart';
import 'package:twitter_clone/domain/common_types/type_defs.dart';

abstract class AuthRepository {
  FutureEither<void> signUp({
    required String email,
    required String password,
  });

  FutureEither<void> logOut(String sessionId);

  FutureEither<AuthModel> login({
    required String email,
    required String password,
  });

  AuthModel? getAuthFromDb();
}
