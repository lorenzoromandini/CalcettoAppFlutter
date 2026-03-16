import 'package:flutter/material.dart';
import '../../../../clubs/domain/entities/member.dart';

enum PlayerRole {
  por,
  dif,
  cen,
  att,
}

extension PlayerRoleExtension on PlayerRole {
  String get abbreviation {
    switch (this) {
      case PlayerRole.por:
        return 'POR';
      case PlayerRole.dif:
        return 'DIF';
      case PlayerRole.cen:
        return 'CEN';
      case PlayerRole.att:
        return 'ATT';
    }
  }

  IconData get icon {
    switch (this) {
      case PlayerRole.por:
        return Icons.back_hand;
      case PlayerRole.dif:
        return Icons.shield;
      case PlayerRole.cen:
        return Icons.activity;
      case PlayerRole.att:
        return Icons.target;
    }
  }
}

class PlayerCard extends StatelessWidget {
  final Member member;
  final String clubId;
  final VoidCallback? onClick;

  const PlayerCard({
    super.key,
    required this.member,
    required this.clubId,
    this.onClick,
  });

  String _getInitials() {
    final first = member.user?.firstName?.isNotEmpty == true
        ? member.user!.firstName![0]
        : '';
    final last = member.user?.lastName?.isNotEmpty == true
        ? member.user!.lastName![0]
        : '';

    if (first.isNotEmpty && last.isNotEmpty) {
      return '$first$last'.toUpperCase();
    } else if (first.isNotEmpty) {
      return first.toUpperCase();
    }

    return '?';
  }

  @override
  Widget build(BuildContext context) {
    final allRoles = [member.primaryRole, ...member.secondaryRoles];

    return GestureDetector(
      onTap: onClick,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.surface,
                  Theme.of(context).colorScheme.surface.withOpacity(0.95),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Player image or placeholder
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.05),
                          Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ],
                      ),
                    ),
                    child: member.user?.imageUrl != null
                        ? Image.network(
                            member.user!.imageUrl!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          )
                        : Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.1),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2),
                                  width: 4,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                _getInitials(),
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),

                // Gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Jersey number
                if (member.jerseyNumber > 0)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.6,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '#${member.jerseyNumber}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                // Player info at bottom
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          '${member.user?.firstName ?? ''} ${member.user?.lastName ?? ''}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: const Offset(1, 1),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Nickname
                        if (member.user?.nickname != null &&
                            member.user!.nickname!.isNotEmpty)
                          Text(
                            '"${member.user!.nickname}"',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                        // Roles
                        if (allRoles.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: allRoles.take(2).map((role) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      role.icon,
                                      size: 12,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      role.abbreviation,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          if (allRoles.length > 2)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '+${allRoles.length - 2}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
