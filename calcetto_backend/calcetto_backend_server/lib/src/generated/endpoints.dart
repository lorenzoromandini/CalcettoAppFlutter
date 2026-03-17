/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth_endpoint.dart' as _i2;
import '../clubs_endpoint.dart' as _i3;
import '../matches_endpoint.dart' as _i4;
import '../ratings_endpoint.dart' as _i5;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'auth': _i2.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'clubs': _i3.ClubsEndpoint()
        ..initialize(
          server,
          'clubs',
          null,
        ),
      'matches': _i4.MatchesEndpoint()
        ..initialize(
          server,
          'matches',
          null,
        ),
      'ratings': _i5.RatingsEndpoint()
        ..initialize(
          server,
          'ratings',
          null,
        ),
    };
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).login(
            session,
            params['email'],
            params['password'],
          ),
        ),
        'signup': _i1.MethodConnector(
          name: 'signup',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'nickname': _i1.ParameterDescription(
              name: 'nickname',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).signup(
            session,
            params['email'],
            params['password'],
            params['firstName'],
            params['lastName'],
            params['nickname'],
            params['imageUrl'],
          ),
        ),
        'getCurrentUser': _i1.MethodConnector(
          name: 'getCurrentUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i2.AuthEndpoint).getCurrentUser(session),
        ),
      },
    );
    connectors['clubs'] = _i1.EndpointConnector(
      name: 'clubs',
      endpoint: endpoints['clubs']!,
      methodConnectors: {
        'getClubs': _i1.MethodConnector(
          name: 'getClubs',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).getClubs(session),
        ),
        'getClubById': _i1.MethodConnector(
          name: 'getClubById',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).getClubById(
            session,
            params['id'],
          ),
        ),
        'getClubMembers': _i1.MethodConnector(
          name: 'getClubMembers',
          params: {
            'clubIdStr': _i1.ParameterDescription(
              name: 'clubIdStr',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).getClubMembers(
            session,
            params['clubIdStr'],
          ),
        ),
        'generateInviteCode': _i1.MethodConnector(
          name: 'generateInviteCode',
          params: {
            'clubIdStr': _i1.ParameterDescription(
              name: 'clubIdStr',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).generateInviteCode(
            session,
            params['clubIdStr'],
          ),
        ),
        'deleteClub': _i1.MethodConnector(
          name: 'deleteClub',
          params: {
            'clubIdStr': _i1.ParameterDescription(
              name: 'clubIdStr',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).deleteClub(
            session,
            params['clubIdStr'],
          ),
        ),
        'createClub': _i1.MethodConnector(
          name: 'createClub',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['clubs'] as _i3.ClubsEndpoint).createClub(
            session,
            params['name'],
            params['description'],
            params['imageUrl'],
          ),
        ),
      },
    );
    connectors['matches'] = _i1.EndpointConnector(
      name: 'matches',
      endpoint: endpoints['matches']!,
      methodConnectors: {
        'getClubMatches': _i1.MethodConnector(
          name: 'getClubMatches',
          params: {
            'clubIdStr': _i1.ParameterDescription(
              name: 'clubIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).getClubMatches(
            session,
            params['clubIdStr'],
            status: params['status'],
          ),
        ),
        'getMatchById': _i1.MethodConnector(
          name: 'getMatchById',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).getMatchById(
            session,
            params['matchIdStr'],
          ),
        ),
        'createMatch': _i1.MethodConnector(
          name: 'createMatch',
          params: {
            'clubIdStr': _i1.ParameterDescription(
              name: 'clubIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'scheduledAt': _i1.ParameterDescription(
              name: 'scheduledAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'location': _i1.ParameterDescription(
              name: 'location',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'modeStr': _i1.ParameterDescription(
              name: 'modeStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).createMatch(
            session,
            params['clubIdStr'],
            params['scheduledAt'],
            params['location'],
            params['modeStr'],
          ),
        ),
        'updateMatchStatus': _i1.MethodConnector(
          name: 'updateMatchStatus',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'statusStr': _i1.ParameterDescription(
              name: 'statusStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).updateMatchStatus(
            session,
            params['matchIdStr'],
            params['statusStr'],
          ),
        ),
        'updateScore': _i1.MethodConnector(
          name: 'updateScore',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'homeScore': _i1.ParameterDescription(
              name: 'homeScore',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'awayScore': _i1.ParameterDescription(
              name: 'awayScore',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).updateScore(
            session,
            params['matchIdStr'],
            params['homeScore'],
            params['awayScore'],
          ),
        ),
        'getMatchParticipants': _i1.MethodConnector(
          name: 'getMatchParticipants',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint)
                  .getMatchParticipants(
            session,
            params['matchIdStr'],
          ),
        ),
        'addParticipant': _i1.MethodConnector(
          name: 'addParticipant',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clubMemberIdStr': _i1.ParameterDescription(
              name: 'clubMemberIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'teamSideStr': _i1.ParameterDescription(
              name: 'teamSideStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'positionStr': _i1.ParameterDescription(
              name: 'positionStr',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).addParticipant(
            session,
            params['matchIdStr'],
            params['clubMemberIdStr'],
            params['teamSideStr'],
            params['positionStr'],
          ),
        ),
        'removeParticipant': _i1.MethodConnector(
          name: 'removeParticipant',
          params: {
            'participantIdStr': _i1.ParameterDescription(
              name: 'participantIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['matches'] as _i4.MatchesEndpoint).removeParticipant(
            session,
            params['participantIdStr'],
          ),
        ),
      },
    );
    connectors['ratings'] = _i1.EndpointConnector(
      name: 'ratings',
      endpoint: endpoints['ratings']!,
      methodConnectors: {
        'getMatchRatings': _i1.MethodConnector(
          name: 'getMatchRatings',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ratings'] as _i5.RatingsEndpoint).getMatchRatings(
            session,
            params['matchIdStr'],
          ),
        ),
        'getPlayerRating': _i1.MethodConnector(
          name: 'getPlayerRating',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clubMemberIdStr': _i1.ParameterDescription(
              name: 'clubMemberIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ratings'] as _i5.RatingsEndpoint).getPlayerRating(
            session,
            params['matchIdStr'],
            params['clubMemberIdStr'],
          ),
        ),
        'ratePlayer': _i1.MethodConnector(
          name: 'ratePlayer',
          params: {
            'matchIdStr': _i1.ParameterDescription(
              name: 'matchIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'clubMemberIdStr': _i1.ParameterDescription(
              name: 'clubMemberIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'rating': _i1.ParameterDescription(
              name: 'rating',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'comment': _i1.ParameterDescription(
              name: 'comment',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ratings'] as _i5.RatingsEndpoint).ratePlayer(
            session,
            params['matchIdStr'],
            params['clubMemberIdStr'],
            params['rating'],
            params['comment'],
          ),
        ),
        'getPlayerAverageRating': _i1.MethodConnector(
          name: 'getPlayerAverageRating',
          params: {
            'clubMemberIdStr': _i1.ParameterDescription(
              name: 'clubMemberIdStr',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ratings'] as _i5.RatingsEndpoint)
                  .getPlayerAverageRating(
            session,
            params['clubMemberIdStr'],
          ),
        ),
        'getRatingsByUser': _i1.MethodConnector(
          name: 'getRatingsByUser',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ratings'] as _i5.RatingsEndpoint)
                  .getRatingsByUser(session),
        ),
      },
    );
  }
}
