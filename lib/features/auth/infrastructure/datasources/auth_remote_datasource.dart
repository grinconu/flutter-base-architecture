import 'package:base_architecture/features/auth/infrastructure/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@test.com' && password == '123456') {
      return const UserModel(
        id: '1',
        email: 'test@test.com',
        name: 'Test User',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
