import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/presentation/providers/deleted_clubs_provider.dart';

/// Screen for viewing and recovering deleted clubs.
///
/// Shows clubs that have been soft-deleted within the last 30 days.
/// Only accessible to club owners.
class DeletedClubsScreen extends ConsumerWidget {
  const DeletedClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final deletedClubsAsync = ref.watch(deletedClubsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Eliminati'),
      ),
      body: deletedClubsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Errore nel caricamento',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {
                  ref.invalidate(deletedClubsProvider);
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Riprova'),
              ),
            ],
          ),
        ),
        data: (clubs) => _buildClubsList(context, ref, clubs),
      ),
    );
  }

  Widget _buildClubsList(
      BuildContext context, WidgetRef ref, List<Club> clubs) {
    final theme = Theme.of(context);

    if (clubs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              size: 80,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              'Nessun club eliminato',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'I club eliminati rimangono recuperabili\nper 30 giorni',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(deletedClubsProvider);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          return _DeletedClubCard(
            club: club,
            onRecover: () => _showRecoverDialog(context, ref, club),
          );
        },
      ),
    );
  }

  Future<void> _showRecoverDialog(
      BuildContext context, WidgetRef ref, Club club) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.restore,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Ripristina Club'),
          ],
        ),
        content: Text(
          'Sei sicuro di voler ripristinare "${club.name}"?\n\n'
          'Tutti i membri e i dati del club saranno recuperati.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.restore),
            label: const Text('Ripristina'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await ref.read(recoverClubProvider(club.id).future);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Club "${club.name}" ripristinato con successo!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Errore: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }
}

class _DeletedClubCard extends StatelessWidget {
  final Club club;
  final VoidCallback onRecover;

  const _DeletedClubCard({
    required this.club,
    required this.onRecover,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          backgroundImage:
              club.logoUrl != null ? NetworkImage(club.logoUrl!) : null,
          child: club.logoUrl == null
              ? Icon(
                  Icons.sports_soccer,
                  color: theme.colorScheme.onSurfaceVariant,
                )
              : null,
        ),
        title: Text(
          club.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Eliminato il ${_formatDate(club.deletedAt!)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _getTimeRemaining(club.deletedAt!),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: FilledButton.icon(
          onPressed: onRecover,
          icon: const Icon(Icons.restore, size: 18),
          label: const Text('Ripristina'),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _getTimeRemaining(DateTime deletedAt) {
    final recoveryDeadline = deletedAt.add(const Duration(days: 30));
    final now = DateTime.now();
    final remaining = recoveryDeadline.difference(now);

    if (remaining.inDays > 0) {
      return '${remaining.inDays} giorni rimanenti';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours} ore rimanenti';
    } else {
      return 'Scade a breve';
    }
  }
}
