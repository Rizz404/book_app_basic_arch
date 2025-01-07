import 'dart:io';

import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_text_form_field.dart';
import 'package:book_app_basic_arch/features/genre/enums/genre_operation_type.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:book_app_basic_arch/features/genre/model/genre_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class GenreUpsertScreen extends StatefulWidget {
  final String? genreId;

  const GenreUpsertScreen({
    super.key,
    this.genreId,
  });

  @override
  State<GenreUpsertScreen> createState() => _GenreUpsertScreenState();
}

class _GenreUpsertScreenState extends State<GenreUpsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pictureController = TextEditingController();
  File? _imageFile;
  bool _isUrlImage = true;
  bool _isInitialized = false;

  // Getter untuk menentukan mode edit
  bool get isEditMode => widget.genreId?.isNotEmpty ?? false;

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
    if (!_isInitialized && widget.genreId != null) {
      final genre =
          context.read<GenreProvider>().getGenreByIdFromCache(widget.genreId!);

      if (genre != null) {
        _nameController.text = genre.name;
        _descriptionController.text = genre.description;
        _pictureController.text = genre.picture;
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
    final description = _descriptionController.text.trim();

    // Perbaiki logika picture
    String? picture;
    if (_isUrlImage) {
      // Jika mode URL, gunakan text dari controller
      picture = _pictureController.text.trim();
    }
    // Jika mode file dan create mode atau ada file baru, picture tetap null

    try {
      if (isEditMode && widget.genreId != null) {
        final updateModel = UpdateGenreModel(
          id: widget.genreId!,
          name: name,
          description: description,
          picture: _isUrlImage
              ? picture
              : null, // URL baru atau URL lama atau null jika upload file
        );

        await context.read<GenreProvider>().updateGenre(
              updateModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      } else {
        final createModel = CreateGenreModel(
          name: name,
          description: description,
          picture: picture, // URL atau null jika upload file
        );

        await context.read<GenreProvider>().createGenre(
              createModel,
              _isUrlImage
                  ? null
                  : _imageFile, // File baru atau null jika mode URL
            );
      }

      if (mounted) {
        final error = context.read<GenreProvider>().getError(
              isEditMode
                  ? GenreOperationType.updateGenreById
                  : GenreOperationType.createGenre,
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

  Widget _buildImageSection(GenreProvider provider) {
    Widget imageWidget;

    if (_isUrlImage && _pictureController.text.isNotEmpty) {
      imageWidget = _buildNetworkImage(_pictureController.text);
    } else if (_imageFile != null) {
      imageWidget = CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_imageFile!),
      );
    } else if (isEditMode && widget.genreId != null) {
      final genre = provider.getGenreByIdFromCache(widget.genreId!);
      imageWidget = genre != null
          ? CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(genre.picture),
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
        title: Text(isEditMode ? 'Edit Genre' : 'Tambah Genre'),
      ),
      builder: (context, controller) {
        return [
          Consumer<GenreProvider>(
            builder: (context, provider, _) {
              if (isEditMode) {
                if (provider.isLoading(GenreOperationType.getGenreById)) {
                  return const SliverFillRemaining(child: StyledLoadingState());
                }

                final errorMessage =
                    provider.getError(GenreOperationType.getGenreById);
                if (errorMessage != null) {
                  return SliverFillRemaining(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () => widget.genreId != null
                          ? provider.getGenreById(widget.genreId!)
                          : null,
                    ),
                  );
                }

                if (widget.genreId != null &&
                    provider.getGenreByIdFromCache(widget.genreId!) == null) {
                  return const SliverFillRemaining(
                    child: StyledEmptyData(message: 'Genre tidak ditemukan'),
                  );
                }
              }

              final operationType = isEditMode
                  ? GenreOperationType.updateGenreById
                  : GenreOperationType.createGenre;

              final isLoading = provider.isLoading(operationType);
              final errorMessage = provider.getError(operationType);

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                  : 'Tambah Genre'),
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
    super.dispose();
  }
}
