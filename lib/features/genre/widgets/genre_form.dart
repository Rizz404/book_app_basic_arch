import 'package:book_app_basic_arch/features/genre/genre_model.dart';
import 'package:book_app_basic_arch/features/genre/genre_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GenreForm extends StatefulWidget {
  final UpdateGenreModel? updateGenreModel;

  const GenreForm({super.key, this.updateGenreModel});

  @override
  State<GenreForm> createState() => _GenreFormState();
}

class _GenreFormState extends State<GenreForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.updateGenreModel != null) {
      _nameController.text = widget.updateGenreModel!.name!;
      _descriptionController.text = widget.updateGenreModel!.description!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.updateGenreModel != null ? 'Update Genre' : 'Create New Genre',
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description is required';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Tutup dialog
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.updateGenreModel != null) {
                // Logika update genre
                final updatedGenre = UpdateGenreModel(
                  id: widget.updateGenreModel!.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                );
                context
                    .read<GenreProvider>()
                    .updateGenre(updatedGenre); // Panggil fungsi update
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Genre successfully updated!')),
                );
              } else {
                // Logika create genre
                final newGenre = CreateGenreModel(
                  name: _nameController.text,
                  description: _descriptionController.text,
                );
                context.read<GenreProvider>().createGenre(newGenre);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Genre successfully created!')),
                );
              }

              Navigator.pop(context); // Tutup dialog
            }
          },
          child: Text(widget.updateGenreModel != null ? 'Update' : 'Submit'),
        ),
      ],
    );
  }
}
