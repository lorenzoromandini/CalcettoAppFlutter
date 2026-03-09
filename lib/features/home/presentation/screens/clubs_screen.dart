import 'package:flutter/material.dart';
import '../../../clubs/presentation/screens/clubs_list_screen.dart';

/// Clubs screen - wrapper for clubs list functionality.
///
/// Integrates with MainLayout navigation.
class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ClubsListScreen();
  }
}
