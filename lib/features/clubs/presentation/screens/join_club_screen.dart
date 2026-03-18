import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injection.dart';
import '../providers/clubs_list_provider.dart';
import '../providers/active_club_provider.dart';

/// Screen for joining a club using an invite code.
class JoinClubScreen extends ConsumerStatefulWidget {
  final String? initialCode;

  const JoinClubScreen({
    super.key,
    this.initialCode,
  });

  @override
  ConsumerState<JoinClubScreen> createState() => _JoinClubScreenState();
}

class _JoinClubScreenState extends ConsumerState<JoinClubScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    if (widget.initialCode != null) {
      _codeController.text = widget.initialCode!;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _joinClub() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      setState(() => _error = 'Inserisci un codice invito');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = ref.read(clubsRepositoryProvider);
      final result = await repository.joinClub(code);

      result.fold(
        (failure) {
          setState(() {
            _error = failure.toString();
            _isLoading = false;
          });
        },
        (club) async {
          // Refresh clubs list
          await ref.read(clubsListProvider.notifier).refresh();
          // Set joined club as active
          await ref.read(activeClubProvider.notifier).setActiveClub(club.id);

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ti sei unito a "${club.name}"!'),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
      );
    } catch (e) {
      setState(() {
        _error = 'Errore: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unisciti a un Club'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Inserisci il codice invito che hai ricevuto',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Il codice dovrebbe avere il formato: INV_XXXXXXXX_XXXXXX',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Codice Invito',
                hintText: 'INV_...',
                prefixIcon: const Icon(Icons.key),
                errorText: _error,
                border: const OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
              onSubmitted: (_) => _joinClub(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _isLoading ? null : _joinClub,
                icon: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.group_add),
                label: Text(
                    _isLoading ? 'Unione in corso...' : 'Unisciti al Club'),
              ),
            ),
            if (widget.initialCode != null) ...[
              const SizedBox(height: 16),
              Text(
                'Codice precompilato dal link',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
