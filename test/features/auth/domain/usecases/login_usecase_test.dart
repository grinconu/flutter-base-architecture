import 'package:base_architecture/features/auth/domain/entities/user.dart';
import 'package:base_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:base_architecture/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = LoginUseCase(mockAuthRepository);
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  const tUser = User(id: '1', email: tEmail, name: 'Test User');

  test('should get user from the repository when login is successful', () async {
    // arrange
    when(() => mockAuthRepository.login(tEmail, tPassword))
        .thenAnswer((_) async => tUser);

    // act
    final result = await useCase(tEmail, tPassword);

    // assert
    expect(result, tUser);
    verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should propagate exception when login fails', () async {
    // arrange
    when(() => mockAuthRepository.login(tEmail, tPassword))
        .thenThrow(Exception('Login failed'));

    // act
    final call = useCase.call;

    // assert
    expect(() => call(tEmail, tPassword), throwsException);
    verify(() => mockAuthRepository.login(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
