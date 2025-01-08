import 'dart:io';

import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/features/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PublisherUpsertScreen extends StatefulWidget {
  final String? publisherId;

  const PublisherUpsertScreen({
    super.key,
    this.publisherId,
  });

  @override
  State<PublisherUpsertScreen> createState() => _PublisherUpsertScreenState();
}

class _PublisherUpsertScreenState extends State<PublisherUpsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _websiteController = TextEditingController();
  final _pictureController = TextEditingController();
  File? _imageFile;
  bool _isUrlImage = true;
  bool _isInitialized = false;

  // Getter untuk menentukan mode edit
  bool get isEditMode => widget.publisherId?.isNotEmpty ?? false;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeFields();
      });
    }
  }

  void _initializeFields() {
    if (!_isInitialized && widget.publisherId != null) {
      final publisher = context
          .read<PublisherProvider>()
          .getPublisherByIdFromCache(widget.publisherId!);

      if (publisher != null) {
        _nameController.text = publisher.name;
        _emailController.text = publisher.email;
        _descriptionController.text = publisher.description;
        _websiteController.text = publisher.website != null
            ? publisher.website.join(', ') // Pastikan website adalah List
            : ''; // Gabungkan website dengan koma
        _pictureController.text = publisher.picture;
        _isInitialized = true;
      }
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        _isUrlImage = false;
      });
    }
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (name.length < 3) {
      return 'Nama minimal 3 karakter';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    final description = value?.trim() ?? '';
    if (description.isEmpty) {
      return 'Deskripsi tidak boleh kosong';
    }
    if (description.length < 3) {
      return 'Deskripsi minimal 3 karakter';
    }
    return null;
  }

  // Validasi email
  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // Validasi website
  String? _validateWebsite(String? value) {
    final websites = value?.trim() ?? '';
    if (websites.isEmpty) {
      return 'Website tidak boleh kosong';
    }

    final websiteList = websites.split(',').map((e) => e.trim()).toList();

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&// *=]*)$',
    );

    for (var website in websiteList) {
      if (!urlRegex.hasMatch(website)) {
        return 'Format URL website tidak valid: $website';
      }
    }

    return null;
  }

  String? _validatePicture(String? value) {
    if (!_isUrlImage) return null;

    final url = value?.trim() ?? '';
    if (url.isEmpty) {
      return 'URL foto tidak boleh kosong';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&// *=]*)$',
    );
    if (!urlRegex.hasMatch(url)) {
      return 'Format URL tidak valid';
    }
    return null;
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final description = _descriptionController.text.trim();
    // Konversi string website yang dipisahkan koma menjadi List
    final websiteList = _websiteController.text
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // Perbaiki logika picture
    String? picture;
    if (_isUrlImage) {
      // Jika mode URL, gunakan text dari controller
      picture = _pictureController.text.trim();
    }
    // Jika mode file dan create mode atau ada file baru, picture tetap null

    try {
      if (isEditMode && widget.publisherId != null) {
        final updateModel = UpdatePublisherModel(
          id: widget.publisherId!,
          name: name,
          email: email,
          description: description,
          website: websiteList,
          picture: _isUrlImage ? picture : null,
        );

        await context.read<PublisherProvider>().updatePublisher(
              updateModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      } else {
        final createModel = CreatePublisherModel(
          name: name,
          email: email,
          description: description,
          website: websiteList,
          picture: picture,
        );

        await context.read<PublisherProvider>().createPublisher(
              createModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      }

      if (mounted) {
        final error = context.read<PublisherProvider>().getError(
              isEditMode
                  ? PublisherOperationType.updatePublisherById
                  : PublisherOperationType.createPublisher,
            );

        if (error == null) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
        );
      }
    }
  }

  Widget _buildImageSection(PublisherProvider provider) {
    Widget imageWidget;

    if (_isUrlImage && _pictureController.text.isNotEmpty) {
      imageWidget = _buildNetworkImage(_pictureController.text);
    } else if (_imageFile != null) {
      imageWidget = CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_imageFile!),
      );
    } else if (isEditMode && widget.publisherId != null) {
      final publisher = provider.getPublisherByIdFromCache(widget.publisherId!);
      imageWidget = publisher != null
          ? CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(publisher.picture),
            )
          : const CircleAvatar(
              radius: 60,
              child: Icon(Icons.image),
            );
    } else {
      imageWidget = const CircleAvatar(
        radius: 60,
        child: Icon(Icons.image),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        imageWidget,
        Positioned(
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: !_isUrlImage ? _pickImage : null,
            icon: const Icon(Icons.camera_alt),
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNetworkImage(String url) {
    return ClipOval(
      child: Image.network(
        url,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[600],
              size: 30,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StyledScreenLayoutBuilder(
      sliverAppBar: StyledSliverAppBar(
        title: Text(isEditMode ? 'Edit Publisher' : 'Tambah Publisher'),
      ),
      builder: (context, controller) {
        return [
          Consumer<PublisherProvider>(
            builder: (context, provider, _) {
              if (isEditMode) {
                if (provider
                    .isLoading(PublisherOperationType.getPublisherById)) {
                  return const SliverFillRemaining(child: StyledLoadingState());
                }

                final errorMessage =
                    provider.getError(PublisherOperationType.getPublisherById);
                if (errorMessage != null) {
                  return SliverFillRemaining(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () => widget.publisherId != null
                          ? provider.getPublisherById(widget.publisherId!)
                          : null,
                    ),
                  );
                }

                if (widget.publisherId != null &&
                    provider.getPublisherByIdFromCache(widget.publisherId!) ==
                        null) {
                  return const SliverFillRemaining(
                    child:
                        StyledEmptyData(message: 'Publisher tidak ditemukan'),
                  );
                }
              }

              final operationType = isEditMode
                  ? PublisherOperationType.updatePublisherById
                  : PublisherOperationType.createPublisher;

              final isLoading = provider.isLoading(operationType);
              final errorMessage = provider.getError(operationType);

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // * Imagenya
                        _buildImageSection(provider),
                        const SizedBox(height: 16),

                        SwitchListTile(
                          title: Text(_isUrlImage
                              ? 'Menggunakan URL'
                              : 'Menggunakan File Gambar'),
                          value: _isUrlImage,
                          onChanged: (value) {
                            setState(() {
                              _isUrlImage = value;
                              if (!value) {
                                _pictureController.clear();
                              }
                            });
                          },
                        ),
                        if (_isUrlImage) ...[
                          StyledTextFormField(
                            controller: _pictureController,
                            label: const Text('URL Foto'),
                            validator: _validatePicture,
                          ),
                          const SizedBox(height: 16),
                        ],
                        StyledTextFormField(
                          controller: _nameController,
                          label: const Text('Nama'),
                          validator: _validateName,
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _descriptionController,
                          label: const Text('Deskripsi'),
                          validator: _validateDescription,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _emailController,
                          label: const Text('Email'),
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          leadingIcon: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _websiteController,
                          label: const Text('Website'),
                          hintText:
                              'https://website1.com, https://website2.com',
                          validator: _validateWebsite,
                          keyboardType: TextInputType.url,
                          leadingIcon: const Icon(Icons.link),
                        ),
                        const SizedBox(height: 16),

                        if (errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error),
                            ),
                          ),
                        StyledButton(
                          onPressed: isLoading ? null : _handleSubmit,
                          child: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(isEditMode
                                  ? 'Simpan Perubahan'
                                  : 'Tambah Publisher'),
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
    _nameController.dispose();
    _descriptionController.dispose();
    _pictureController.dispose();
    _emailController.dispose(); // Tambahkan ini
    _websiteController.dispose(); // Tambahkan ini
    super.dispose();
  }
}
