import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/feature/auth/auth_provider.dart';
import 'package:book_app_basic_arch/feature/profile/model/profile_model.dart';
import 'package:book_app_basic_arch/feature/profile/profile_provider.dart';
import 'package:book_app_basic_arch/feature/profile/enum_profile_operation.dart';
import 'package:book_app_basic_arch/feature/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    // Fetch userProfile saat screen pertama kali diakses
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileProvider.getUserProfile();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("UserProfile"),
      ),
      body: RefreshIndicator(
        onRefresh: () => profileProvider.getUserProfile(),
        child: Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            final isLoadingUserProfile =
                provider.isLoading(EnumProfileOperation.getUserProfile);
            final errorMessageUserProfile =
                provider.getError(EnumProfileOperation.getUserProfile);
            final userProfile = provider.userProfile;

            print('profile error: $errorMessageUserProfile');

            if (isLoadingUserProfile) {
              // Loading State
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (errorMessageUserProfile != null) {
              // Error State
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Error: $errorMessageUserProfile",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.getUserProfile(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (userProfile != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileCard(
                    userWithProfileModel: UserWithProfileModel(
                      id: userProfile.id,
                      username: userProfile.username,
                      email: userProfile.email,
                      role: userProfile.role,
                      profilePicture: userProfile.profilePicture,
                      isVerified: userProfile.isVerified,
                      isEmailVerified: userProfile.isEmailVerified,
                      createdAt: userProfile.createdAt,
                      updatedAt: userProfile.updatedAt,
                      userProfile: userProfile.userProfile,
                    ),
                  ),
                  SizedBox(height: 16),
                  StyledButton(
                      onPressed: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .signOut();
                      },
                      child: Text('Logout'))
                ],
              );
            } else {
              // State kosong
              return const Center(
                child: Text("No userProfile found."),
              );
            }
          },
        ),
      ),
    );
  }
}
