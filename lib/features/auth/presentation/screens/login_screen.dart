import 'package:flutter/material.dart';
import '../widgets/password_field.dart';
import 'signup_screen.dart';
import '../../../../core/widgets/app_drawer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() { _email.dispose(); _pass.dispose(); super.dispose(); }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {}); // loading
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Calcetto Manager'), actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () => _scaffoldKey.currentState!.openEndDrawer())]),
      endDrawer: const AppDrawer(),
      body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _formKey, child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 48),
        Image.asset('logo.png', height: 120, width: 120, errorBuilder: (_, __, ___) => Icon(Icons.sports_soccer, size: 80, color: cs.primary)),
        const SizedBox(height: 24),
        Text('Calcetto Manager', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        const SizedBox(height: 48),
        TextFormField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: InputDecoration(labelText: 'Email', prefixIcon: const Icon(Icons.email), border: const OutlineInputBorder(), filled: true, fillColor: cs.surface), validator: (v) => v == null || v.isEmpty ? 'Required' : !v.contains('@') ? 'Invalid' : null),
        const SizedBox(height: 16),
        PasswordField(controller: _pass, labelText: 'Password', textInputAction: TextInputAction.done, validator: (v) => v == null || v.isEmpty ? 'Required' : null),
        const SizedBox(height: 24),
        FilledButton(onPressed: _login, child: const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Text('Sign In'))),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("Don't have an account? "), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())), child: const Text('Sign Up'))]),
      ])))),
    );
  }
}
