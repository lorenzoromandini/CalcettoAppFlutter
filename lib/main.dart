import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/app/app.dart';
import 'core/constants/app_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open Hive boxes needed for app
  await Future.wait([
    Hive.openBox(AppConstants.authBoxName),
    Hive.openBox(AppConstants.cacheBoxName),
  ]);

  // Initialize secure storage (singleton pattern)
  const FlutterSecureStorage();

  runApp(const CalcettoApp());
}
