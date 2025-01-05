import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/profile/enums/profile_operation_type.dart';
import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  Future<void> _handleProfileUpdate() async {
    final username =
        _usernameController.text.isEmpty ? null : _usernameController.text;
    final email = _emailController.text.isEmpty ? null : _emailController.text;
    final profilePicture = _profilePictureController.text.isEmpty
        ? null
        : _profilePictureController.text;
    final bio = _bioController.text.isEmpty ? null : _bioController.text;

    await context
        .read<ProfileProvider>()
        .updateUserProfile(UpdateUserWithProfileModel(
          username: username,
          email: email,
          profilePicture: profilePicture,
          bio: bio,
        ));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _profilePictureController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(title: Text('Update profile')),
        builder: (builder, controller) {
          return [
            Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
              final isLoadingUpdateProfile = profileProvider
                  .isLoading(ProfileOperationType.updateUserProfile);
              final errorMessageUpdateProfile = profileProvider
                  .getError(ProfileOperationType.updateUserProfile);

              if (isLoadingUpdateProfile) {
                return StyledLoadingState();
              }

              if (errorMessageUpdateProfile != null) {
                return StyledErrorMessage(
                    errorMessage: errorMessageUpdateProfile);
              }

              return SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverToBoxAdapter(
                  child: Form(
                    child: Column(
                      children: [
                        // * Username
                        StyledTextFormField(
                          hintText: 'Username',
                          label: Text('Username'),
                          controller: _usernameController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          leadingIcon: Icon(
                            Icons.account_box,
                          ),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          hintText: 'Email',
                          label: Text('Email'),
                          controller: _emailController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          leadingIcon: Icon(
                            Icons.email_outlined,
                          ),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          hintText: 'masukkan link dari sebuah gambar',
                          label: Text('Profile picture'),
                          controller: _profilePictureController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          leadingIcon: Icon(
                            Icons.photo,
                          ),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          hintText: 'Bio',
                          label: Text('Bio'),
                          controller: _bioController,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          leadingIcon: Icon(
                            Icons.list,
                          ),
                        ),
                        const SizedBox(height: 16),

                        StyledButton(
                          onPressed: () {
                            _handleProfileUpdate();
                            context.go('/profile');
                          },
                          child: Text('Update'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            })
          ];
        },
      ),
    );
  }
}
