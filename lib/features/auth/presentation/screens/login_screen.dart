import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/password_field.dart';
import 'signup_screen.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../providers/auth_providers.dart';
import '../../../home/presentation/screens/main_layout.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final loginState = ref.watch(loginFormProvider);

    ref.listen<LoginFormState>(loginFormProvider, (prev, next) {
      if (prev?.isLoading == true &&
          next.isLoading == false &&
          next.error == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainLayout()),
        );
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Calcetto Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState!.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Image.asset(
                  'logo.png',
                  height: 120,
                  width: 120,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.sports_soccer, size: 80, color: cs.primary),
                ),
                const SizedBox(height: 24),
                Text(
                  'Calcetto Manager',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: cs.surface,
                  ),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Required'
                      : !v.contains('@')
                          ? 'Invalid'
                          : null,
                  onChanged: (v) =>
                      ref.read(loginFormProvider.notifier).setEmail(v),
                ),
                const SizedBox(height: 16),
                PasswordField(
                  labelText: 'Password',
                  textInputAction: TextInputAction.done,
                  obscureText: !loginState.isPasswordVisible,
                  onToggleVisibility: ref
                      .read(loginFormProvider.notifier)
                      .togglePasswordVisibility,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                  onFieldSubmitted: (_) {
                    if (_formKey.currentState!.validate()) {
                      ref.read(loginFormProvider.notifier).login();
                    }
                  },
                ),
                const SizedBox(height: 24),
                if (loginState.error != null) ...[
                  Text(
                    loginState.error!,
                    style: TextStyle(color: cs.error),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
                FilledButton(
                  onPressed: loginState.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(loginFormProvider.notifier).login();
                          }
                        },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: loginState.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign In'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupScreen(),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
