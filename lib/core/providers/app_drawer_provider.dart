import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for app drawer visibility state.
final appDrawerVisibleProvider = StateProvider<bool>((ref) => false);
