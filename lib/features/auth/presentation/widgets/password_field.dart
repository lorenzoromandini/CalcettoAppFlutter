import 'package:flutter/material.dart';

/// Password input field with visibility toggle.
///
/// Material 3 styled TextField with eye icon to show/hide password.
class PasswordField extends StatelessWidget {
  /// Controller for the text field.
  final TextEditingController? controller;

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

  /// Whether to obscure the text.
  final bool obscureText;

  /// Callback to toggle visibility.
  final VoidCallback? onToggleVisibility;

  const PasswordField({
    super.key,
    this.controller,
    this.errorText,
    this.onChanged,
    this.labelText = 'Password',
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = true,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: onToggleVisibility,
          tooltip: obscureText ? 'Show password' : 'Hide password',
        ),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: colorScheme.surface,
      ),
    );
  }
}
