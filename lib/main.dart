import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app/app.dart';
import 'core/constants/app_constants.dart';
import 'features/clubs/data/models/club_model.dart';
import 'features/clubs/domain/entities/club.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    print('MAIN: Hive initialized');

    // Register Hive adapters for clubs feature
    Hive.registerAdapter(ClubModelAdapter());
    Hive.registerAdapter(ClubRoleAdapter());
    print('MAIN: Adapters registered');

    // Open Hive boxes needed for app (clubs cache, etc.)
    // Note: Auth tokens use localStorage on web, not Hive
    await Future.wait([
      Hive.openBox(AppConstants.authBoxName),
      Hive.openBox(AppConstants.cacheBoxName),
    ]);
    print('MAIN: Hive boxes opened for cache/auth data');

    // Check cookies for token (web only)
    if (kIsWeb) {
      final cookies = document.cookie;
      final hasToken = cookies?.contains('jwt_token=') ?? false;
      print(
          'MAIN: Cookie check - jwt_token ${hasToken ? "found" : "NOT found"}');
    }
    print('MAIN: All boxes opened');
  } catch (e) {
    // On web, Hive might not be available - continue anyway
    print('MAIN: Hive initialization error: $e');
  }

  runApp(const ProviderScope(child: CalcettoApp()));
}
