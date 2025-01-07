import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/profile/enums/profile_operation_type.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:book_app_basic_arch/features/profile/widgets/profile_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ProfileProvider>().getUserProfile();
    });

    return StyledScreenLayoutBuilder(
      sliverAppBar: const StyledSliverAppBar(title: Text('Profile')),
      builder: (builder, controller) {
        return [
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              final isLoadingProfile = profileProvider
                  .isLoading(ProfileOperationType.getUserProfile);
              final errorMessageProfile =
                  profileProvider.getError(ProfileOperationType.getUserProfile);
              final userProfile = profileProvider.userProfile;

              if (isLoadingProfile) {
                return const SliverToBoxAdapter(child: ProfileSkeleton());
              }

              if (errorMessageProfile != null) {
                return SliverFillRemaining(
                  child: StyledErrorMessage(
                    errorMessage: errorMessageProfile,
                    onRetry: () {
                      context.read<ProfileProvider>().getUserProfile();
                    },
                  ),
                );
              }

              if (userProfile == null) {
                return const SliverFillRemaining(
                  child: StyledEmptyData(message: 'Profile not found'),
                );
              }

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // * Avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          userProfile.profilePicture,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // * Name and Email
                      Text(
                        userProfile.username,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userProfile.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
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
                                  'Age: ${userProfile.userProfile?.age ?? 'unknown'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
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
                                    userProfile.userProfile?.bio ??
                                        'add your bio',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
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

                      // * Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: StyledButton(
                              onPressed: () {
                                context.push('/profile/update');
                              },
                              child: const Text('Update'),
                            ),
                          ),
                          StyledButton(
                            onPressed: () {
                              context.read<AuthProvider>().signOut();
                            },
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ];
      },
    );
  }
}
