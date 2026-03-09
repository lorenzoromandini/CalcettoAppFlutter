import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app/app.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();

    // Open Hive boxes needed for app
    await Future.wait([
      Hive.openBox(AppConstants.authBoxName),
      Hive.openBox(AppConstants.cacheBoxName),
    ]);
  } catch (e) {
    // On web, Hive might not be available - continue anyway
    debugPrint('Hive initialization error (expected on web): $e');
  }

  runApp(const ProviderScope(child: CalcettoApp()));
}
