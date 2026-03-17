import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../clubs/domain/entities/club.dart';
import '../../../clubs/domain/entities/club_privilege.dart';
import '../../../clubs/presentation/providers/active_club_provider.dart';
import '../../../clubs/presentation/providers/clubs_list_provider.dart';
import '../../../clubs/presentation/widgets/role_icon.dart';

/// Active club header widget showing current club context with dropdown.
///
/// Features:
/// - Club logo (40px, circular)
/// - Club name (titleMedium, bold)
/// - User's role with role icon
/// - Dropdown menu button to switch clubs
/// - Material 3 card style
class ActiveClubHeader extends ConsumerWidget {
  final Club club;

  const ActiveClubHeader({
    super.key,
    required this.club,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final clubsAsync = ref.watch(clubsListProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      child: PopupMenuButton<Club>(
        offset: const Offset(0, 60),
        onSelected: (selectedClub) {
          ref.read(activeClubProvider.notifier).setActiveClub(selectedClub.id);
        },
        itemBuilder: (context) {
          return clubsAsync.when(
            data: (clubs) {
              if (clubs.isEmpty) {
                return [
                  const PopupMenuItem<Club>(
                    enabled: false,
                    child: Text('Nessun club disponibile'),
                  ),
                ];
              }
              return clubs.map((c) {
                final isActive = c.id == club.id;
                return PopupMenuItem<Club>(
                  value: c,
                  child: Row(
                    children: [
                      Icon(
                        Icons.sports_soccer,
                        size: 20,
                        color: isActive ? theme.colorScheme.primary : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              c.name,
                              style: TextStyle(
                                fontWeight: isActive
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color:
                                    isActive ? theme.colorScheme.primary : null,
                              ),
                            ),
                            Text(
                              _getPrivilegeName(c.userPrivilege),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isActive)
                        Icon(
                          Icons.check,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                    ],
                  ),
                );
              }).toList();
            },
            loading: () => [
              const PopupMenuItem<Club>(
                enabled: false,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 12),
                    Text('Caricamento...'),
                  ],
                ),
              ),
            ],
            error: (_, __) => [
              const PopupMenuItem<Club>(
                enabled: false,
                child: Text('Errore caricamento'),
              ),
            ],
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Club logo
              ClipOval(
                child: Image.network(
                  club.logoUrl ?? '',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Club info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RoleIcon(privilege: club.userPrivilege, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          _getPrivilegeName(club.userPrivilege),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Dropdown arrow
              Icon(
                Icons.arrow_drop_down,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getPrivilegeName(ClubPrivilege privilege) {
    switch (privilege) {
      case ClubPrivilege.OWNER:
        return 'Proprietario';
      case ClubPrivilege.MANAGER:
        return 'Manager';
      case ClubPrivilege.MEMBER:
        return 'Membro';
    }
  }
}
