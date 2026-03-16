import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/offline_indicator.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/domain/entities/club_privilege.dart';
import '../../../clubs/presentation/providers/clubs_list_provider.dart';

/// Screen for editing club information.
///
/// Only accessible to club OWNER and MANAGER.
/// Features:
/// - Edit club name
/// - Edit description
/// - Change logo (placeholder)
/// - Delete club option (OWNER only)
class EditClubScreen extends ConsumerStatefulWidget {
  final Club club;

  const EditClubScreen({
    super.key,
    required this.club,
  });

  @override
  ConsumerState<EditClubScreen> createState() => _EditClubScreenState();
}

class _EditClubScreenState extends ConsumerState<EditClubScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _nameController = TextEditingController(text: widget.club.name);
  late final _descriptionController =
      TextEditingController(text: widget.club.description ?? '');
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveClub() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // TODO: Implement club update
      await Future.delayed(const Duration(seconds: 1)); // Placeholder

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club aggiornato con successo!')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteClub() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Elimina Club'),
        content: const Text(
          'Sei sicuro di voler eliminare questo club? Questa azione non può essere annullata.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annulla'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Elimina'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(clubsListProvider.notifier).deleteClub(widget.club.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Club eliminato con successo')),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOwner = widget.club.userPrivilege == ClubPrivilege.OWNER;
    final canEdit = widget.club.userPrivilege.isAdmin;

    if (!canEdit) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Modifica Club'),
        ),
        body: const Center(
          child: Text('Solo admin possono modificare il club'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifica Club'),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: _isLoading ? null : _deleteClub,
              tooltip: 'Elimina club',
              color: theme.colorScheme.error,
            ),
        ],
      ),
      body: Column(
        children: [
          const OfflineIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Club Logo
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: theme.colorScheme.primaryContainer,
                            backgroundImage: widget.club.logoUrl != null
                                ? NetworkImage(widget.club.logoUrl!)
                                : null,
                            child: widget.club.logoUrl == null
                                ? Icon(
                                    Icons.sports_soccer,
                                    size: 60,
                                    color: theme.colorScheme.onPrimaryContainer,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: theme.colorScheme.primary,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, size: 20),
                                color: theme.colorScheme.onPrimary,
                                onPressed: () {
                                  // TODO: Implement image picker
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Coming soon')),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Club Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome Club *',
                        prefixIcon: Icon(Icons.group),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Il nome è obbligatorio';
                        }
                        if (value.trim().length < 3) {
                          return 'Minimo 3 caratteri';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrizione',
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                      maxLength: 200,
                    ),
                    const SizedBox(height: 32),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isLoading ? null : _saveClub,
                        icon: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(_isLoading ? 'Salvataggio...' : 'Salva'),
                      ),
                    ),

                    if (isOwner) ...[
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),

                      // Danger Zone
                      Text(
                        'Zona Pericolosa',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'L\'eliminazione del club è irreversibile. Tutti i dati verranno persi.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _isLoading ? null : _deleteClub,
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Elimina Club'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                            side: BorderSide(color: theme.colorScheme.error),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
