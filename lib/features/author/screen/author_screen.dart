import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enum_author_operation.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authorProvider = Provider.of<AuthorProvider>(context, listen: false);

    // Fetch authors saat screen pertama kali diakses
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authorProvider.getAuthors();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Authors"),
      ),
      body: RefreshIndicator(
        onRefresh: () => authorProvider.getAuthors(),
        child: Consumer<AuthorProvider>(
          builder: (context, provider, _) {
            final isLoadingAuthors =
                provider.isLoading(EnumAuthorOperation.getAll);
            final errorMessageAuthors =
                provider.getError(EnumAuthorOperation.getAll);
            final authors = provider.authors;

            if (isLoadingAuthors) {
              // Loading State
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (errorMessageAuthors != null) {
              // Error State
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Error: $errorMessageAuthors",
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.getAuthors(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            if (authors.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        final author = authors[index];
                        return AuthorCard(
                          name: author.name,
                          biography: author.biography,
                          birthDate: author.birthDate,
                          deathDate: author.deathDate,
                          profilePicture: author.profilePicture,
                          onTap: () {
                            // Navigasi ke halaman detail author
                            context.go('/authors/${author.id}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              // State kosong
              return const Center(
                child: Text("No authors found."),
              );
            }
          },
        ),
      ),
    );
  }
}
