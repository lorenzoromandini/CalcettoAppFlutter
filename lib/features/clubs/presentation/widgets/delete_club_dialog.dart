import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calcetto_app/features/clubs/domain/repositories/clubs_repository.dart';
import 'package:calcetto_app/core/di/injection.dart';

/// Dialog for confirming club deletion.
///
/// Requires user to type the exact club name to enable deletion.
/// Only shown for club owners.
class DeleteClubDialog extends ConsumerStatefulWidget {
  final String clubId;
  final String clubName;

  const DeleteClubDialog({
    super.key,
    required this.clubId,
    required this.clubName,
  });

  @override
  ConsumerState<DeleteClubDialog> createState() => _DeleteClubDialogState();
}

class _DeleteClubDialogState extends ConsumerState<DeleteClubDialog> {
  final _textController = TextEditingController();
  bool _isLoading = false;
  String? _error;

  bool get _isDeleteEnabled => _textController.text == widget.clubName;

  Future<void> _handleDelete() async {
    if (!_isDeleteEnabled) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final repository = ref.read(clubsRepositoryProvider);
      final result = await repository.deleteClub(widget.clubId);

      result.fold(
        (error) {
          setState(() {
            _error = 'Errore: $error';
            _isLoading = false;
          });
        },
        (_) {
          if (mounted) {
            Navigator.of(context).pop(true); // Return success
          }
        },
      );
    } catch (e) {
      setState(() {
        _error = 'Errore imprevisto: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.delete_forever,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Text('Elimina club'),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sei sicuro di voler eliminare "${widget.clubName}"?',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Il club sarà nascosto ma potrai ripristinarlo entro 30 giorni.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Scrivi "${widget.clubName}" per confermare',
              hintText: widget.clubName,
              border: const OutlineInputBorder(),
              errorText: _error,
            ),
            onChanged: (_) => setState(() {}),
          ),
          if (_isLoading) ...[
            const SizedBox(height: 16),
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: const Text('Annulla'),
        ),
        FilledButton.icon(
          onPressed: _isLoading || !_isDeleteEnabled ? null : _handleDelete,
          icon: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.delete),
          label: Text(_isLoading ? 'Eliminazione...' : 'Elimina'),
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
        ),
      ],
    );
  }
}
