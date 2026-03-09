import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../../../core/di/injection.dart';

part 'auth_provider.freezed.dart';

/// Authentication state sealed class.
@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.authenticated(User user) = AuthAuthenticated;
  const factory AuthState.error(String message) = AuthError;
}

/// Riverpod notifier for authentication state management.
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginAsyncUseCase _loginUseCase;
  final AuthRepositoryImpl _repository;

  AuthNotifier({
    required LoginAsyncUseCase loginUseCase,
    required AuthRepositoryImpl repository,
  })  : _loginUseCase = loginUseCase,
        _repository = repository,
        super(const AuthState.initial());

  /// Attempts to log in with email and password.
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    final result = await _loginUseCase.call(email, password);

    result.fold(
      (failure) {
        state = AuthState.error(failure.message);
      },
      (user) {
        state = AuthState.authenticated(user);
      },
    );
  }

  /// Checks if user is already authenticated on app start.
  Future<void> checkAuthStatus() async {
    state = const AuthState.loading();

    final result = await _repository.isAuthenticated();

    result.fold(
      (failure) {
        // If checking auth status fails, start with initial state
        state = const AuthState.initial();
      },
      (isAuthenticated) {
        if (isAuthenticated) {
          // Get the current user
          _repository.getCurrentUser().then((userResult) {
            userResult.fold(
              (failure) {
                state = const AuthState.initial();
              },
              (user) {
                if (user != null) {
                  state = AuthState.authenticated(user);
                } else {
                  state = const AuthState.initial();
                }
              },
            );
          });
        } else {
          state = const AuthState.initial();
        }
      },
    );
  }

  /// Logs out the current user.
  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.initial();
  }
}

/// Provider for AuthNotifier.
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final loginUseCase = ref.watch(loginAsyncUseCaseProvider);
    final repository = ref.watch(authRepositoryProvider) as AuthRepositoryImpl;
    return AuthNotifier(
      loginUseCase: loginUseCase,
      repository: repository,
    );
  },
);
