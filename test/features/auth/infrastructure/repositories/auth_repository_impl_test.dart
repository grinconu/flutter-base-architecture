import 'package:base_architecture/features/auth/infrastructure/datasources/auth_remote_datasource.dart';
import 'package:base_architecture/features/auth/infrastructure/models/user_model.dart';
import 'package:base_architecture/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  const tUserModel = UserModel(id: '1', email: tEmail, name: 'Test User');

  test('should return User when remote data source call is successful', () async {
    // arrange
    when(() => mockRemoteDataSource.login(tEmail, tPassword))
        .thenAnswer((_) async => tUserModel);

    // act
    final result = await repository.login(tEmail, tPassword);

    // assert
    expect(result, tUserModel);
    verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });

  test('should propagate exception when remote data source call fails', () async {
    // arrange
    when(() => mockRemoteDataSource.login(tEmail, tPassword))
        .thenThrow(Exception('Server error'));

    // act
    final call = repository.login;

    // assert
    expect(() => call(tEmail, tPassword), throwsException);
    verify(() => mockRemoteDataSource.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockRemoteDataSource);
  });
}
