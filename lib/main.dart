import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app/app.dart';
import 'core/constants/app_constants.dart';
import 'features/clubs/data/models/club_model.dart';
import 'features/clubs/data/models/member_model.dart';
import 'features/clubs/domain/entities/club_privilege.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();

    // Register Hive adapters for clubs feature
    Hive.registerAdapter(ClubModelAdapter());
    Hive.registerAdapter(ClubPrivilegeAdapter());
    Hive.registerAdapter(MemberModelAdapter());
    Hive.registerAdapter(MemberStatsModelAdapter());

    // Open Hive boxes needed for app (clubs cache, etc.)
    // Note: Auth tokens use localStorage on web, not Hive
    await Future.wait([
      Hive.openBox(AppConstants.authBoxName),
      Hive.openBox(AppConstants.cacheBoxName),
    ]);
  } catch (e) {
    // On web, Hive might not be available - continue anyway
  }

  runApp(const ProviderScope(child: CalcettoApp()));
}
// Force rebuild
