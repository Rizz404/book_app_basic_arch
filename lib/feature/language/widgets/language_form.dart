import 'package:book_app_basic_arch/feature/language/language_provider.dart';
import 'package:book_app_basic_arch/feature/language/model/language_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageForm extends StatefulWidget {
  final UpdateLanguageModel? updateLanguageModel;

  const LanguageForm({super.key, this.updateLanguageModel});

  @override
  State<LanguageForm> createState() => _LanguageFormState();
}

class _LanguageFormState extends State<LanguageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.updateLanguageModel != null
            ? 'Update Language'
            : 'Create New Language',
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
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  border: const OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
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
            if (_formKey.currentState!.validate()) {
              if (widget.updateLanguageModel != null) {
                final updatedLanguage = UpdateLanguageModel(
                  id: widget.updateLanguageModel!.id,
                  name: _nameController.text,
                  code: _codeController.text,
                );
                context
                    .read<LanguageProvider>()
                    .updateLanguage(updatedLanguage);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Language successfully updated!')),
                );
              } else {
                final newLanguage = CreateLanguageModel(
                  name: _nameController.text,
                  code: _codeController.text,
                );
                context.read<LanguageProvider>().createLanguage(newLanguage);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Language successfully created!')),
                );
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.updateLanguageModel != null ? 'Update' : 'Submit'),
        ),
      ],
    );
  }
}
