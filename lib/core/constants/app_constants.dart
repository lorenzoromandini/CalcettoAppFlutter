/// Application-wide constants.
class AppConstants {
  AppConstants._();

  // API Configuration
  static const String apiBaseUrl =
      'https://api.calcetto.com'; // TODO: Replace with actual API URL

  // Storage Keys
  static const String jwtTokenKey = 'jwt_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String biometricEnabledKey = 'biometric_enabled';

  // Hive Box Names
  static const String authBoxName = 'auth';
  static const String cacheBoxName = 'cache';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Cache Durations
  static const Duration shortCache = Duration(minutes: 5);
  static const Duration mediumCache = Duration(hours: 1);
  static const Duration longCache = Duration(hours: 24);
}
