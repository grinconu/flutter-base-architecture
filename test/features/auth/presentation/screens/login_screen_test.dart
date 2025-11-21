import 'package:base_architecture/features/auth/presentation/bloc/login_bloc.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_event.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_state.dart';
import 'package:base_architecture/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginBloc extends Mock implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    // Register fallback values
    registerFallbackValue(const LoginSubmitted('email', 'password'));
    
    // Setup GetIt mock
    final getIt = GetIt.instance;
    if (getIt.isRegistered<LoginBloc>()) {
      getIt.unregister<LoginBloc>();
    }
    getIt.registerFactory<LoginBloc>(() => mockLoginBloc);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }

  testWidgets('renders LoginScreen with email and password fields', (tester) async {
    // arrange
    when(() => mockLoginBloc.state).thenReturn(LoginInitial());
    when(() => mockLoginBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockLoginBloc.close()).thenAnswer((_) async {});

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.text('Login'), findsWidgets); // AppBar title and Button
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('shows loading indicator when state is LoginLoading', (tester) async {
    // arrange
    when(() => mockLoginBloc.state).thenReturn(LoginLoading());
    when(() => mockLoginBloc.stream).thenAnswer((_) => Stream.value(LoginLoading()));
    when(() => mockLoginBloc.close()).thenAnswer((_) async {});

    // act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Process the stream

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('adds LoginSubmitted event when login button is pressed', (tester) async {
    // arrange
    when(() => mockLoginBloc.state).thenReturn(LoginInitial());
    when(() => mockLoginBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockLoginBloc.add(any())).thenReturn(null);
    when(() => mockLoginBloc.close()).thenAnswer((_) async {});

    // act
    await tester.pumpWidget(createWidgetUnderTest());
    
    await tester.enterText(find.widgetWithText(TextField, 'Email'), 'test@test.com');
    await tester.enterText(find.widgetWithText(TextField, 'Password'), 'password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));

    // assert
    verify(() => mockLoginBloc.add(const LoginSubmitted('test@test.com', 'password'))).called(1);
  });
}
