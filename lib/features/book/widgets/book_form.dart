import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookForm extends StatefulWidget {
  final UpdateBookModel? updateBookModel;

  const BookForm({super.key, this.updateBookModel});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.updateBookModel != null ? 'Update Book' : 'Create New Book',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
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
                controller: _stockController,
                decoration: const InputDecoration(
                  labelText: 'Birth Date',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Death Date (Optional)',
                  border: OutlineInputBorder(),
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
              if (widget.updateBookModel != null) {
                final updatedBook = UpdateBookModel(
                  id: widget.updateBookModel!.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  stock: int.parse(_stockController.text),
                  price: _priceController.text,
                );
                context.read<BookProvider>().updateBook(updatedBook);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Book successfully updated!')),
                );
              } else {
                // final newBook = CreateBookModel(
                //   title: _titleController.text,
                //   description: _descriptionController.text,
                //   stock: _stockController.text,
                //   price: _priceController.text.split(','),
                // );
                // context.read<BookProvider>().createBook(newBook);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(content: Text('Book successfully created!')),
                // );
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.updateBookModel != null ? 'Update' : 'Submit'),
        ),
      ],
    );
  }
}
