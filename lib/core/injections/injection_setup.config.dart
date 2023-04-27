// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/app_db/app_db_repository_impl.dart' as _i4;
import '../../data/auth/auth_repository_impl.dart' as _i6;
import '../../data/user/user_repository_impl.dart' as _i8;
import '../../domain/app_db/app_db_repository.dart' as _i3;
import '../../domain/auth/auth_repository.dart' as _i5;
import '../../domain/user/user_repository.dart' as _i7;
import '../../presentation/bloc/auth/auth_bloc.dart' as _i9;
import '../../presentation/bloc/user/user_bloc.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AppDbRepository>(
      () => _i4.AppDbRepositoryImplementation());
  gh.lazySingleton<_i5.AuthRepository>(() => _i6.AuthRepositoryImpl());
  gh.lazySingleton<_i7.UserRepository>(() => _i8.UserRepositoryImpl());
  gh.factory<_i9.AuthBloc>(() => _i9.AuthBloc(get<_i5.AuthRepository>()));
  gh.factory<_i10.UserBloc>(() => _i10.UserBloc(
        get<_i7.UserRepository>(),
        get<_i5.AuthRepository>(),
      ));
  return get;
}
