import 'package:book_app_basic_arch/feature/author/author_provider.dart';
import 'package:book_app_basic_arch/feature/author/enum_author_operation.dart';
import 'package:book_app_basic_arch/feature/author/model/author_model.dart';
import 'package:book_app_basic_arch/feature/author/widgets/author_card.dart';
import 'package:book_app_basic_arch/feature/author/widgets/author_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDetailScreen extends StatefulWidget {
  final String authorId;

  const AuthorDetailScreen({super.key, required this.authorId});

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthorProvider>().getAuthorById(widget.authorId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final authorProvider = context.read<AuthorProvider>();
          final author = authorProvider.author;

          if (author != null) {
            showDialog(
              context: context,
              builder: (context) => AuthorForm(
                updateAuthorModel: UpdateAuthorModel(
                  id: author.id,
                  name: author.name,
                  biography: author.biography,
                  birthDate: author.birthDate,
                  deathDate: author.deathDate,
                  profilePicture: author.profilePicture,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Author not loaded yet.')),
            );
          }
        },
        child: Icon(Icons.edit),
      ),
      body: Consumer<AuthorProvider>(
        builder: (context, provider, _) {
          final isLoadingAuthor =
              provider.isLoading(EnumAuthorOperation.getById);
          final errorMessageAuthor =
              provider.getError(EnumAuthorOperation.getById);
          final author = provider.author;

          if (isLoadingAuthor) {
            // Loading State
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (errorMessageAuthor != null) {
            // Error State
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: $errorMessageAuthor",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.getAuthorById(widget.authorId),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (author != null) {
            return AuthorCard(
              name: author.name,
              biography: author.biography,
              birthDate: author.birthDate,
              profilePicture: author.profilePicture,
            );
          } else {
            // State kosong
            return const Center(
              child: Text("No author found."),
            );
          }
        },
      ),
    );
  }
}
