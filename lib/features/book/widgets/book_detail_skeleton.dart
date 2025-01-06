import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailSkeleton extends StatelessWidget {
  const BookDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // * Picture
          ClipRRect(
            child: Image.network(
              'https://i.pinimg.com/236x/64/2e/96/642e9610c5c587767430bf6a9deeff7c.jpg',
              fit: BoxFit.contain,
              width: double.infinity,
              height: 250,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://i.pinimg.com/236x/64/2e/96/642e9610c5c587767430bf6a9deeff7c.jpg',
                  fit: BoxFit.contain,
                );
              },
              cacheWidth: 300,
              cacheHeight: 250,
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // * Title
                Text(
                  BoneMock.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),

                // * Author
                Text(
                  BoneMock.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 4),

                // * Publisher
                Text(
                  BoneMock.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),

                // * Description title
                Text(
                  BoneMock.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),

                // * Description content
                Text(
                  BoneMock.paragraph,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 24),

                // * Suggestion title
                Text(
                  BoneMock.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
