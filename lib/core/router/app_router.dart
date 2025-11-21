import 'package:base_architecture/core/auth/auth_service.dart';
import 'package:base_architecture/core/di/injection.dart';
import 'package:base_architecture/features/auth/presentation/screens/login_screen.dart';
import 'package:base_architecture/features/common/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: getIt<AuthService>(),
  redirect: (context, state) {
    final isAuthenticated = getIt<AuthService>().isAuthenticated;
    final isLoginRoute = state.uri.path == '/';

    if (!isAuthenticated && !isLoginRoute) {
      return '/';
    }

    if (isAuthenticated && isLoginRoute) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
