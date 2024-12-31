import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_button.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_loading_state.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authorProvider = context.read<AuthorProvider>();
      final bookProvider = context.read<BookProvider>();

      authorProvider.getAuthorById(authorId);
      authorProvider.getAuthors(screen: AuthorScreenType.authorDetail);

      bookProvider.updateFilterForSpecificScreen(
        BookScreenType.authorDetail,
        bookProvider
            .getFilterForSpecificScreen(BookScreenType.authorDetail)
            .copyWith(authorId: authorId),
      );
      bookProvider.getBooks(screen: BookScreenType.authorDetail);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        builder: (builder, controller) {
          return [
            SliverToBoxAdapter(
              child: Consumer<AuthorProvider>(
                builder: (context, provider, _) {
                  final isLoadingAuthor =
                      provider.isLoading(AuthorOperationType.getAuthorById);
                  final errorMessageAuthor =
                      provider.getError(AuthorOperationType.getAuthorById);
                  final author = provider.author;

                  final isLoadingAuthors =
                      provider.isLoading(AuthorOperationType.getAuthors);
                  final errorMessageAuthors =
                      provider.getError(AuthorOperationType.getAuthors);
                  final authors = provider.getAuthorsForSpecificScreen(
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
                        onRetry: () => provider.getAuthors(
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
              builder: (context, provider, _) {
                final isLoading =
                    provider.isLoading(BookOperationType.getBooks);
                final errorMessage =
                    provider.getError(BookOperationType.getBooks);
                final books = provider
                    .getBooksForSpecificScreen(BookScreenType.authorDetail);

                return SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: InfiniteScrollBookGrid(
                    books: books,
                    isLoading: isLoading,
                    errorMessage: errorMessage,
                    onLoadMore: () => provider.loadMoreBooks(
                        screen: BookScreenType.authorDetail),
                    onBookSelected: (book) {
                      context.push('/books/${book.id}');
                    },
                    scrollController: controller,
                  ),
                );
              },
            ),
          ];
        },
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
                onPressed: () {},
                child: Text('Follow'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
