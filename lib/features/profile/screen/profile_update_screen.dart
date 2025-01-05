import 'dart:io';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:book_app_basic_arch/features/profile/profile_provider.dart';
import 'package:book_app_basic_arch/features/profile/enums/profile_operation_type.dart';
import 'package:book_app_basic_arch/features/profile/model/profile_model.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _ageController = TextEditingController();
  final _profilePictureController = TextEditingController();
  File? _imageFile;
  bool _isUrlImage = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFields();
    });
  }

  void _initializeFields() {
    final userProfile = context.read<ProfileProvider>().userProfile;
    if (userProfile != null) {
      _usernameController.text = userProfile.username;
      _emailController.text = userProfile.email;
      _bioController.text = userProfile.userProfile?.bio ?? '';
      _ageController.text = userProfile.userProfile?.age?.toString() ?? '';
      _profilePictureController.text = userProfile.profilePicture;
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024, // * Membatasi ukuran gambar
      maxHeight: 1024,
      imageQuality: 85, // * Kompresi kualitas
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _isUrlImage = false;
      });
    }
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }
    if (value.length < 3) {
      return 'Username minimal 3 karakter';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value != null && value.isNotEmpty) {
      final age = int.tryParse(value);
      if (age == null) {
        return 'Umur harus berupa angka';
      }
      if (age < 0 || age > 150) {
        return 'Umur harus di antara 0-150 tahun';
      }
    }
    return null;
  }

  String? _validateProfilePicture(String? value) {
    if (_isUrlImage) {
      if (value == null || value.isEmpty) {
        return 'URL foto profil tidak boleh kosong';
      }
      final urlRegex = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&// *=]*)$',
      );
      if (!urlRegex.hasMatch(value)) {
        return 'Format URL tidak valid';
      }
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updateModel = UpdateUserWithProfileModel(
        username: _usernameController.text,
        email: _emailController.text,
        bio: _bioController.text,
        age: int.tryParse(_ageController.text),
        // Hanya kirim URL jika menggunakan mode URL
        profilePicture: _isUrlImage ? _profilePictureController.text : null,
      );

      await context.read<ProfileProvider>().updateUserProfile(
            updateModel,
            profilePictureFile: _isUrlImage ? null : _imageFile,
          );

      if (!mounted) return;

      if (context
              .read<ProfileProvider>()
              .getError(ProfileOperationType.updateUserProfile) ==
          null) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StyledScreenLayoutBuilder(
      sliverAppBar: StyledSliverAppBar(title: Text('Update Profile')),
      builder: (context, controller) {
        return [
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              final isloadingUpdateProfile = profileProvider.isLoading(
                ProfileOperationType.updateUserProfile,
              );
              final errorMessageUpdateProfile = profileProvider.getError(
                ProfileOperationType.updateUserProfile,
              );
              final isloadingGetProfile = profileProvider.isLoading(
                ProfileOperationType.getUserProfile,
              );
              final errorMessageGetProfile = profileProvider.getError(
                ProfileOperationType.getUserProfile,
              );
              final profile = profileProvider.userProfile;

              if (isloadingGetProfile) {
                return SliverFillRemaining(child: StyledLoadingState());
              }

              if (errorMessageGetProfile != null) {
                return SliverFillRemaining(
                  child: StyledErrorMessage(
                    errorMessage: errorMessageGetProfile,
                    onRetry: () {
                      context.read<ProfileProvider>().getUserProfile();
                    },
                  ),
                );
              }

              if (profile == null) {
                return SliverFillRemaining(
                  child: StyledEmptyData(message: 'Profile not found'),
                );
              }

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // * Bagian Foto Profil
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_isUrlImage &&
                                _profilePictureController.text.isNotEmpty) ...[
                              ClipOval(
                                child: Image.network(
                                  _profilePictureController.text,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey[600],
                                        size: 30,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ] else if (_imageFile != null) ...[
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(_imageFile!),
                              ),
                            ] else ...[
                              CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(profile.profilePicture),
                              ),
                            ],
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: !_isUrlImage ? _pickImage : null,
                                icon: Icon(Icons.camera_alt),
                                style: IconButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // * Toggle antara URL dan File
                        SwitchListTile(
                          title: Text(_isUrlImage
                              ? 'Menggunakan URL'
                              : 'Menggunakan File Gambar'),
                          value: _isUrlImage,
                          onChanged: (value) {
                            setState(() {
                              _isUrlImage = value;
                              if (!value) {
                                _profilePictureController.clear();
                              }
                            });
                          },
                        ),

                        if (_isUrlImage) ...[
                          StyledTextFormField(
                            controller: _profilePictureController,
                            label: Text('URL Foto Profil'),
                            validator: _validateProfilePicture,
                          ),
                          SizedBox(height: 16),
                        ],

                        StyledTextFormField(
                          controller: _usernameController,
                          label: Text('Username'),
                          validator: _validateUsername,
                        ),
                        SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _emailController,
                          label: Text('Email'),
                          validator: _validateEmail,
                        ),
                        SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _bioController,
                          label: Text('Bio'),
                          maxLines: 3,
                        ),
                        SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _ageController,
                          label: Text('Umur'),
                          keyboardType: TextInputType.number,
                          validator: _validateAge,
                        ),
                        SizedBox(height: 32),

                        if (errorMessageUpdateProfile != null)
                          Text(errorMessageUpdateProfile),

                        StyledButton(
                          onPressed:
                              isloadingUpdateProfile ? null : _handleSubmit,
                          child: isloadingUpdateProfile
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text('Update Profile'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ];
      },
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _ageController.dispose();
    _profilePictureController.dispose();
    super.dispose();
  }
}
