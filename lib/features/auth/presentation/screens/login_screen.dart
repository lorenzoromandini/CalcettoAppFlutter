import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/biometric_provider.dart';
import '../widgets/password_field.dart';
import '../../../../core/services/biometric_service.dart';
import '../../../../core/di/injection.dart';

/// Login screen with email and password authentication.
///
/// Material 3 design with proper loading states and error handling.
/// Includes biometric authentication option if enabled.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _passwordError;
  BiometricService? _biometricService;
  bool _isAuthenticatingWithBiometric = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _attemptLogin() {
    if (_formKey.currentState!.validate()) {
      final notifier = ref.read(authStateProvider.notifier);
      notifier.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }

  Future<void> _attemptBiometricLogin() async {
    setState(() {
      _isAuthenticatingWithBiometric = true;
    });

    try {
      final service = _biometricService ??= BiometricService();
      final authenticated = await service.authenticate(
        reason: 'Sign in to Calcetto',
      );

      if (authenticated && mounted) {
        // Biometric auth succeeded - retrieve stored credentials
        final authStorageService = ref.read(authStorageServiceProvider);
        final credentials = await authStorageService.getCredentials();

        if (credentials != null) {
          // Credentials exist - log in with them
          final email = credentials['email']!;
          final password = credentials['password']!;

          // Trigger login using the auth provider
          ref.read(authStateProvider.notifier).login(email, password);
        } else {
          // No stored credentials - show error
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Please log in with email and password first to enable biometric login'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Biometric authentication failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticatingWithBiometric = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final biometricStatus = ref.watch(biometricEnabledProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // App Logo placeholder
                Icon(
                  Icons.sports_soccer,
                  size: 80,
                  color: colorScheme.primary,
                ),
                const SizedBox(height: 24),
                // Welcome headline
                Text(
                  'Welcome Back',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  'Sign in to continue',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: colorScheme.surface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password field
                PasswordField(
                  controller: _passwordController,
                  errorText: _passwordError,
                  onChanged: (value) {
                    if (_passwordError != null) {
                      setState(() {
                        _passwordError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                // Login button
                FilledButton.tonal(
                  onPressed: authState.maybeWhen(
                    loading: () => null, // Disable while loading
                    orElse: () => _attemptLogin,
                  ),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: authState.maybeWhen(
                    loading: () => const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    orElse: () => const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 16),
                // Forgot password (for future implementation)
                TextButton(
                  onPressed: () {
                    // TODO: Implement password reset flow
                  },
                  child: const Text('Forgot Password?'),
                ),
                const SizedBox(height: 24),
                // Biometric login button (only shown if biometric is enabled)
                if (biometricStatus == BiometricStatus.enabled) ...[
                  const Divider(),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: _isAuthenticatingWithBiometric
                        ? null
                        : _attemptBiometricLogin,
                    icon: _isAuthenticatingWithBiometric
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.fingerprint),
                    label: Text(
                      _isAuthenticatingWithBiometric
                          ? 'Authenticating...'
                          : 'Sign in with Biometric',
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      // Show error snackbar when in error state
      bottomSheet: authState.maybeWhen(
        error: (message) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: colorScheme.errorContainer,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onErrorContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () {
                    ref.read(authStateProvider.notifier).logout();
                  },
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Try Again'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.onErrorContainer,
                  ),
                ),
              ],
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
