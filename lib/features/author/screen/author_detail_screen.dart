import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/enums/author_screen_type.dart';
import 'package:book_app_basic_arch/features/author/model/author_model.dart';
import 'package:book_app_basic_arch/features/author/widgets/author_list_horizontal.dart';
import 'package:book_app_basic_arch/features/book/book_provider.dart';
import 'package:book_app_basic_arch/features/book/enums/book_operation_type.dart';
import 'package:book_app_basic_arch/features/book/enums/book_screen_type.dart';
import 'package:book_app_basic_arch/features/book/widgets/infinite_scroll_book_grid.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthorDetailScreen extends StatelessWidget {
  final String authorId;

  const AuthorDetailScreen({
    super.key,
    required this.authorId,
  });

  Future<void> _initializeData(BuildContext context) async {
    final authorProvider = context.read<AuthorProvider>();
    final bookProvider = context.read<BookProvider>();

    await authorProvider.getAuthorById(authorId);
    await authorProvider.getAuthors(screen: AuthorScreenType.authorDetail);

    final currentFilter = bookProvider.getFilterForSpecificScreen(
      BookScreenType.authorDetail,
    );

    if (currentFilter.authorId != authorId) {
      bookProvider.updateFilterForSpecificScreen(
        BookScreenType.authorDetail,
        currentFilter.copyWith(authorId: authorId, page: 1),
      );

      await bookProvider.getBooks(screen: BookScreenType.authorDetail);
    }
  }

  Future<void> _handleRefresh(BuildContext context) async {
    await Future.wait([
      context.read<AuthorProvider>().getAuthorById(authorId),
      context.read<BookProvider>().getBooks(
            screen: BookScreenType.authorDetail,
          ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData(context);
    });

    return BaseScaffold(
      body: RefreshIndicator(
        onRefresh: () => _handleRefresh(context),
        child: StyledScreenLayoutBuilder(
          sliverAppBar: StyledSliverAppBar(
            title: StyledSearchBarPlaceholder(
              hintText: "Hinted search text",
            ),
          ),
          builder: (builder, controller) {
            return [
              SliverToBoxAdapter(
                child: Consumer<AuthorProvider>(
                  builder: (context, authorProvider, _) {
                    final isLoadingAuthor = authorProvider
                        .isLoading(AuthorOperationType.getAuthorById);
                    final errorMessageAuthor = authorProvider
                        .getError(AuthorOperationType.getAuthorById);
                    final author = authorProvider.author;

                    final isLoadingAuthors = authorProvider
                        .isLoading(AuthorOperationType.getAuthors);
                    final errorMessageAuthors =
                        authorProvider.getError(AuthorOperationType.getAuthors);
                    final authors = authorProvider.getAuthorsForSpecificScreen(
                        AuthorScreenType.authorDetail);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAuthorCard(
                          context,
                          isLoadingAuthor,
                          errorMessageAuthor,
                          author,
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Similar Authors",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(height: 16),
                        AuthorListHorizontal(
                          isLoading: isLoadingAuthors,
                          errorMessage: errorMessageAuthors,
                          authors: authors,
                          onRetry: () => authorProvider.getAuthors(
                              screen: AuthorScreenType.authorDetail),
                          onAuthorSelected: (authorId) => context.push(
                            '/authors/$authorId',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: 32,
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Our Books",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final isLoading =
                      bookProvider.isLoading(BookOperationType.getBooks);
                  final errorMessage =
                      bookProvider.getError(BookOperationType.getBooks);
                  final books = bookProvider
                      .getBooksForSpecificScreen(BookScreenType.authorDetail);

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    sliver: InfiniteScrollBookGrid(
                      books: books,
                      isLoading: isLoading,
                      errorMessage: errorMessage,
                      onLoadMore: () async => await bookProvider
                          .loadMoreBooks(BookScreenType.authorDetail),
                      onBookSelected: (book) {
                        context.push('/books/${book.id}');
                      },
                      scrollController: controller,
                      onRetry: () async => await bookProvider.getBooks(
                        screen: BookScreenType.authorDetail,
                      ),
                    ),
                  );
                },
              ),
            ];
          },
        ),
      ),
    );
  }

  Widget _buildAuthorCard(
    BuildContext context,
    bool isLoading,
    String? errorMessage,
    AuthorModel? author,
  ) {
    if (isLoading) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledLoadingState(),
        ),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 300,
        child: Center(
          child: StyledErrorMessage(
            errorMessage: errorMessage,
            onRetry: () {
              context.read<AuthorProvider>().getAuthorById(authorId);
            },
          ),
        ),
      );
    }

    if (author == null) {
      return const SizedBox(
        height: 300,
        child: Center(
          child: StyledEmptyData(message: 'Author not found'),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  author.profilePicture,
                  fit: BoxFit.cover,
                  width: 120,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 6),
                    Text(
                      author.biography,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Birthday: ${author.birthDate}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Death: ${author.deathDate}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline),
                      Text(
                        '${author.followerCount}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Followers',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              StyledButton(
                onPressed: () {
                  context.read<AuthorProvider>().toggleFollowAuthor(authorId);
                },
                child: Text(author.isFollowedAuthor ? 'unfollow' : 'follow'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
