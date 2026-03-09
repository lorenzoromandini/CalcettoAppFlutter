import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Skeleton loading state for members grid.
///
/// Displays 8 placeholder cards with shimmer effect
/// matching the actual grid layout (2 columns, 0.7 aspect ratio).
class MembersGridSkeleton extends StatelessWidget {
  const MembersGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: theme.colorScheme.surfaceVariant,
            highlightColor: theme.colorScheme.onSurfaceVariant.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar placeholder
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurfaceVariant,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSurfaceVariant,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Name placeholder
                    Container(
                      width: double.infinity,
                      height: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 10,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const Spacer(),
                    // Stats placeholder
                    Container(
                      width: double.infinity,
                      height: 32,
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
