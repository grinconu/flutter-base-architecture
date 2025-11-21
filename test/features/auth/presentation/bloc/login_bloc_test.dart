import 'package:base_architecture/core/auth/auth_service.dart';
import 'package:base_architecture/features/auth/domain/entities/user.dart';
import 'package:base_architecture/features/auth/domain/usecases/login_usecase.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_bloc.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_event.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockAuthService extends Mock implements AuthService {}

void main() {
  late LoginBloc bloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockAuthService mockAuthService;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockAuthService = MockAuthService();
    bloc = LoginBloc(mockLoginUseCase, mockAuthService);
  });

  tearDown(() {
    bloc.close();
  });

  const tEmail = 'test@test.com';
  const tPassword = 'password';
  const tUser = User(id: '1', email: tEmail, name: 'Test User');

  test('initial state is LoginInitial', () {
    expect(bloc.state, LoginInitial());
  });

  test('emits [LoginLoading, LoginSuccess] when login is successful', () async {
    // arrange
    when(() => mockLoginUseCase(tEmail, tPassword))
        .thenAnswer((_) async => tUser);

    // act
    bloc.add(const LoginSubmitted(tEmail, tPassword));

    // assert
    await expectLater(
      bloc.stream,
      emitsInOrder([
        LoginLoading(),
        const LoginSuccess(tUser),
      ]),
    );
  });

  test('emits [LoginLoading, LoginFailure] when login fails', () async {
    // arrange
    when(() => mockLoginUseCase(tEmail, tPassword))
        .thenThrow(Exception('Login failed'));

    // act
    bloc.add(const LoginSubmitted(tEmail, tPassword));

    // assert
    await expectLater(
      bloc.stream,
      emitsInOrder([
        LoginLoading(),
        const LoginFailure('Exception: Login failed'),
      ]),
    );
  });
}
