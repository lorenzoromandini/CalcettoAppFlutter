import 'package:flutter/material.dart';
import '../widgets/password_field.dart';
import '../../../../core/widgets/app_drawer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _isSuccess = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    for (var c in [_firstNameController, _lastNameController, _nicknameController, _emailController, _passwordController, _confirmPasswordController]) c.dispose();
    super.dispose();
  }

  void _attemptSignup() {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; });
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() { _isLoading = false; _isSuccess = true; });
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Sign Up'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState!.openEndDrawer())],
      ),
      endDrawer: const AppDrawer(),
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 24),
          Image.asset('logo.png', height: 100, width: 100, errorBuilder: (_, __, ___) => Icon(Icons.sports_soccer, size: 60, color: cs.primary)),
          const SizedBox(height: 24),
          Text('Create Account', style: tt.headlineMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text('Join Calcetto', style: tt.bodyLarge?.copyWith(color: cs.onSurface.withOpacity(0.6)), textAlign: TextAlign.center),
          const SizedBox(height: 32),
          if (_isSuccess) ...[
            Center(child: Icon(Icons.check_circle, size: 80, color: cs.primary)),
            const SizedBox(height: 24),
            Text('Registration Complete!', style: tt.titleLarge?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Account created successfully', style: tt.bodyMedium?.copyWith(color: cs.onSurface.withOpacity(0.6)), textAlign: TextAlign.center),
            const SizedBox(height: 32),
            FilledButton(onPressed: () => Navigator.pop(context), child: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Go to Login'))),
          ] else ...[
            Row(children: [
              Expanded(child: TextFormField(controller: _firstNameController, textInputAction: TextInputAction.next, decoration: InputDecoration(labelText: 'First Name *', prefixIcon: const Icon(Icons.person_outline), border: const OutlineInputBorder(), filled: true, fillColor: cs.surface), validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
              const SizedBox(width: 12),
              Expanded(child: TextFormField(controller: _lastNameController, textInputAction: TextInputAction.next, decoration: InputDecoration(labelText: 'Last Name *', prefixIcon: const Icon(Icons.person_outline), border: const OutlineInputBorder(), filled: true, fillColor: cs.surface), validator: (v) => v == null || v.isEmpty ? 'Required' : null)),
            ]),
            const SizedBox(height: 16),
            TextFormField(controller: _nicknameController, textInputAction: TextInputAction.next, decoration: InputDecoration(labelText: 'Nickname (optional)', prefixIcon: const Icon(Icons.alternate_email), border: const OutlineInputBorder(), filled: true, fillColor: cs.surface)),
            const SizedBox(height: 16),
            TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, textInputAction: TextInputAction.next, decoration: InputDecoration(labelText: 'Email *', prefixIcon: const Icon(Icons.email_outlined), border: const OutlineInputBorder(), filled: true, fillColor: cs.surface), validator: (v) => v == null || v.isEmpty ? 'Required' : !v.contains('@') ? 'Invalid email' : null),
            const SizedBox(height: 16),
            PasswordField(controller: _passwordController, labelText: 'Password *', hintText: '••••••••', textInputAction: TextInputAction.next, validator: (v) => v == null || v.isEmpty ? 'Required' : v.length < 6 ? 'Min 6 chars' : null),
            const SizedBox(height: 16),
            PasswordField(controller: _confirmPasswordController, labelText: 'Confirm Password *', hintText: '••••••••', textInputAction: TextInputAction.done, validator: (v) => v != _passwordController.text ? 'No match' : null, onFieldSubmitted: (_) => _attemptSignup()),
            const SizedBox(height: 24),
            FilledButton(onPressed: _isLoading ? null : _attemptSignup, child: Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign Up'))),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Already have an account? '), TextButton(onPressed: () => Navigator.pop(context), child: const Text('Sign In'))]),
          ],
        ])),
      )),
    );
  }
}
