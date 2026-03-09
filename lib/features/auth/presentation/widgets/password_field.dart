import 'package:flutter/material.dart';

/// Password input field with visibility toggle.
///
/// Material 3 styled TextField with eye icon to show/hide password.
class PasswordField extends StatefulWidget {
  /// Controller for the text field.
  final TextEditingController controller;

  /// Optional error text to display.
  final String? errorText;

  /// Callback when text changes.
  final ValueChanged<String>? onChanged;

  /// Label text for the field.
  final String labelText;

  /// Hint text for the field.
  final String? hintText;

  /// TextInput action.
  final TextInputAction textInputAction;

  /// Validator function.
  final String? Function(String?)? validator;

  /// Callback when field is submitted.
  final ValueChanged<String>? onFieldSubmitted;

  const PasswordField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.labelText = 'Password',
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: _toggleVisibility,
          tooltip: _obscureText ? 'Show password' : 'Hide password',
        ),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: colorScheme.surface,
      ),
    );
  }
}
