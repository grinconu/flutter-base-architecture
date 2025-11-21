import 'package:base_architecture/features/auth/infrastructure/datasources/auth_remote_datasource.dart';
import 'package:base_architecture/features/auth/domain/entities/user.dart';
import 'package:base_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    return await _remoteDataSource.login(email, password);
  }
}
