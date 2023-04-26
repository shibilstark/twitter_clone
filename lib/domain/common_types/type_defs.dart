import 'package:dartz/dartz.dart';
import 'package:twitter_clone/domain/app_failure/app_failure.dart';

typedef FutureEither<T> = Future<Either<AppFailure, T>>;
typedef EitherFailure<T> = Either<AppFailure, T>;
