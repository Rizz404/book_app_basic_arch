import 'package:book_app_basic_arch/core/shared/widgets/styled_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/features/auth/auth_provider.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:book_app_basic_arch/features/profile/enum_profile_operation.dart';
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
      appBar: StyledAppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 16),
            // * Profile
            Consumer<ProfileProvider>(
              builder: (context, provider, _) {
                return _buildProfileContent(context, provider);
              },
            ),
            SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: StyledButton(
                    onPressed: () {},
                    child: Text('Update'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: StyledButton(
                    onPressed: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .signOut();
                    },
                    child: Text('Logout'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
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
      return Column(
        children: [
          // * Pakenya itu background image kalo circle avatar
          CircleAvatar(
            radius: 120,
            backgroundImage: NetworkImage(
              userProfile.profilePicture,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Text(
                userProfile.username,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Text(
                userProfile.email,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          )
        ],
      );
    } else {
      return const StyledEmptyData(message: 'No profile found');
    }
  }
}
