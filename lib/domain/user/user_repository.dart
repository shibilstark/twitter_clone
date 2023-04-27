import 'package:twitter_clone/domain/common_types/type_defs.dart';
import 'package:twitter_clone/domain/user/models/user_model.dart';

abstract class UserRepository {
  FutureEither<String> createUser(UserModel user);

  FutureEither<UserModel> getUser(String uid);
}
