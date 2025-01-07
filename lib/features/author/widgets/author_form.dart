import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AuthorForm extends StatefulWidget {
  final UpdateAuthorModel? updateAuthorModel;

  const AuthorForm({super.key, this.updateAuthorModel});

  @override
  State<AuthorForm> createState() => _AuthorFormState();
}

class _AuthorFormState extends State<AuthorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _deathDateController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();

  DateTime? _selectedBirthDate;
  DateTime? _selectedDeathDate;

  @override
  void initState() {
    super.initState();
    if (widget.updateAuthorModel != null) {
      _nameController.text = widget.updateAuthorModel!.name!;
      _biographyController.text = widget.updateAuthorModel!.biography!;

      // Parse tanggal dari string ke DateTime
      if (widget.updateAuthorModel!.birthDate != null) {
        _selectedBirthDate =
            DateTime.parse(widget.updateAuthorModel!.birthDate!);
        _birthDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedBirthDate!);
      }

      if (widget.updateAuthorModel!.deathDate != null) {
        _selectedDeathDate =
            DateTime.parse(widget.updateAuthorModel!.deathDate!);
        _deathDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDeathDate!);
      }

      _profilePictureController.text =
          widget.updateAuthorModel!.profilePicture ?? '';
    }
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

  Future<void> _selectDate(BuildContext context, bool isBirthDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isBirthDate
          ? _selectedBirthDate ?? DateTime.now()
          : _selectedDeathDate ?? DateTime.now(),
      firstDate: DateTime(1000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isBirthDate) {
          _selectedBirthDate = picked;
          _birthDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          _selectedDeathDate = picked;
          _deathDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  bool _validateDates() {
    if (_selectedBirthDate != null && _selectedDeathDate != null) {
      if (_selectedDeathDate!.isBefore(_selectedBirthDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Death date cannot be before birth date')),
        );
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.updateAuthorModel != null
            ? 'Update Author'
            : 'Create New Author',
      ),
      content: SingleChildScrollView(
        child: Form(
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
                controller: _biographyController,
                decoration: const InputDecoration(
                  labelText: 'Biography',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Biography is required';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _birthDateController,
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _deathDateController,
                decoration: InputDecoration(
                  labelText: 'Death Date (Optional)',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ),
                readOnly: true,
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _profilePictureController,
                decoration: const InputDecoration(
                  labelText: 'Profile Picture URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() && _validateDates()) {
              if (widget.updateAuthorModel != null) {
                final updatedAuthor = UpdateAuthorModel(
                  id: widget.updateAuthorModel!.id,
                  name: _nameController.text,
                  biography: _biographyController.text,
                  birthDate: _birthDateController.text,
                  deathDate: _deathDateController.text.isNotEmpty
                      ? _deathDateController.text
                      : null,
                  profilePicture: _profilePictureController.text.isNotEmpty
                      ? _profilePictureController.text
                      : null,
                );
                context.read<AuthorProvider>().updateAuthor(updatedAuthor);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Author successfully updated!')),
                );
              } else {
                final newAuthor = CreateAuthorModel(
                  name: _nameController.text,
                  biography: _biographyController.text,
                  birthDate: _birthDateController.text,
                  deathDate: _deathDateController.text,
                  profilePicture: _profilePictureController.text,
                );
                context.read<AuthorProvider>().createAuthor(newAuthor);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Author successfully created!')),
                );
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.updateAuthorModel != null ? 'Update' : 'Submit'),
        ),
      ],
    );
  }
}
