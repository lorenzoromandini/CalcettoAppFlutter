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
import 'package:calcetto_backend_client/src/protocol/authentication_response.dart'
    as _i3;
import 'package:calcetto_backend_client/src/protocol/club.dart' as _i4;
import 'package:calcetto_backend_client/src/protocol/club_member.dart' as _i5;
import 'package:calcetto_backend_client/src/protocol/greeting.dart' as _i6;
import 'protocol.dart' as _i7;

/// Authentication endpoint - handles login and signup
/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Authenticates user with email and password
  _i2.Future<_i3.AuthenticationResponse> login(
    String email,
    String password,
  ) =>
      caller.callServerEndpoint<_i3.AuthenticationResponse>(
        'auth',
        'login',
        {
          'email': email,
          'password': password,
        },
      );

  /// Register new user
  _i2.Future<_i3.AuthenticationResponse> signup(
    String email,
    String password,
    String firstName,
    String lastName,
    String? nickname,
    String? imageUrl,
  ) =>
      caller.callServerEndpoint<_i3.AuthenticationResponse>(
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
}

/// {@category Endpoint}
class EndpointClubs extends _i1.EndpointRef {
  EndpointClubs(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'clubs';

  _i2.Future<List<_i4.Club>> getClubs() =>
      caller.callServerEndpoint<List<_i4.Club>>(
        'clubs',
        'getClubs',
        {},
      );

  _i2.Future<_i4.Club?> getClubById(int? id) =>
      caller.callServerEndpoint<_i4.Club?>(
        'clubs',
        'getClubById',
        {'id': id},
      );

  _i2.Future<List<_i5.ClubMember>> getClubMembers(int? clubId) =>
      caller.callServerEndpoint<List<_i5.ClubMember>>(
        'clubs',
        'getClubMembers',
        {'clubId': clubId},
      );

  _i2.Future<Map<String, dynamic>> generateInviteCode(int? clubId) =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'clubs',
        'generateInviteCode',
        {'clubId': clubId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i6.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i6.Greeting>(
        'greeting',
        'hello',
        {'name': name},
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
          _i7.Protocol(),
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
    greeting = EndpointGreeting(this);
  }

  late final EndpointAuth auth;

  late final EndpointClubs clubs;

  late final EndpointGreeting greeting;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'clubs': clubs,
        'greeting': greeting,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
