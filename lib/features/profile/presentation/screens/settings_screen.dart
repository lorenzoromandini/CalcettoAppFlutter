import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/logout_button.dart';
import '../../../auth/presentation/providers/biometric_provider.dart';

/// Settings screen with account and app preferences.
///
/// Contains logout functionality, biometric toggle, and settings options.
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final String _biometricType = 'Biometric';

  @override
  void initState() {
    super.initState();
    // Check biometric support on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(biometricEnabledProvider.notifier).checkBiometricSupport();
      // Determine biometric type label (simplified - in production would check platform)
      // For now use generic "Biometric" - could be enhanced with dart:io Platform check
    });
  }

  @override
  Widget build(BuildContext context) {
    final biometricStatus = ref.watch(biometricEnabledProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              // TODO: Show about dialog
            },
          ),
          const Divider(),
          // Biometric toggle section (only shown if device supports biometrics)
          if (biometricStatus != BiometricStatus.disabled) ...[
            const ListTile(
              title: Text(
                'Security',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
            if (biometricStatus == BiometricStatus.checking)
              ListTile(
                leading: const Icon(Icons.fingerprint),
                title: Text('$_biometricType Login'),
                subtitle: const Text('Checking availability...'),
                trailing: const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              SwitchListTile(
                secondary: const Icon(Icons.fingerprint),
                title: Text('$_biometricType Login'),
                subtitle: Text(
                  biometricStatus == BiometricStatus.enabled
                      ? 'Enabled'
                      : 'Disabled',
                ),
                value: biometricStatus == BiometricStatus.enabled,
                onChanged: (value) {
                  ref
                      .read(biometricEnabledProvider.notifier)
                      .toggleBiometric(value);
                },
              ),
            const Divider(),
          ],
          // Account section
          const ListTile(
            title: Text(
              'Account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const LogoutButton(),
        ],
      ),
    );
  }
}
