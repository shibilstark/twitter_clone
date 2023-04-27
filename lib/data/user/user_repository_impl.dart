import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_clone/config/config.dart';
import 'package:twitter_clone/core/server/app_server.dart';
import 'package:twitter_clone/domain/user/models/user_model.dart';
import 'package:twitter_clone/domain/common_types/type_defs.dart';
import 'package:twitter_clone/domain/user/user_repository.dart';

import '../../domain/app_failure/app_failure.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  @override
  FutureEither<String> createUser(UserModel user) async {
    try {
      final doc = await AppServer.databases.createDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.usersCollection,
          documentId: user.uid,
          data: user.toMap());

      return Right(doc.$id);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<UserModel> getUser(String uid) async {
    try {
      final doc = await AppServer.databases.getDocument(
        databaseId: AppWriteConstants.databaseId,
        collectionId: AppWriteConstants.usersCollection,
        documentId: uid,
      );

      return Right(UserModel.fromMap(doc.data));
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }
}
