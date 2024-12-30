import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/publisher/enums/publisher_operation_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/publisher/publisher_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String value) {
    if (value.isEmpty) return;

    final bookProvider = context.read<BookProvider>();
    final authorProvider = context.read<AuthorProvider>();
    final publisherProvider = context.read<PublisherProvider>();

    bookProvider.searchBooksByTitle(title: value.trim());
    authorProvider.searchAuthorsByName(name: value.trim());
    publisherProvider.searchPublishersByName(name: value.trim());
  }

  void _handleIconPress() {
    _searchController.clear();

    // Reset semua hasil pencarian
    final bookProvider = context.read<BookProvider>();
    final authorProvider = context.read<AuthorProvider>();
    final publisherProvider = context.read<PublisherProvider>();

    bookProvider.resetSearch();
    authorProvider.resetSearch();
    publisherProvider.resetSearch();
  }

  void _navigateToSearchResult(String query, String type) {
    switch (type) {
      case 'book':
        context.push('/books/search?q=$query');
        break;
      case 'author':
        context.push('/authors/search?q=$query');
        break;
      case 'publisher':
        context.push('/publishers/search?q=$query');
        break;
    }
  }

  void _navigateToDetailSceen(String id, String type) {
    switch (type) {
      case 'book':
        context.push('/books/$id');
        break;
      case 'author':
        context.push('/authors/$id');
        break;
      case 'publisher':
        context.push('/publishers/$id');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: StyledSliverAppBar(
          elevation: 0,
          title: StyledSearchBar(
            controller: _searchController,
            onChanged: _handleSearch,
            hintText: "Cari buku, genre, author, atau publisher",
            autoFocus: true,
            onIconPressed: _handleIconPress,
          ),
        ),
        builder: (builder, controller) {
          return [
            Consumer3<BookProvider, AuthorProvider, PublisherProvider>(
              builder: (context, bookProvider, authorProvider,
                  publisherProvider, _) {
                final isLoading =
                    bookProvider.isLoading(BookOperationType.searchBooks) ||
                        authorProvider
                            .isLoading(AuthorOperationType.searchAuthors) ||
                        publisherProvider
                            .isLoading(PublisherOperationType.searchPublishers);

                if (isLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final hasAnyResults = bookProvider.searchedBooks.isNotEmpty ||
                    authorProvider.searchedAuthors.isNotEmpty ||
                    publisherProvider.searchedPublishers.isNotEmpty;

                if (!hasAnyResults) {
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }

                return SliverList(
                  delegate: SliverChildListDelegate([
                    // * Books Section
                    if (bookProvider.searchedBooks.isNotEmpty) ...[
                      ListTile(
                        title: Text(
                          'Buku',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: TextButton(
                          onPressed: () => _navigateToSearchResult(
                            _searchController.text,
                            'book',
                          ),
                          child: const Text('Lihat Semua'),
                        ),
                      ),
                      ...bookProvider.searchedBooks.take(3).map(
                            (book) => ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.book,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              title: Text(book.title),
                              subtitle: const Text('Buku'),
                              onTap: () => _navigateToDetailSceen(
                                book.id,
                                'book',
                              ),
                            ),
                          ),
                    ],

                    // * Authors Section
                    if (authorProvider.searchedAuthors.isNotEmpty) ...[
                      ListTile(
                        title: Text(
                          'Penulis',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: TextButton(
                          onPressed: () => _navigateToSearchResult(
                            _searchController.text,
                            'author',
                          ),
                          child: const Text('Lihat Semua'),
                        ),
                      ),
                      ...authorProvider.searchedAuthors.take(3).map(
                            (author) => ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.green.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                              ),
                              title: Text(author.name),
                              subtitle: const Text('Penulis'),
                              onTap: () => _navigateToDetailSceen(
                                author.id,
                                'author',
                              ),
                            ),
                          ),
                    ],

                    // * Publishers Section
                    if (publisherProvider.searchedPublishers.isNotEmpty) ...[
                      ListTile(
                        title: Text(
                          'Penerbit',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: TextButton(
                          onPressed: () => _navigateToSearchResult(
                            _searchController.text,
                            'publisher',
                          ),
                          child: const Text('Lihat Semua'),
                        ),
                      ),
                      ...publisherProvider.searchedPublishers.take(3).map(
                            (publisher) => ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.business,
                                  color: Colors.blue,
                                ),
                              ),
                              title: Text(publisher.name),
                              subtitle: const Text('Penerbit'),
                              onTap: () => _navigateToDetailSceen(
                                publisher.id,
                                'publisher',
                              ),
                            ),
                          ),
                    ],
                  ]),
                );
              },
            ),
          ];
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
