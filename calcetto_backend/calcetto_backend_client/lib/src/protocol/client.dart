/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:calcetto_backend_client/src/protocol/user.dart' as _i3;
import 'package:calcetto_backend_client/src/protocol/club.dart' as _i4;
import 'package:calcetto_backend_client/src/protocol/match.dart' as _i5;
import 'package:calcetto_backend_client/src/protocol/match_participant.dart'
    as _i6;
import 'package:calcetto_backend_client/src/protocol/player_rating.dart' as _i7;
import 'protocol.dart' as _i8;

/// Authentication endpoint - handles login and signup with secure password hashing
/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Authenticates user with email and password
  _i2.Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  /// Register new user with hashed password
  _i2.Future<Map<String, dynamic>> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String? nickname,
    String? imageUrl,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'auth',
        'signup',
        {
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName,
          'nickname': nickname,
          'imageUrl': imageUrl,
        },
      );

  /// Get current authenticated user
  _i2.Future<_i3.User?> getCurrentUser() =>
      caller.callServerEndpoint<_i3.User?>(
        'auth',
        'getCurrentUser',
        {},
      );

  /// Logout current user
  /// Returns success message
  _i2.Future<Map<String, dynamic>> logout() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'auth',
        'logout',
        {},
      );

  /// Update user profile
  _i2.Future<Map<String, dynamic>> updateProfile(
    String firstName,
    String lastName,
    String? nickname,
    String? password,
  ) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'auth',
        'updateProfile',
        {
          'firstName': firstName,
          'lastName': lastName,
          'nickname': nickname,
          'password': password,
        },
      );
}

/// {@category Endpoint}
class EndpointClubs extends _i1.EndpointRef {
  EndpointClubs(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'clubs';

  _i2.Future<List<Map<String, dynamic>>> getClubs() =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'clubs',
        'getClubs',
        {},
      );

  _i2.Future<Map<String, dynamic>?> getClubById(String? id) =>
      caller.callServerEndpoint<Map<String, dynamic>?>(
        'clubs',
        'getClubById',
        {'id': id},
      );

  _i2.Future<List<Map<String, dynamic>>> getClubMembers(String? clubIdStr) =>
      caller.callServerEndpoint<List<Map<String, dynamic>>>(
        'clubs',
        'getClubMembers',
        {'clubIdStr': clubIdStr},
      );

  _i2.Future<Map<String, dynamic>> generateInviteCode(String? clubIdStr) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'clubs',
        'generateInviteCode',
        {'clubIdStr': clubIdStr},
      );

  _i2.Future<void> deleteClub(String? clubIdStr) =>
      caller.callServerEndpoint<void>(
        'clubs',
        'deleteClub',
        {'clubIdStr': clubIdStr},
      );

  _i2.Future<_i4.Club> createClub(
    String name,
    String? description,
    String? imageUrl,
  ) =>
      caller.callServerEndpoint<_i4.Club>(
        'clubs',
        'createClub',
        {
          'name': name,
          'description': description,
          'imageUrl': imageUrl,
        },
      );
}

/// {@category Endpoint}
class EndpointMatches extends _i1.EndpointRef {
  EndpointMatches(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'matches';

  /// Get all matches for a club
  _i2.Future<List<_i5.Match>> getClubMatches(
    String clubIdStr, {
    String? status,
  }) =>
      caller.callServerEndpoint<List<_i5.Match>>(
        'matches',
        'getClubMatches',
        {
          'clubIdStr': clubIdStr,
          'status': status,
        },
      );

  /// Get match by ID
  _i2.Future<_i5.Match?> getMatchById(String matchIdStr) =>
      caller.callServerEndpoint<_i5.Match?>(
        'matches',
        'getMatchById',
        {'matchIdStr': matchIdStr},
      );

  /// Create a new match
  _i2.Future<_i5.Match> createMatch(
    String clubIdStr,
    DateTime scheduledAt,
    String? location,
    String modeStr,
  ) =>
      caller.callServerEndpoint<_i5.Match>(
        'matches',
        'createMatch',
        {
          'clubIdStr': clubIdStr,
          'scheduledAt': scheduledAt,
          'location': location,
          'modeStr': modeStr,
        },
      );

  /// Update match status
  _i2.Future<_i5.Match> updateMatchStatus(
    String matchIdStr,
    String statusStr,
  ) =>
      caller.callServerEndpoint<_i5.Match>(
        'matches',
        'updateMatchStatus',
        {
          'matchIdStr': matchIdStr,
          'statusStr': statusStr,
        },
      );

  /// Update match score
  _i2.Future<_i5.Match> updateScore(
    String matchIdStr,
    int homeScore,
    int awayScore,
  ) =>
      caller.callServerEndpoint<_i5.Match>(
        'matches',
        'updateScore',
        {
          'matchIdStr': matchIdStr,
          'homeScore': homeScore,
          'awayScore': awayScore,
        },
      );

  /// Get match participants
  _i2.Future<List<_i6.MatchParticipant>> getMatchParticipants(
          String matchIdStr) =>
      caller.callServerEndpoint<List<_i6.MatchParticipant>>(
        'matches',
        'getMatchParticipants',
        {'matchIdStr': matchIdStr},
      );

  /// Add participant to match
  _i2.Future<_i6.MatchParticipant> addParticipant(
    String matchIdStr,
    String clubMemberIdStr,
    String teamSideStr,
    String? positionStr,
  ) =>
      caller.callServerEndpoint<_i6.MatchParticipant>(
        'matches',
        'addParticipant',
        {
          'matchIdStr': matchIdStr,
          'clubMemberIdStr': clubMemberIdStr,
          'teamSideStr': teamSideStr,
          'positionStr': positionStr,
        },
      );

  /// Remove participant from match
  _i2.Future<void> removeParticipant(String participantIdStr) =>
      caller.callServerEndpoint<void>(
        'matches',
        'removeParticipant',
        {'participantIdStr': participantIdStr},
      );
}

/// {@category Endpoint}
class EndpointRatings extends _i1.EndpointRef {
  EndpointRatings(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ratings';

  /// Get all ratings for a match
  _i2.Future<List<_i7.PlayerRating>> getMatchRatings(String matchIdStr) =>
      caller.callServerEndpoint<List<_i7.PlayerRating>>(
        'ratings',
        'getMatchRatings',
        {'matchIdStr': matchIdStr},
      );

  /// Get rating for a specific player in a match
  _i2.Future<_i7.PlayerRating?> getPlayerRating(
    String matchIdStr,
    String clubMemberIdStr,
  ) =>
      caller.callServerEndpoint<_i7.PlayerRating?>(
        'ratings',
        'getPlayerRating',
        {
          'matchIdStr': matchIdStr,
          'clubMemberIdStr': clubMemberIdStr,
        },
      );

  /// Add or update a player rating
  _i2.Future<_i7.PlayerRating> ratePlayer(
    String matchIdStr,
    String clubMemberIdStr,
    double rating,
    String? comment,
  ) =>
      caller.callServerEndpoint<_i7.PlayerRating>(
        'ratings',
        'ratePlayer',
        {
          'matchIdStr': matchIdStr,
          'clubMemberIdStr': clubMemberIdStr,
          'rating': rating,
          'comment': comment,
        },
      );

  /// Get average rating for a player across all matches
  _i2.Future<Map<String, dynamic>> getPlayerAverageRating(
          String clubMemberIdStr) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'ratings',
        'getPlayerAverageRating',
        {'clubMemberIdStr': clubMemberIdStr},
      );

  /// Get all ratings given by a user
  _i2.Future<List<_i7.PlayerRating>> getRatingsByUser() =>
      caller.callServerEndpoint<List<_i7.PlayerRating>>(
        'ratings',
        'getRatingsByUser',
        {},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i8.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    clubs = EndpointClubs(this);
    matches = EndpointMatches(this);
    ratings = EndpointRatings(this);
  }

  late final EndpointAuth auth;

  late final EndpointClubs clubs;

  late final EndpointMatches matches;

  late final EndpointRatings ratings;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'clubs': clubs,
        'matches': matches,
        'ratings': ratings,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
