import 'package:book_app_basic_arch/core/shared/widgets/base_scaffold.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_empty_data.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_error_message.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_screen_layout_builder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_search_bar_placeholder.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sliver_app_bar.dart';
import 'package:book_app_basic_arch/core/shared/widgets/styled_sticky_sliver_container.dart';
import 'package:book_app_basic_arch/features/author/author_provider.dart';
import 'package:book_app_basic_arch/features/author/enums/author_operation_type.dart';
import 'package:book_app_basic_arch/features/author/enums/author_screen_type.dart';
import 'package:book_app_basic_arch/features/author/widgets/infinite_scroll_author_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthorScreen extends StatelessWidget {
  const AuthorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context
          .read<AuthorProvider>()
          .getAuthors(screen: AuthorScreenType.authors);
    });

    return BaseScaffold(
      body: StyledScreenLayoutBuilder(
        sliverAppBar: const StyledSliverAppBar(
          title: StyledSearchBarPlaceholder(),
        ),
        builder: (builder, controller) {
          return [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: StyledStickySliverContainer(
                height: 24,
                child: Text(
                  "Authors",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: Consumer<AuthorProvider>(
                  builder: (context, authorProvider, _) {
                final authors = authorProvider.getAuthorsForSpecificScreen(
                  AuthorScreenType.authors,
                );
                final isLoadingAuthor =
                    authorProvider.isLoading(AuthorOperationType.getAuthors);
                final errorMessage =
                    authorProvider.getError(AuthorOperationType.getAuthors);

                if (errorMessage != null) {
                  return SliverToBoxAdapter(
                    child: StyledErrorMessage(
                      errorMessage: errorMessage,
                      onRetry: () =>
                          context.read<AuthorProvider>().getAuthors(),
                    ),
                  );
                }

                if (authors.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: StyledEmptyData(message: 'No books found'));
                }

                return InfiniteScrollAuthorList(
                  authors: authors,
                  isLoading: isLoadingAuthor,
                  errorMessage: errorMessage,
                  onLoadMore: () =>
                      authorProvider.loadMoreAuthors(AuthorScreenType.authors),
                  onAuthorSelected: (author) {
                    context.push('/authors/${author.id}');
                  },
                  scrollController: controller,
                  onRetry: () => authorProvider.getAuthors(
                    screen: AuthorScreenType.authors,
                  ),
                );
              }),
            )
          ];
        },
      ),
    );
  }
}
