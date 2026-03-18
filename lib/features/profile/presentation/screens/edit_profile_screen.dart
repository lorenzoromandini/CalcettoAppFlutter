import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/offline_indicator.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../core/di/injection.dart';

/// Screen for editing user profile.
///
/// Features:
/// - Edit first name, last name, nickname
/// - Change password (optional, with validation)
/// - Profile picture upload (placeholder)
/// - Form validation
/// - Save changes
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Load current user data from server (not cache)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(authSessionProvider.notifier).refreshFromServer();
      _loadUserData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload user data when screen becomes visible again
    _loadUserData();
  }

  void _loadUserData() {
    final authSession = ref.read(authSessionProvider);
    final user = authSession.user;

    if (user != null) {
      // Split name into first and last name (best effort)
      final nameParts = user.name.split(' ');
      setState(() {
        _firstNameController.text = nameParts.isNotEmpty ? nameParts.first : '';
        _lastNameController.text =
            nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
        _nicknameController.text = user.nickname ?? '';
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _nicknameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Validate password field
  /// Returns null if valid, error message if invalid
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Password is optional
    }
    if (value.length < 6) {
      return 'La password deve essere di almeno 6 caratteri';
    }
    return null;
  }

  /// Validate confirm password field
  /// Returns null if valid, error message if invalid
  String? _validateConfirmPassword(String? value) {
    final password = _passwordController.text;
    if (password.isNotEmpty) {
      if (value == null || value.isEmpty) {
        return 'Conferma la password';
      }
      if (value != password) {
        return 'Le password non corrispondono';
      }
    }
    return null;
  }

  /// Check if password should be saved
  /// Returns true only if password is valid and confirmed
  bool _shouldSavePassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // If password is empty, don't save it
    if (password.isEmpty) {
      return false;
    }

    // Check minimum length
    if (password.length < 6) {
      return false;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      return false;
    }

    return true;
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // Check if we should save the password
      final shouldUpdatePassword = _shouldSavePassword();
      final password = shouldUpdatePassword ? _passwordController.text : null;

      // Call repository to update profile
      final result = await ref.read(authRepositoryProvider).updateProfile(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            nickname: _nicknameController.text.trim().isEmpty
                ? null
                : _nicknameController.text.trim(),
            password: password,
          );

      result.fold(
        (failure) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Errore: ${failure.message}')),
            );
          }
        },
        (user) {
          if (mounted) {
            // Refresh auth session to update user data
            ref.read(authSessionProvider.notifier).refresh();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(shouldUpdatePassword
                    ? 'Profilo e password aggiornati con successo!'
                    : 'Profilo aggiornato con successo!'),
              ),
            );
            Navigator.of(context).pop();
          }
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authSession = ref.watch(authSessionProvider);
    final user = authSession.user;

    // Show loading while auth is loading
    if (authSession.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If not authenticated, show error
    if (!authSession.isAuthenticated || user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Modifica Profilo')),
        body: const Center(
          child: Text('Utente non autenticato'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Profilo'),
      ),
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            backgroundImage: user.avatarUrl != null
                                ? NetworkImage(user.avatarUrl!)
                                : null,
                            child: user.avatarUrl == null
                                ? Text(
                                    user.name.isNotEmpty
                                        ? user.name[0].toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      fontSize: 48,
                                      color:
                                          theme.colorScheme.onPrimaryContainer,
                                    ),
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: theme.colorScheme.primary,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, size: 20),
                                color: theme.colorScheme.onPrimary,
                                onPressed: () {
                                  // TODO: Implement image picker
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Coming soon')),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Email (read-only)
                    TextFormField(
                      initialValue: user.email,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      enabled: false,
                    ),
                    const SizedBox(height: 16),

                    // First Name
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome *',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Il nome è obbligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Last Name
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        labelText: 'Cognome *',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Il cognome è obbligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Nickname
                    TextFormField(
                      controller: _nicknameController,
                      decoration: const InputDecoration(
                        labelText: 'Nickname',
                        hintText: 'Come ti chiamano in campo?',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Password Section
                    Text(
                      'Cambia Password',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lascia vuoto per mantenere la password attuale',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Nuova Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: _validatePassword,
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Conferma Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: _validateConfirmPassword,
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isLoading ? null : _saveProfile,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(_isLoading ? 'Salvataggio...' : 'Salva'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
