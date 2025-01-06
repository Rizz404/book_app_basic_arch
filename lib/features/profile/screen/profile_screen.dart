import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
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
        sliverAppBar: StyledSliverAppBar(title: Text('Profile')),
        builder: (builder, controller) {
          return [
            Consumer<ProfileProvider>(
              builder: (context, profileProvider, _) {
                final isLoadingProfile = profileProvider
                    .isLoading(ProfileOperationType.getUserProfile);
                final errorMessageProfile = profileProvider
                    .getError(ProfileOperationType.getUserProfile);
                final userProfile = profileProvider.userProfile;

                if (isLoadingProfile) {
                  return SliverToBoxAdapter(child: ProfileSkeleton());
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
                  return SliverFillRemaining(
                    child: StyledEmptyData(message: 'Profile not found'),
                  );
                }

                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // * Pakenya itu background image kalo circle avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          userProfile.profilePicture,
                        ),
                      ),
                      SizedBox(height: 16),

                      Column(
                        children: [
                          Text(
                            userProfile.username,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            userProfile.email,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
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
                              onPressed: () {
                                context.push('/profile/update');
                              },
                              child: Text('Update'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: StyledButton(
                              onPressed: () {
                                context.read<AuthProvider>().signOut();
                              },
                              child: Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ];
        });
  }
}
