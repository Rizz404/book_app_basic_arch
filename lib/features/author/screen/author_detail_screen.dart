import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enum_author_operation.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_form.dart';
import 'package:book_app_basic_arch/features/author/widgets/book_author_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorDetailScreen extends StatefulWidget {
  final String authorId;
  const AuthorDetailScreen({super.key, required this.authorId});

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  late ScrollController _scrollController;
  bool _isDescriptionVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthorProvider>().getAuthorById(widget.authorId);
    });
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && _isDescriptionVisible) {
      setState(() => _isDescriptionVisible = false);
    } else if (_scrollController.offset <= 50 && !_isDescriptionVisible) {
      setState(() => _isDescriptionVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author'),
      ),
      floatingActionButton: Consumer<AuthorProvider>(
        builder: (context, provider, _) => FloatingActionButton(
          onPressed: () {
            final author = provider.author;
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
          child: const Icon(Icons.edit),
        ),
      ),
      body: Column(
        children: [
          Consumer<AuthorProvider>(
            builder: (context, provider, _) {
              return _buildAuthorContent(context, provider);
            },
          ),
          Expanded(
            child: BookAuthorList(
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthorContent(BuildContext context, AuthorProvider provider) {
    final isLoadingAuthor = provider.isLoading(EnumAuthorOperation.getById);
    final errorMessageAuthor = provider.getError(EnumAuthorOperation.getById);
    final author = provider.author;

    if (isLoadingAuthor) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessageAuthor != null) {
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

    if (author == null) {
      return const Center(child: Text("No author found."));
    }

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header - Selalu Terlihat
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Profile Picture
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    image: author.profilePicture != null
                        ? DecorationImage(
                            image: NetworkImage(author.profilePicture!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: author.profilePicture == null
                      ? Icon(
                          Icons.person,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      if (author.birthDate != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          author.birthDate,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Author Details - Menghilang saat scroll
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: _isDescriptionVisible
                ? Container(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        const SizedBox(height: 8),
                        Text(
                          'Biography',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          author.biography,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                        ),
                        if (author.deathDate != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Passed away: ${author.deathDate}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
