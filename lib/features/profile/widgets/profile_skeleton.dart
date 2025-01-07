import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            // * Pakenya itu background image kalo circle avatar
            const CircleAvatar(
              radius: 60,
            ),
            const SizedBox(height: 16),

            Column(
              children: [
                Text(
                  BoneMock.time,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  BoneMock.time,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // * Age and Bio Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Age
                  Row(
                    children: [
                      Icon(Icons.cake, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Text(
                        BoneMock.title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Bio
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: Colors.grey[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          BoneMock.paragraph,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: StyledButton(
                    onPressed: () {},
                    child: Text(BoneMock.title),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: StyledButton(
                    onPressed: () {},
                    child: Text(BoneMock.title),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
