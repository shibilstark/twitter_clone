import 'package:twitter_clone/data/app_db/app_db.dart';
import 'package:twitter_clone/data/auth/auth_db/auth_entities.dart';
import 'package:twitter_clone/domain/auth/models/auth_model.dart';

class AuthDb {
  final box = ObjectBox.instance.store.box<AuthEntity>();

  int save(AuthModel model) {
    box.removeAll();
    return box.put(AuthEntity.fromModel(model));
  }

  AuthModel? get() {
    final authBoxData = box.getAll().toList();

    if (authBoxData.isEmpty) {
      return null;
    }

    return authBoxData.first.toModel();
  }

  void clear() {
    box.removeAll();
  }
}
