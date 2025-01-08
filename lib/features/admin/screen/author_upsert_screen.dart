import 'dart:io';

import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AuthorUpsertScreen extends StatefulWidget {
  final String? authorId;

  const AuthorUpsertScreen({
    super.key,
    this.authorId,
  });

  @override
  State<AuthorUpsertScreen> createState() => _AuthorUpsertScreenState();
}

class _AuthorUpsertScreenState extends State<AuthorUpsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _biographyController = TextEditingController();
  final _profilePictureController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _deathDateController = TextEditingController();
  File? _imageFile;
  bool _isUrlImage = true;
  bool _isInitialized = false;

  // Getter untuk menentukan mode edit
  bool get isEditMode => widget.authorId?.isNotEmpty ?? false;

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
    if (!_isInitialized && widget.authorId != null) {
      final author = context
          .read<AuthorProvider>()
          .getAuthorByIdFromCache(widget.authorId!);

      if (author != null) {
        _nameController.text = author.name;
        _biographyController.text = author.biography;
        _profilePictureController.text = author.profilePicture;
        _birthDateController.text = author.birthDate;
        _deathDateController.text = author.deathDate;
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
    final biography = value?.trim() ?? '';
    if (biography.isEmpty) {
      return 'Biografi tidak boleh kosong';
    }
    if (biography.length < 3) {
      return 'Biografi minimal 3 karakter';
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

  // Fungsi untuk memvalidasi format tanggal
  String? _validateDate(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }

    // Validasi format YYYY-MM-DD
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Format $fieldName harus YYYY-MM-DD';
    }

    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();

      if (date.isAfter(now)) {
        return '$fieldName tidak boleh lebih dari hari ini';
      }

      if (fieldName == 'Tanggal Meninggal' &&
          _birthDateController.text.isNotEmpty) {
        final birthDate = DateTime.parse(_birthDateController.text);
        if (date.isBefore(birthDate)) {
          return 'Tanggal meninggal tidak boleh sebelum tanggal lahir';
        }
      }
    } catch (e) {
      return 'Format $fieldName tidak valid';
    }

    return null;
  }

  // Fungsi untuk menampilkan date picker
  Future<void> _showDatePicker(
      TextEditingController controller, String title) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
      locale: const Locale('id', 'ID'),
      helpText: title,
    );

    if (picked != null) {
      // Format tanggal ke YYYY-MM-DD
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      controller.text = formattedDate;
    }
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _nameController.text.trim();
    final biography = _biographyController.text.trim();
    final birthDate = _birthDateController.text.trim();
    final deathDate = _deathDateController.text.trim();

    // Perbaiki logika profilePicture
    String? profilePicture;
    if (_isUrlImage) {
      // Jika mode URL, gunakan text dari controller
      profilePicture = _profilePictureController.text.trim();
    }
    // Jika mode file dan create mode atau ada file baru, profilePicture tetap null

    try {
      if (isEditMode && widget.authorId != null) {
        final updateModel = UpdateAuthorModel(
          id: widget.authorId!,
          name: name,
          biography: biography,
          birthDate: birthDate,
          deathDate: deathDate,
          profilePicture: _isUrlImage
              ? profilePicture
              : null, // URL baru atau URL lama atau null jika upload file
        );

        await context.read<AuthorProvider>().updateAuthor(
              updateModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      } else {
        final createModel = CreateAuthorModel(
          name: name,
          biography: biography,
          birthDate: birthDate,
          deathDate: deathDate,
          profilePicture: profilePicture, // URL atau null jika upload file
        );

        await context.read<AuthorProvider>().createAuthor(
              createModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      }

      if (mounted) {
        final error = context.read<AuthorProvider>().getError(
              isEditMode
                  ? AuthorOperationType.updateAuthorById
                  : AuthorOperationType.createAuthor,
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

  Widget _buildImageSection(AuthorProvider provider) {
    Widget imageWidget;

    if (_isUrlImage && _profilePictureController.text.isNotEmpty) {
      imageWidget = _buildNetworkImage(_profilePictureController.text);
    } else if (_imageFile != null) {
      imageWidget = CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_imageFile!),
      );
    } else if (isEditMode && widget.authorId != null) {
      final author = provider.getAuthorByIdFromCache(widget.authorId!);
      imageWidget = author != null
          ? CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(author.profilePicture),
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
        title: Text(isEditMode ? 'Edit Author' : 'Tambah Author'),
      ),
      builder: (context, controller) {
        return [
          Consumer<AuthorProvider>(
            builder: (context, provider, _) {
              if (isEditMode) {
                if (provider.isLoading(AuthorOperationType.getAuthorById)) {
                  return const SliverFillRemaining(child: StyledLoadingState());
                }

                final errorMessage =
                    provider.getError(AuthorOperationType.getAuthorById);
                if (errorMessage != null) {
                  return SliverFillRemaining(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () => widget.authorId != null
                          ? provider.getAuthorById(widget.authorId!)
                          : null,
                    ),
                  );
                }

                if (widget.authorId != null &&
                    provider.getAuthorByIdFromCache(widget.authorId!) == null) {
                  return const SliverFillRemaining(
                    child: StyledEmptyData(message: 'Author tidak ditemukan'),
                  );
                }
              }

              final operationType = isEditMode
                  ? AuthorOperationType.updateAuthorById
                  : AuthorOperationType.createAuthor;

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
                                _profilePictureController.clear();
                              }
                            });
                          },
                        ),
                        if (_isUrlImage) ...[
                          StyledTextFormField(
                            controller: _profilePictureController,
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
                          controller: _birthDateController,
                          label: const Text('Tanggal Lahir'),
                          validator: (value) =>
                              _validateDate(value, 'Tanggal Lahir'),
                          readOnly: true,
                          onTap: () => _showDatePicker(
                              _birthDateController, 'Pilih Tanggal Lahir'),
                          trailingIcon: const Icon(Icons.calendar_today),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _deathDateController,
                          label: const Text('Tanggal Meninggal'),
                          validator: (value) =>
                              _validateDate(value, 'Tanggal Meninggal'),
                          readOnly: true,
                          onTap: () => _showDatePicker(
                              _deathDateController, 'Pilih Tanggal Meninggal'),
                          trailingIcon: const Icon(Icons.calendar_today),
                        ),
                        const SizedBox(height: 16),

                        StyledTextFormField(
                          controller: _biographyController,
                          label: const Text('Biografi'),
                          validator: _validateDescription,
                          maxLines: 3,
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
                                  : 'Tambah Author'),
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
    _biographyController.dispose();
    _birthDateController.dispose();
    _deathDateController.dispose();
    _profilePictureController.dispose();
    super.dispose();
  }
}
