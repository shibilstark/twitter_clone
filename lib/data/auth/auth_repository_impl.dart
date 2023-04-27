import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:twitter_clone/core/injections/injection_setup.dart';
import 'package:twitter_clone/core/server/app_server.dart';
import 'package:twitter_clone/data/auth/auth_db/auth_db.dart';
import 'package:twitter_clone/domain/app_failure/app_failure.dart';
import 'package:twitter_clone/domain/app_failure/app_failure_enums.dart';
import 'package:twitter_clone/domain/auth/auth_repository.dart';
import 'package:twitter_clone/domain/common_types/type_defs.dart';
import 'package:twitter_clone/domain/auth/models/auth_model.dart';
import 'package:appwrite/appwrite.dart';
import 'package:twitter_clone/domain/user/models/user_model.dart';
import 'package:twitter_clone/domain/user/user_repository.dart';

import '../../config/config.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDb authDb = AuthDb();

  @override
  FutureEither<void> logOut(String sessionId) async {
    try {
      await AppServer.account.deleteSession(sessionId: sessionId);
      authDb.clear();

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<AuthModel> login(
      {required String email, required String password}) async {
    try {
      final session = await AppServer.account.createEmailSession(
        email: email,
        password: password,
      );

      final user = await AppServer.account.get();

      final authModel = AuthModel(
        id: 0,
        userId: user.$id,
        sessionId: session.$id,
        expireAt: DateTime.parse(session.expire),
        email: user.email,
        isEmailVerified: user.emailVerification,
      );

      try {
        await AppServer.databases.getDocument(
          databaseId: AppWriteConstants.databaseId,
          collectionId: AppWriteConstants.usersCollection,
          documentId: user.$id,
        );
      } on AppwriteException catch (e) {
        if (e.code == 404) {
          final userModel = UserModel(
            uid: user.$id,
            name: _getNameFromEmail(email),
            email: email,
            bio: "",
            coverPic: "",
            profilePic: "",
            followers: const [],
            following: const [],
            isTwitterVerfied: false,
            tweets: const [],
          );

          await getIt<UserRepository>()
              .createUser(userModel)
              .onError((error, stackTrace) {
            return const Left(AppFailure(
              message: "Failed to fetch your account, try again later",
              type: FailureType.server,
            ));
          });
        }
      }

      final newAuthModel = authModel.copyWith(id: authDb.save(authModel));

      return Right(newAuthModel);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  @override
  FutureEither<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final user = await AppServer.account.create(
        email: email,
        password: password,
        userId: ID.unique(),
      );

      final userModel = UserModel(
        uid: user.$id,
        name: _getNameFromEmail(user.email),
        email: user.email,
        bio: "",
        coverPic: "",
        profilePic: "",
        followers: const [],
        following: const [],
        isTwitterVerfied: false,
        tweets: const [],
      );

      await getIt<UserRepository>().createUser(userModel);

      return const Right(null);
    } on AppwriteException catch (e) {
      return Left(AppFailure.server(e.message));
    } catch (e) {
      return Left(
          kDebugMode ? AppFailure.client(e.toString()) : AppFailure.common());
    }
  }

  String _getNameFromEmail(String email) => email.split("@").first;

  @override
  AuthModel? getAuthFromDb() {
    return authDb.get();
  }
}
