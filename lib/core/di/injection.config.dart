// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/infrastructure/datasources/auth_remote_datasource.dart'
    as _i225;
import '../../features/auth/infrastructure/repositories/auth_repository_impl.dart'
    as _i748;
import '../../features/auth/presentation/bloc/login_bloc.dart' as _i990;
import '../auth/auth_service.dart' as _i88;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i88.AuthService>(() => _i88.AuthService());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i225.AuthRemoteDataSource>(
      () => _i225.AuthRemoteDataSourceMock(),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i748.AuthRepositoryImpl(gh<_i225.AuthRemoteDataSource>()),
    );
    gh.factory<_i188.LoginUseCase>(
      () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i990.LoginBloc>(
      () => _i990.LoginBloc(gh<_i188.LoginUseCase>(), gh<_i88.AuthService>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}
