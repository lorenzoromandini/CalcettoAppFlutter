import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';
import 'package:calcetto_app/features/clubs/presentation/providers/invite_code_provider.dart';
import '../../../../core/providers/offline_status_provider.dart';

/// Invite code generator widget for admin users.
///
/// Features:
/// - Admin-only visibility (OWNER or MANAGER)
/// - Generate invite codes
/// - Show popup with link, copy button, and WhatsApp share
class InviteCodeGenerator extends ConsumerWidget {
  final String clubId;
  final ClubPrivilege userPrivilege;

  const InviteCodeGenerator({
    super.key,
    required this.clubId,
    required this.userPrivilege,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Only show for admins
    if (!userPrivilege.isAdmin) {
      return _buildNonAdminMessage(context);
    }

    final isOffline = ref.watch(isOfflineProvider);
    final inviteCodeAsync = ref.watch(inviteCodeProvider);
    final notifier = ref.read(inviteCodeProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isOffline) _buildOfflineMessage(context),
        Opacity(
          opacity: isOffline ? 0.5 : 1.0,
          child: IgnorePointer(
            ignoring: isOffline,
            child: inviteCodeAsync.when(
              loading: () => _buildLoadingState(context),
              error: (error, stack) =>
                  _buildErrorState(context, error.toString(), notifier),
              data: (code) => code != null
                  ? _buildGeneratedState(context, code, notifier)
                  : _buildNotGeneratedState(context, notifier, isOffline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineMessage(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.cloud_off,
            color: Colors.orange,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Connect to internet to generate invite codes',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNonAdminMessage(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Contact an admin to invite members',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildNotGeneratedState(
      BuildContext context, InviteCodeNotifier notifier, bool isOffline) {
    return FilledButton.icon(
      onPressed: isOffline
          ? null
          : () {
              notifier.generate(clubId, userPrivilege);
            },
      icon: const Icon(Icons.add_link),
      label: const Text('Genera Link Invito'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }

  Widget _buildGeneratedState(
      BuildContext context, String code, InviteCodeNotifier notifier) {
    final theme = Theme.of(context);
    final inviteLink = 'http://localhost:8083/join?code=$code';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Link field with copy and WhatsApp buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    inviteLink,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: 'monospace',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Copy button
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: inviteLink));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Link copiato!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copia link',
                ),
                // WhatsApp button
                GestureDetector(
                  onTap: () => _openWhatsApp(context, inviteLink),
                  child: Container(
                    width: 28,
                    height: 28,
                    margin: const EdgeInsets.only(left: 8),
                    child: Image.asset(
                      'assets/icons/whatsapp.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Generate new code button
          OutlinedButton.icon(
            onPressed: notifier.clear,
            icon: const Icon(Icons.refresh),
            label: const Text('Genera nuovo link'),
          ),
          const SizedBox(height: 12),
          // Info notes
          Text(
            '✓ Questo link può essere usato da più persone',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '⏰ Scade tra 7 giorni',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
      BuildContext context, String error, InviteCodeNotifier notifier) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.onErrorContainer,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Errore nella generazione',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () {
              notifier.generate(clubId, userPrivilege);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Riprova'),
          ),
        ],
      ),
    );
  }

  void _openWhatsApp(BuildContext context, String inviteLink) {
    final message = 'Unisciti al nostro club di calcetto! $inviteLink';
    final whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    // Open WhatsApp URL in new tab (works on mobile and desktop)
    // On mobile, this opens the WhatsApp app
    // On desktop, this opens WhatsApp Web
    js.context.callMethod('open', [whatsappUrl, '_blank']);
  }
}
