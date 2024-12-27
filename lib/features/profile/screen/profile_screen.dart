import 'package:book_app_basic_arch/core/constants/app_pallete.dart';
import 'package:book_app_basic_arch/core/shared/provider/theme_provider.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:book_app_basic_arch/features/profile/enum_profile_operation.dart';
import 'package:book_app_basic_arch/features/profile/widgets/profile_card.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                return _buildProfileContent(context, provider);
              },
            ),
            SizedBox(height: 16),
            StyledButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              child: Text('Logout'),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                StyledButton(
                  onPressed: () => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setTheme(AppPallete.ikuyoTheme),
                  child: Text('Change to ikuyo theme'),
                ),
                StyledButton(
                  onPressed: () => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setTheme(AppPallete.bocchiTheme),
                  child: Text('Change to bocchi theme'),
                ),
                StyledButton(
                  onPressed: () => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setTheme(AppPallete.nijikaTheme),
                  child: Text('Change to nijika theme'),
                ),
                StyledButton(
                  onPressed: () => Provider.of<ThemeProvider>(
                    context,
                    listen: false,
                  ).setTheme(AppPallete.ryoTheme),
                  child: Text('Change to ryo theme'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context, ProfileProvider provider) {
    final isLoadingUserProfile =
        provider.isLoading(EnumProfileOperation.getUserProfile);
    final errorMessageUserProfile =
        provider.getError(EnumProfileOperation.getUserProfile);
    final userProfile = provider.userProfile;

    if (isLoadingUserProfile) {
      return const StyledLoadingState();
    }

    if (errorMessageUserProfile != null) {
      return StyledErrorMessage(errorMessage: errorMessageUserProfile);
    }

    if (userProfile != null) {
      return ProfileCard(
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
      );
    } else {
      return const StyledEmptyData(message: 'No profile found');
    }
  }
}
