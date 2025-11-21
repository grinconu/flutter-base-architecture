import 'package:base_architecture/core/auth/auth_service.dart';
import 'package:base_architecture/features/auth/domain/usecases/login_usecase.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_event.dart';
import 'package:base_architecture/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final AuthService _authService;

  LoginBloc(this._loginUseCase, this._authService) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await _loginUseCase(event.email, event.password);
      _authService.login();
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
