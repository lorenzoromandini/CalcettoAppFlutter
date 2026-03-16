import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:calcetto_app/features/clubs/domain/entities/club_privilege.dart';
import 'package:calcetto_app/features/clubs/presentation/providers/invite_code_provider.dart';
import '../../../../core/providers/offline_status_provider.dart';

/// Invite code generator widget for admin users.
///
/// Features:
/// - Admin-only visibility (OWNER or MANAGER)
/// - Generate 8-char alphanumeric codes
/// - Share via native share sheet
/// - Copy to clipboard
/// - One-time use warning
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
    final theme = Theme.of(context);

    return FilledButton.icon(
      onPressed: isOffline
          ? null
          : () {
              notifier.generate(clubId, userPrivilege);
            },
      icon: const Icon(Icons.add_link),
      label: const Text('Generate Invite Code'),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    );
  }

  Widget _buildGeneratedState(
      BuildContext context, String code, InviteCodeNotifier notifier) {
    final theme = Theme.of(context);

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
          // Code display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _formatCode(code),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Code copied to clipboard'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.copy),
                  tooltip: 'Copy to clipboard',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Action buttons
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _shareCode(context, code),
                  icon: const Icon(Icons.share),
                  label: const Text('Condividi'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: code.isNotEmpty
                      ? () => _shareWhatsApp(context, code)
                      : null,
                  icon: const Icon(Icons.chat),
                  label: const Text('WhatsApp'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: code));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Codice copiato!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copia codice'),
              ),
              if (code.isNotEmpty) ...[
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: notifier.clear,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Nuovo'),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          // Security notes
          Text(
            '⚠️ This code can only be used once',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Share privately with trusted people',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          Text(
            'Expires: Never',
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
                  'Failed to generate code',
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
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareCode(BuildContext context, String code) async {
    final renderBox = context.findRenderObject() as RenderBox?;

    // Create invite link (web URL format)
    final inviteLink = 'https://calcetto.app/join?code=$code';

    // Share with share_plus (includes WhatsApp, etc.)
    await Share.share(
      'Unisciti al nostro club di calcetto! Usa questo link: $inviteLink\nOppure codice: $code',
      subject: 'Invito al Calcio a 5',
      sharePositionOrigin: _getSharePositionOrigin(renderBox),
    );
  }

  Future<void> _shareWhatsApp(BuildContext context, String code) async {
    final inviteLink = 'https://calcetto.app/join?code=$code';
    final message =
        'Unisciti al nostro club di calcetto! Usa questo link: $inviteLink';

    // WhatsApp URL scheme
    final whatsappUrl = 'https://wa.me/?text=${Uri.encodeComponent(message)}';

    try {
      // Try to launch WhatsApp
      await Share.share(
        message,
        subject: 'Invito al Calcio a 5',
      );
    } catch (e) {
      // Fallback: copy to clipboard
      await Clipboard.setData(ClipboardData(text: inviteLink));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Link copiato! Incolla su WhatsApp'),
            action: SnackBarAction(
              label: 'Apri WA',
              onPressed: () {
                // Would need url_launcher package for direct WhatsApp
              },
            ),
          ),
        );
      }
    }
  }

  Rect? _getSharePositionOrigin(RenderBox? renderBox) {
    if (renderBox != null) {
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);
      return Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height / 3);
    }
    return null;
  }

  String _formatCode(String code) {
    // Format as XXXX-XXXX for better readability
    if (code.length == 8) {
      return '${code.substring(0, 4)}-${code.substring(4)}';
    }
    return code.toUpperCase();
  }
}
