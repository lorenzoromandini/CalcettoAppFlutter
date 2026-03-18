import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/signup.dart';
import '../../domain/repositories/auth_repository.dart';

/// Provider for login form state.
class LoginFormState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;
  final bool isPasswordVisible;

  LoginFormState({
    required this.email,
    required this.password,
    required this.isLoading,
    this.error,
    required this.isPasswordVisible,
  });

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
    bool? isPasswordVisible,
  }) =>
      LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        isLoading: isLoading ?? this.isLoading,
        error: error,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      );
}

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
  return LoginFormNotifier(ref.watch(loginAsyncUseCaseProvider));
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final LoginAsyncUseCase _useCase;

  LoginFormNotifier(this._useCase)
      : super(LoginFormState(
          email: '',
          password: '',
          isLoading: false,
          isPasswordVisible: false,
        ));

  void setEmail(String email) {
    state = state.copyWith(email: email.trim(), error: null);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password.trim(), error: null);
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _useCase(state.email.trim(), state.password.trim());
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => state = state.copyWith(isLoading: false),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void clear() {
    state = LoginFormState(
      email: '',
      password: '',
      isLoading: false,
      isPasswordVisible: false,
    );
  }
}

/// Provider for signup form state.
class SignupFormState {
  final String email;
  final String firstName;
  final String lastName;
  final String nickname;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  SignupFormState({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.password,
    required this.confirmPassword,
    required this.isLoading,
    required this.isSuccess,
    this.error,
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
  });

  SignupFormState copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? nickname,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? isSuccess,
    String? error,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) =>
      SignupFormState(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        nickname: nickname ?? this.nickname,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isLoading: isLoading ?? this.isLoading,
        isSuccess: isSuccess ?? this.isSuccess,
        error: error,
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        isConfirmPasswordVisible:
            isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      );
}

final signupFormProvider =
    StateNotifierProvider<SignupFormNotifier, SignupFormState>((ref) {
  return SignupFormNotifier(ref.watch(signupAsyncUseCaseProvider));
});

class SignupFormNotifier extends StateNotifier<SignupFormState> {
  final SignupAsyncUseCase _useCase;

  SignupFormNotifier(this._useCase)
      : super(SignupFormState(
          email: '',
          firstName: '',
          lastName: '',
          nickname: '',
          password: '',
          confirmPassword: '',
          isLoading: false,
          isSuccess: false,
          isPasswordVisible: false,
          isConfirmPasswordVisible: false,
        ));

  void setEmail(String email) {
    state = state.copyWith(email: email.trim(), error: null);
  }

  void setFirstName(String firstName) {
    state = state.copyWith(firstName: firstName.trim(), error: null);
  }

  void setLastName(String lastName) {
    state = state.copyWith(lastName: lastName.trim(), error: null);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname.trim());
  }

  void setPassword(String password) {
    state = state.copyWith(password: password.trim(), error: null);
  }

  void setConfirmPassword(String confirmPassword) {
    state =
        state.copyWith(confirmPassword: confirmPassword.trim(), error: null);
  }

  Future<void> signup() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _useCase(
      email: state.email.trim(),
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      nickname: state.nickname.trim().isEmpty ? null : state.nickname.trim(),
      password: state.password.trim(),
      confirmPassword: state.confirmPassword.trim(),
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => state = state.copyWith(isLoading: false, isSuccess: true),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  void clear() {
    state = SignupFormState(
      email: '',
      firstName: '',
      lastName: '',
      nickname: '',
      password: '',
      confirmPassword: '',
      isLoading: false,
      isSuccess: false,
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
    );
  }
}

/// Provider for auth session state.
final authSessionProvider =
    StateNotifierProvider<AuthSessionNotifier, AuthSessionState>((ref) {
  return AuthSessionNotifier(ref.watch(authRepositoryProvider));
});

class AuthSessionState {
  final User? user;
  final bool isAuthenticated;
  final bool isLoading;

  AuthSessionState({
    this.user,
    required this.isAuthenticated,
    required this.isLoading,
  });

  AuthSessionState copyWith({
    User? user,
    bool? isAuthenticated,
    bool? isLoading,
  }) =>
      AuthSessionState(
        user: user ?? this.user,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        isLoading: isLoading ?? this.isLoading,
      );
}

class AuthSessionNotifier extends StateNotifier<AuthSessionState> {
  final AuthRepository _repository;

  AuthSessionNotifier(this._repository)
      : super(AuthSessionState(
          isAuthenticated: false,
          isLoading: true,
        )) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.isAuthenticated();
    result.fold(
      (failure) {
        state = state.copyWith(
          isAuthenticated: false,
          user: null,
          isLoading: false,
        );
      },
      (isAuth) async {
        User? user;
        if (isAuth) {
          final userResult = await _repository.getCurrentUser();
          userResult.fold(
            (failure) {
              // Failed to get user
            },
            (u) {
              user = u;
            },
          );
        }
        state = state.copyWith(
          isAuthenticated: isAuth,
          user: user,
          isLoading: false,
        );
      },
    );
  }

  Future<void> logout() async {
    await _repository.logout();
    state = state.copyWith(
      isAuthenticated: false,
      user: null,
    );
  }

  /// Public method to refresh auth status (for pull-to-refresh)
  Future<void> refresh() async {
    await _checkAuthStatus();
  }

  /// Refresh user data from server (not from cache)
  Future<void> refreshFromServer() async {
    state = state.copyWith(isLoading: true);
    final result = await _repository.fetchCurrentUserFromServer();
    result.fold(
      (failure) {
        // Keep current state on error
        state = state.copyWith(isLoading: false);
      },
      (user) {
        if (user != null) {
          state = state.copyWith(
            user: user,
            isLoading: false,
          );
        } else {
          state = state.copyWith(isLoading: false);
        }
      },
    );
  }
}
