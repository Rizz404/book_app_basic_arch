import 'package:book_app_basic_arch/feature/publisher/publisher_provider.dart';
import 'package:book_app_basic_arch/feature/publisher/model/publisher_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublisherForm extends StatefulWidget {
  final UpdatePublisherModel? updatePublisherModel;

  const PublisherForm({super.key, this.updatePublisherModel});

  @override
  State<PublisherForm> createState() => _PublisherFormState();
}

class _PublisherFormState extends State<PublisherForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.updatePublisherModel != null
            ? 'Update Publisher'
            : 'Create New Publisher',
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
                controller: _descriptionController,
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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Birth Date',
                  border: const OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _websiteController,
                decoration: InputDecoration(
                  labelText: 'Death Date (Optional)',
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
              if (widget.updatePublisherModel != null) {
                final updatedPublisher = UpdatePublisherModel(
                  id: widget.updatePublisherModel!.id,
                  name: _nameController.text,
                  description: _descriptionController.text,
                  email: _emailController.text,
                  website: _websiteController.text.split(','),
                );
                context
                    .read<PublisherProvider>()
                    .updatePublisher(updatedPublisher);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Publisher successfully updated!')),
                );
              } else {
                final newPublisher = CreatePublisherModel(
                  name: _nameController.text,
                  description: _descriptionController.text,
                  email: _emailController.text,
                  website: _websiteController.text.split(','),
                );
                context.read<PublisherProvider>().createPublisher(newPublisher);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Publisher successfully created!')),
                );
              }
              Navigator.pop(context);
            }
          },
          child:
              Text(widget.updatePublisherModel != null ? 'Update' : 'Submit'),
        ),
      ],
    );
  }
}
