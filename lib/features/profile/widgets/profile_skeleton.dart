import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileSkeleton extends StatelessWidget {
  const ProfileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          // * Pakenya itu background image kalo circle avatar
          CircleAvatar(
            radius: 60,
          ),
          SizedBox(height: 16),

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
          SizedBox(height: 32),

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
    );
  }
}
