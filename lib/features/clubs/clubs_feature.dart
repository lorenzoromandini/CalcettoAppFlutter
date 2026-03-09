// Clubs Feature Public API
//
// Export all public APIs for the clubs feature module.
// Other features should import from this file instead of internal paths.

// Domain layer
export 'domain/entities/club.dart';
export 'domain/entities/member.dart';
export 'domain/repositories/clubs_repository.dart';

// Data layer
export 'data/models/club_model.dart';
export 'data/models/member_model.dart';
export 'data/repositories/clubs_repository_impl.dart';

// Presentation layer - Providers
export 'presentation/providers/clubs_list_provider.dart';
export 'presentation/providers/active_club_provider.dart';

// Presentation layer - Screens
export 'presentation/screens/clubs_list_screen.dart';

// Presentation layer - Widgets
export 'presentation/widgets/clubs_list_skeleton.dart';
export 'presentation/widgets/club_list_item.dart';
export 'presentation/widgets/role_badge.dart';
